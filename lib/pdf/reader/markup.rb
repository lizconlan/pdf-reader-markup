#encoding: utf-8
require "pdf/reader/markup/version"
require "pdf/reader/markup/page_bold_italic_receiver.rb"

module PDF # :nodoc:
  class Reader # :nodoc:
    class MarkupPage
      ##
      # Returns the plaintext content of the page
      attr_reader :content
    
      ##
      # Returns the formatted lines for the page
      # as an array
      attr_reader :formatted_lines
    
      ##
      # Returns the plaintext lines for the page
      # as an array
      attr_reader :lines
    
      ##
      # Returns the formatted content of the page
      attr_reader :markup
    
      ##
      # Wrapper function for walking the page with the 
      # Reader::MarkupPage::PageBoldItalicReceiver receiver
      def initialize(page)
        receiver = PageBoldItalicReceiver.new()
        page.walk(receiver)
        @content = receiver.content
        @markup = receiver.markup
        @lines = @content.lines.to_a
        @formatted_lines = @markup.lines.to_a
      end
    end
  end
end