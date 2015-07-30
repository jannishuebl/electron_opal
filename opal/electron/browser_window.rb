module Electron
  class BrowserWindow
    include Wrapper

    def initialize(name, options={})
      @options = options
      load_url("file://#{dirname}/#{name}.html")
      open_dev_tools(detach: true) if options[:dev_tools]
    end
  end
end
