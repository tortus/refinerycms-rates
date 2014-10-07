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

## Using "Rates Anywhere"

Ruby code (easiest):

```erb
<%= raw Refinery::Rates.content_for('auto-loans') %>
```

Adding liquid-style code inline in CMS:

CMS:
```html
<p>Content</p>
{{rate_table auto_loans}}
<p>More content</p>
```

Override views/refinery/_content_page to use the helper:
```erb
<%= raw replace_rates_tags(@page.content_for('body')) %>
```
