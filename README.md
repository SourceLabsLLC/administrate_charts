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

After checking out the repo, run `cp /spec/dummy/config/database.yml.example /spec/dummy/config/database/yml` and configure the file, so you can run the tests using the `dummy` app.

After implementing the new feature, don't forgot to add it to the dummy app and add the proper tests. To run the tests `bundle exec rspec`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/administrate_charts.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
