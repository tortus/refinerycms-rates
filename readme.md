# Rates extension for Refinery CMS 2.1.

Useful for banks and credit unions. Store rate tables
as snippets of HTML then insert anywhere on the site.

## Installation

Gemfile:
```ruby
gem 'refinerycms-rates', :github => 'tortus/refinerycms-rates', :branch => '2-1-stable'
```

Terminal:
```sh
bundle install
rails generate refinery:rates
rake db:migrate
rake db:seed
```
