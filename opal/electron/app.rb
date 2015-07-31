module Electron
  class App
    class << self
      def open_window(name, options={})
        BrowserWindow.new(name, options)
      end
    end
  end
end
