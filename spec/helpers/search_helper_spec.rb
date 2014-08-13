require 'spec_helper'

describe SearchHelper, :type => :helper do
  describe "#current_page_numbers" do
    it 'calculates first and last displayed page number' do
      @current_page = 10
      helper.current_page_numbers.should == (1..10).to_a

      @current_page = 14
      helper.current_page_numbers.should == (11..20).to_a

      @current_page = 101
      helper.current_page_numbers.should == (101..110).to_a
    end  
  end
end