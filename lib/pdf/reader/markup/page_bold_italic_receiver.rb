#encoding: utf-8

require "pdf/reader"
require "nokogiri"

module PDF
  class Reader
    class MarkupPage
      class PageBoldItalicReceiver < PDF::Reader::PageTextReceiver
        def page=(page)
          super(page)
          @last_tag_end = ""
          @open_tag = ""
          @lasty = 0.0
          @footer = []
          @text = []
          @lines = []
        end
      
        def markup
          unless @text.empty?
            line = fix_markup("#{@text.join("").strip}#{@last_tag_end}")
            @lines << line
            @text = []
          end
          %Q|#{@lines.join("\n")}\n#{@footer.join("")}|
        end
      
        def content
          lines = super.lines.to_a
          fixed = []
          current_line = 0
          offset = 0
          formatted_lines = markup.lines.to_a
          lines.each_with_index do |line, index|
            formatted_line = formatted_lines[index + offset]
            if line.strip == "" and (formatted_line and formatted_lines[index + offset].strip != "")
              offset -= 1
            else
              fixed << line
            end
          end
          fixed.join("")
        end
      
      
        private
      
        def fix_markup(string)
          #get Nokogiri to close any open tags
          string = Nokogiri::HTML::fragment(string).to_html
        
          #strip empty markup tags
          string.gsub(/<(?:b|i)>\s*<\/(?:b|i)>/, "").strip
        end
      
        def font_type(font, type)
          if font.basefont.to_s.include?(type)
            return true
          end
          false
        end
      
        def markup_tags(font)
          open = ""
          close = ""
          if font_type(@state.current_font, "Bold")
            open = "<b>"
            close = "</b>"
          end
          if font_type(@state.current_font, "Italic")
            open = "#{open}<i>"
            close = "</i>#{close}"
          end
          {:open => open, :close => close}
        end
      
        def append_line(tags, run)
          line = fix_markup("#{@text.join("").strip}#{@last_tag_end}")
          @lines << line
          @last_tag_end = ""
          @text = ["#{tags[:open]}#{run.to_s}"]
        end
      
        def internal_show_text(string)
          if @state.current_font.nil?
            raise PDF::Reader::MalformedPDFError, "current font is invalid"
          end
          glyphs = @state.current_font.unpack(string)
          text = ""
          glyphs.each_with_index do |glyph_code, index|
            # paint the current glyph
            newx, newy = @state.trm_transform(0,0)
            utf8_chars = @state.current_font.to_utf8(glyph_code)
          
            # apply to glyph displacment for the current glyph so the next
            # glyph will appear in the correct position
            glyph_width = @state.current_font.glyph_width(glyph_code) / 1000.0
            th = 1
            scaled_glyph_width = glyph_width * @state.font_size * th
            run = TextRun.new(newx, newy, scaled_glyph_width, @state.font_size, utf8_chars)
            @characters << run
            @state.process_glyph_displacement(glyph_width, 0, utf8_chars == SPACE)
          
            build_markup(newy, run)
          end
        end
      
        def build_markup(newy, run)
          tags = markup_tags(@state.current_font)
          if tags[:open] == @open_tag
            if newy < 50
              @footer << run.to_s
            else
              if newy < @lasty
                append_line(tags, run)
              else
                @text << "#{run.to_s}"
              end
            end
          else
            if newy < 50
              @footer << "#{@last_tag_end}#{run.to_s}"
            else
              if newy < @lasty
                append_line(tags, run)
              else
                @text << "#{@last_tag_end}#{tags[:open]}#{run.to_s}"
              end
            end
            @last_tag_end = tags[:close]
          end
          @open_tag = tags[:open]
          @lasty = newy
        end
      end
    end
  end
end