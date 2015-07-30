module Electron
  class App
    extend Wrapper
    extend WrappedClass
    extend Observable

    class << self
      def open_window(name, options={})
        BrowserWindow.new(name, options)
      end
    end
  end
end
