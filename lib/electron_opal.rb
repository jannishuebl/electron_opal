require 'erb'
require 'fileutils'
require 'ostruct'
require 'opal/sprockets'
require 'opal-activesupport'
require 'opal-browser'
require 'opal-jquery'
require 'opal-vienna'

def env
  @env ||= Sprockets::Environment.new
  @env
end

def config
  return @config if @config
  @config = OpenStruct.new
  @config.paths = Opal.paths
  @config.paths << File.join(File.dirname(__FILE__), "../opal")

  @config.app_class = "main"

  @config
end

def setup(&block)
  block.call config
end

def setup_env
  config.paths.flatten.each { |p| env.append_path(p) }
end

task :default do 
  sh "electron ."
end
task :config do 
  config.each_pair do | key, value |
    puts "#{key}: #{value}"
  end
end
task :build do 
  setup_env

  compile_js(config.app_class, load_asset_code: true)

  Dir["app/**/*_window.rb"].each do | file_path |
    asset_name = Pathname.new(file_path).basename(".rb")
    compile_js(asset_name)
    create_html(asset_name)
  end

end

def compile_js(asset_name, options={})
  load_asset_code = Opal::Processor.load_asset_code(env, asset_name) if options[:load_asset_code]
  asset = env.find_asset(asset_name)
  write_to("#{asset_name}.js", asset.source, load_asset_code)
end

def create_html(asset_name)
  write_to("#{asset_name}.html", Index.new(env, asset_name).html)
end

def write_to(filename, source, load_code = "")
  filename = File.join('build', filename)
  FileUtils.mkdir_p File.dirname(filename)

  File.open(filename, 'wb+') do |f|
    f.write source
    f.write load_code
  end
end

class Index

  def initialize(env, name)
    @env, @name = env, name
  end

  def javascript_include_tag 
    scripts = []
    scripts << %{<script src="./#{@name}.js"></script>}
    scripts << %{<script>#{Opal::Processor.load_asset_code(@env, @name)}</script>}
    scripts.join "\n"
  end

  def html
    <<-HTML
          <!DOCTYPE html>
          <html>
          <head>
            <title>Opal Server</title>
          </head>
          <body>
    #{javascript_include_tag}
          </body>
          </html>
    HTML
  end
end
