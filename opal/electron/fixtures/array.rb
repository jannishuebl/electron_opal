class Array
  def to_js
   map do | arg |
    if arg.kind_of?(Hash)
      arg.to_js
    else
      arg
    end
   end
  end
end
