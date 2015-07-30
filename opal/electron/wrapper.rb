module Electron
  module Wrapper
    attr_reader :options

    def method_missing(method, *args, &block)
      args << block if block_given?
      %x{
        if(typeof(#{wrapped}[#{method.camelize(:lower)}]) == 'function') {
         return #{wrapped}[#{method.camelize(:lower)}].apply(#{wrapped}, #{args.to_js});
        } else {
         return #{wrapped}[#{method.camelize(:lower)}];
        }
      }
    end

    def wrapped
      @wrapped ||= new_wrapped
      @wrapped
    end

    def new_wrapped
      %x{
        var WrappedClass = require(#{dashed_class_name});
        return new WrappedClass(#{js_options});
      }
    end

    def dashed_class_name
      self.class.name.demodulize.dasherize
    end

    def js_options
      options.to_js if self.options.kind_of?(Hash)
    end
  end
end
