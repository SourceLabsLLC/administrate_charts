# AdministrateCharts

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'administrate_charts'
```

And then execute:

  $ bundle

## Usage

By default the gem will add a new `Charts` link in your administrate sidenav. You can choose the resource, attributes and chart type to display in a graph.

  * Resource list is a mirror of Administrate sidebar menu.
  * The attributes list are generated from the `ATTRIBUTE_TYPES` from the dashboards, also we excludes the attributes that aren't real columns. Relationships attributes keeps on the list
  * You can choose between the following chart types: `Pie`, `Bar`, `Column`, `Line` and `Area`
  * The functions you can apply on the data are: `count`, `sum`, `min`, `max` and `average`

If for some reason you had to overwrite the `views/layouts/admin/application.html.erb` layout file in your project, you need `<%= javascript_include_tag 'chartkickBundle' %>` in it's `head` section.

## Examples

### Chart Form
![Chart Form](/images/chart-form.png)

### Area Chart
![Area Chart](/images/chart-area.png)

### Column Chart
![Column Chart](/images/chart-column.png)

### Pie Chart
![Pie Chart](/images/chart-pie.png)

## Development

After checking out the repo, run `cp spec/dummy/config/database.yml.example spec/dummy/config/database.yml` and configure the file, so you can run the tests using the `dummy` app.

After implementing the new feature, don't forgot to add it to the dummy app and add the proper tests for it. To run the tests `bundle exec rspec`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SourceLabsLLC/administrate_charts.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
