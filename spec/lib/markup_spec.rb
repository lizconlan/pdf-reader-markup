#encoding: utf-8
require_relative "../rspec_helper.rb"

require './lib/pdf/reader/markup.rb'

describe "MarkupPage" do
  context "when given an excerpt from The Canterville Ghost" do
    before(:all) do
      @pdf = PDF::Reader.new("./spec/sample docs/canterville-ghost-excerpt.pdf")
    end
    
    context "reading the first page" do
      before(:all) do
        @pdf_page = PDF::Reader::MarkupPage.new(@pdf.pages[0])
      end
      
      it "should find 8 lines of text" do
        @pdf_page.lines.count.should eq 8
        @pdf_page.formatted_lines.count.should eq 8
      end
      
      it "should find a mixture of plain and italic text" do
        @pdf_page.formatted_lines[0].should eq "The Canterville Ghost\n"
        @pdf_page.formatted_lines[1].should eq "<i>An amusing chronicle of the tribulations of the Ghost of Canterville Chase when his ancestral halls became the</i>\n"
        @pdf_page.formatted_lines[2].should eq "<i>home of the American Minister to the Court of St. James</i>\n"
      end
    end
    
    context "reading the second page" do
      before(:all) do
        @pdf_page = PDF::Reader::MarkupPage.new(@pdf.pages[1])
      end
      
      it "should find 16 lines of text" do
        @pdf_page.lines.count.should eq 16
        @pdf_page.formatted_lines.count.should eq 16
      end
      
      it "should correctly relocate the footer to the end of the text block" do
        @pdf_page.lines.last.should eq "The Pennsylvania State University is an equal opportunity university."
      end
    end
  end
  
  context "when given an excerpt from The Picture of Dorian Gray" do
    before(:all) do
      @pdf = PDF::Reader.new("./spec/sample docs/Dorian_Gray_excerpt.pdf")
    end
    
    context "reading the second page" do
      before(:all) do
        @pdf_page = PDF::Reader::MarkupPage.new(@pdf.pages[1])
      end
      
      it "should find 24 lines of text" do
        @pdf_page.lines.count.should eq 24
        @pdf_page.formatted_lines.count.should eq 24
      end
      
      it "should find a mixture of plain, bold and italic text" do
        @pdf_page.formatted_lines[0].should eq "<i>The Picture of Dorian Gray</i>\n"
        @pdf_page.formatted_lines[1].should eq "<b>Chapter I</b>\n"
        @pdf_page.formatted_lines[2].should eq "The studio was filled with the rich odor of roses, and\n"
        @pdf_page.formatted_lines[3].should eq "when the light summer wind stirred amidst the trees of the\n"
        @pdf_page.formatted_lines[4].should eq "garden there came through the open door the heavy scent\n"
        @pdf_page.formatted_lines[5].should eq "of the lilac, or the more delicate perfume of the pink-\n"
        @pdf_page.formatted_lines[6].should eq "flowering thorn.\n"
      end
    end
  end
  
  context "when given a House of Lords Forthcoming Business document" do
    before(:all) do
      @pdf = PDF::Reader.new("./spec/sample docs/Lords-Forthcoming-Business.pdf")
    end
    
    context "reading the first page" do
      before(:all) do
        @pdf_page = PDF::Reader::MarkupPage.new(@pdf.pages[0])
      end
      
      it "should find 32 lines of text" do
        @pdf_page.lines.count.should eq 32
        @pdf_page.formatted_lines.count.should eq 32
      end
      
      it "should find a mixture of plain, bold and italic text" do
        @pdf_page.lines[0].should eq "                   GOVERNMENT WHIPS’ OFFICE\n"
        @pdf_page.formatted_lines[0].should eq "GOVERNMENT WHIPS’ OFFICE\n"
        
        @pdf_page.lines[3].should eq "                     FORTHCOMING BUSINESS\n"
        @pdf_page.formatted_lines[3].should eq "<b>FORTHCOMING BUSINESS</b>\n"
        
        @pdf_page.lines[6].should eq "                        [Notes about this document are set out at the end]\n"
        @pdf_page.formatted_lines[6].should eq "[<i>Notes about this document are set out at the end</i>]\n"
        
        @pdf_page.formatted_lines[29].should eq "<b><i>Easter adjournment:</i></b>\n"
      end
    end
  end
end