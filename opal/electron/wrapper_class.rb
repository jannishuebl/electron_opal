module Electron
  module WrappedClass
    def new_wrapped
      %x{
        return require(#{dashed_class_name});
      }
    end

    def dashed_class_name
      self.name.demodulize.dasherize
    end
  end
end
