require 'rubygems'
require 'spec'
require File.dirname(__FILE__) + '/../fillorbust'

describe Array do
  it "should do delete_once correctly" do
    a = [1,2,1,2]
    a.delete_once(1)
    a.should == [2,1,2]
  end
  
  it "should implement #average" do
    [1,1,1].average.should == 1
    [1,2,1].average.should == 4.0/3
    [1,2,3,4,3,2,1].average.should == 16.0/7
  end
end