Gem::Specification.new do |s|
  s.name        = 'material_icons_svg'
  s.version     = '1.0.0'
  s.date        = '2016-05-20'
  s.summary     = "Hola!"
  s.description = "Rails Helpers to render Material Design icons in SVG format"
  s.authors     = ["Peng Miao"]
  s.email       = 'mios426@gmail.com'
  s.files       = Dir['{app,lib}/**/*'] + %w(Rakefile LICENSE README.md)
  s.homepage    = 'https://github.com/miaopeng/material-icons-svg'
  s.require_paths = ['lib']
  s.license     = 'MIT'

  # Basic dependency
  s.add_dependency 'railties', '>= 3.2'
end
