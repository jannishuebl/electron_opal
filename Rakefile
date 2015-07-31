require "bundler/gem_tasks"

require 'open-uri'
require 'pathname'
require 'nokogiri'
require 'rkelly'
require 'active_support'
require 'active_support/core_ext'

#  class Process
#    include Wrapper
#    def initialize(process)
#      @wrapped = process
#    end
#  end
#
task :generate_wrapper do 

  doc = Nokogiri::HTML(open("https://github.com/atom/electron/blob/master/docs/README.md"))

  create_modules_for "main", doc
  create_modules_for "both", doc
  create_modules_for "renderer", doc

end
def create_modules_for(process_name, doc)
  renderer = Renderer.new "main_process"
  doc.css("p:contains('#{process_name}')").first.next_element.children .each do | element |
    link = element.css('a').first
    if link
      pathname = Pathname.new(link.attribute("href"))
      renderer.write_module pathname.basename(".md")
    end
  end

  filename = File.join("opal/electron", "#{process_name}_process_modules.rb")
  FileUtils.mkdir_p File.dirname(filename)

  File.open(filename, 'wb+') do |f|
    f.write renderer.source
  end
end


class Renderer

  def initialize(name)
    @name = name
    @modules = []
  end

  def write_module(module_name)
    @modules << module_name
  end


  def modules
    scripts = []
    @modules.map{ | module_name | module_name.to_s.gsub(/-/, "_").camelize}.each do | name |
      scripts << "  class #{name}"
      scripts << "    include Wrapper"
      scripts << "    extend Wrapper"
      scripts << "    extend WrappedClass"
      scripts << "    extend Observable"
      scripts << "  end"
    end
    scripts.join "\n"
  end

  def source
    <<-HTML
module Electron
#{modules}
end
    HTML
  end
end

