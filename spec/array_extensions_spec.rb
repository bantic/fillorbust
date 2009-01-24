require 'rubygems'
require 'spec'
require File.dirname(__FILE__) + '/../lib/array_extensions'

describe Array do
  it "should do delete_once correctly" do
    a = [1,2,1,2]
    a.delete_once(1)
    a.should == [2,1,2]
  end
end