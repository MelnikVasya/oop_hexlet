## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oop_hexlet'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oop_hexlet

## Usage
```ruby
  geolocation = OopHexlet.search_geolocation('172.217.20.174')
  geolocation.city # => 'Warsaw'
  geolocation.country # => 'Poland'
  geolocation.zip # => '1223
  geolocation.lat # => 52.2297
  geolocation.lon # => 21.0122
  geolocation.org # => 'Google'
  geolocation.status # => 'success'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/oop_hexlet.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
