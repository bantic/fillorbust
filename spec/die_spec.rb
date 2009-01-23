require 'rubygems'
require 'spec'
require File.dirname(__FILE__) + '/../lib/die'

describe Die do
  it "should have a value upon initialization" do
    d = Die.new
    d.value.should_not be_nil
  end
  
  it "should be initializable with a value" do
    d = Die.new(3)
    d.value.should == 3
  end
  
  it "should be comparable" do
    Die.new(3).should == Die.new(3)
    Die.new(3).should_not == Die.new(4)
  end
end