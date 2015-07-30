require 'opal'
require 'opal-activesupport'
require 'electron/fixtures'
require 'electron/wrapper'
require 'electron/wrapper_class'
require 'electron/observable'
require 'electron/app'
require 'electron/browser_window'

module Electron

  Object.const_set("Process", Class.new do
    include Wrapper

    def initialize(process)
      @wrapped = process
    end
  end)

end
