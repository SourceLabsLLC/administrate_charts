# AdministrateCharts

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'administrate_charts'
```

And then execute:

  $ bundle

## Usage

By default the gem will add a new option on your admin menu, called `Charts`. Where you can choose the resource, attributes and chart type.

If for some reason you had to overwrite the `views/layouts/admin/application` file on you project, you need to add on its `head` tag the following code to make the gem work properly `<%= javascript_include_tag 'chartkickBundle' %>`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/administrate_charts.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
