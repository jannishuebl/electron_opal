class Hash
  def to_js
    %x{
    return self.smap;
    }
  end
end
