require File.expand_path('../lib/material_icons_svg/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'material_icons_svg'
  s.version     = MaterialIconsSvg::VERSION
  s.summary     = "Rails helpers for Google Material Design icons in SVG format"
  s.description = "Rails Helpers for Google Material Design icons in SVG format"
  s.authors     = ["Peng Miao"]
  s.email       = 'mios426@gmail.com'
  s.files       = Dir['{app,lib}/**/*'] + %w(Rakefile LICENSE README.md)
  s.homepage    = 'https://github.com/miaopeng/material-icons-svg'
  s.require_paths = ['lib']
  s.license     = 'MIT'

  # Basic dependency
  s.add_dependency 'railties', '>= 3.2'

  s.add_runtime_dependency "inline_svg", ">= 0.6.4"
end
