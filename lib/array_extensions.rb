class Array 
  def delete_once(value)
    each_with_index do |v,idx|
      return delete_at(idx) if v == value
    end
    nil
  end
end