# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-rates'
  s.version           = '2.1'
  s.description       = 'Ruby on Rails Rates extension for Refinery CMS'
  s.date              = '2014-05-22'
  s.summary           = 'Rates extension for Refinery CMS'
  s.authors           = ['William Makley']
  s.license           = 'MIT'

  s.require_paths     = %w(lib)
  s.files             = `git ls-files`.split($/)
  s.test_files        = s.files.grep(%r{^(test|spec|features)/})

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.1.2'
  s.add_dependency             'acts_as_indexed',     '~> 0.8.0'
  s.add_dependency             'friendly_id',         '~> 4.0.9'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 2.1.2'
end
