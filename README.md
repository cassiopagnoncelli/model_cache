# ModelCache

Welcome to ActiveRecord Redis cache.

This gem aims to cache serialized ActiveRecord objects
for fast access.  

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'model_cache'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install model_cache

Then add to `config/initializers/model_cache.rb`

```
ModelCache::Engine.init(redis_handler: $redis_cache)
```

## Usage

As simple as possible. Add to your ActiveRecord model
and you're good to go.

```
class PineUser < ApplicationRecord
  include ModelCache

  # primary key is discovered automatically by default
  model_cache_key :email 
end

PineUser.fetch('user@domain.com')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/model_cache. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the ModelCache project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/model_cache/blob/master/CODE_OF_CONDUCT.md).
