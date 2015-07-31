module Electron
  class Clipboard
    include Wrapper
    extend Wrapper
    extend WrappedClass
    extend Observable
  end
  class CrashReporter
    include Wrapper
    extend Wrapper
    extend WrappedClass
    extend Observable
  end
  class NativeImage
    include Wrapper
    extend Wrapper
    extend WrappedClass
    extend Observable
  end
  class Screen
    include Wrapper
    extend Wrapper
    extend WrappedClass
    extend Observable
  end
  class Shell
    include Wrapper
    extend Wrapper
    extend WrappedClass
    extend Observable
  end
  class Process
    include Wrapper
    def initialize(process)
      @wrapped = process
    end
  end
end
