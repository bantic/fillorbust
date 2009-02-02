class Array 
  def delete_once(value)
    each_with_index do |v,idx|
      return delete_at(idx) if v == value
    end
    nil
  end
  
  def average
    inject(0){|sum,val| sum += val}.to_f/size
  end
end