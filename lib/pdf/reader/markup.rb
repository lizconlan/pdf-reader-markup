#encoding: utf-8
require "pdf/reader/markup/version"
require "pdf/reader/markup/page_bold_italic_receiver.rb"

module PDF
  class Reader::MarkupPage
    attr_reader :lines, :formatted_lines
      
    def initialize(page)
      receiver = PageBoldItalicReceiver.new()
      page.walk(receiver)
      @lines = receiver.content.lines.to_a
      @formatted_lines = receiver.markup.lines.to_a
    end
  end
end