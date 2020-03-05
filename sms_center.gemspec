Gem::Specification.new do |s|
  s.name                  = 'sms_center'
  s.version               = '0.0.7'
  s.date                  = '2020-02-11'
  s.summary               = 'Deliveree!'
  s.description           = 'A simple tool to using SMS third party'
  s.authors               = ['Deleveree']
  s.files                 = ['lib/sms_center.rb'] + Dir['lib/sms_center/*']
  s.required_ruby_version = '~> 2.5.0'
  s.add_runtime_dependency 'rest-client', '>= 2.0.0'
  s.homepage              =
    'https://github.com/deliveree/sms_center'
end
