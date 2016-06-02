Gem::Specification.new do |s|
  s.name        = 'openload'
  s.version     = '0.0.2'
  s.date        = '2016-05-21'
  s.summary     = "Openload"
  s.description = "A Gem to use openload.io with ruby"
  s.authors     = ["Bruno Tripoloni"]
  s.email       = 'bruno.tripoloni@gmail.com'
  s.files       = ["lib/openload.rb"]
  s.homepage    =
    'http://github.com/btripoloni/openload'
  s.license       = 'MIT'
  s.add_dependency('httparty')
end
