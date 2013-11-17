# Pdf::Reader::Markup

A markup extension for the PDF::Reader library.

As well as continuing to support fetching a collection of lines for an 
individual page in a PDF file, this adds the method formatted_lines
which uses HTML-style tags to mark up bold and italic text.

## Installation

Add this line to your application's Gemfile:

    gem 'pdf-reader-markup'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pdf-reader-markup

## Usage

Require the gem in the source file that contains the PDF-handling code:

    require 'pdf/reader/markup'

You should now be able to use the custom MarkupPage handler to get back 
matching plaintext and formatted lines for each page:

    pdf = PDF::Reader.new("./spec/sample docs/Dorian_Gray_excerpt.pdf")
    page = PDF::Reader::MarkupPage.new(pdf.pages[1])
    
    # slightly modified version of the lines() method 
    lines_of_plaintext = page.lines()
    
    #the new formatted_line() method
    lines_with_markup = page.formatted_lines()
    
    # and not forgetting content() which will return the all the lines as
    # a solid block of text
    entire_page_text = page.content()
    
    # and its formatted equivalent markup
    entired_page_markup = page.markup()
    
Note that you can still access the original PDF::Reader methods within the 
same project by using `PDF::Reader::PageTextReceiver` and walking the page,
giving access to the standard content and lines as functionality.

You can also, if you prefer, use the 
`Reader::MarkupPage::PageBoldItalicReceiver` receiver directly rather than 
using the PDF::Reader::MarkupPage wrapper.
