require 'material_icons_svg/icon_helpers'
module MaterialIconsSvg
  class Railtie < Rails::Railtie
    initializer "material_icons_svg.icon_helpers" do
      ActionView::Base.send :include, IconHelpers
    end
  end
end