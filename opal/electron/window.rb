module Electron
  class Window
    class << self
      def title(title)
        Document.title = title
      end

      def body_view(view_name)
        @@view_name = view_name
      end

      Document.ready? do 
        # TODO: Use ActiveSupport .classify and .constanize when supported in opal-activesupport
        view = Object.const_get(@@view_name.singularize.camelize).new
        view.render
        Element.find('body').append view.element
      end
    end
  end
end
