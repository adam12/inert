# Inert

An experimental static site builder with unambitious goals.

## Project Goals

- Be fast
- Allow reading of YAML frontmatter
- Allow queueing of manual URLs for preservation


## Usage

Install the gem:

    gem install inert

Create a few folders:

    mkdir static views

And a layout file:

    echo "<%= yield %>" > views/layout.erb

And then start the Inert server:

    inert

When you're ready to deploy, build the site:

    inert build

## Configuring

By default, Inert expects a few things, and should work without configuration.
Because it's built on top of Roda, it's very easily extendable, and Inert
provides hooks to do this via the `Inertfile` it will read from your project
root at runtime.

```ruby
# Inertfile
Inert.config do |inert|
   inert.helpers do
     def generator
       "Inert v#{Inert::VERSION}"
     end
   end
  
  inert.app do
    plugin :h
  end
  
  inert.routes do |r|
    r.on "employees.html" do
      @employees = [] # Read in actual data here
      view("employees.html.erb")
    end
  end
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/adam12/inert.

I love pull requests! If you fork this project and modify it, please ping me to see
if your changes can be incorporated back into this project.

That said, if your feature idea is nontrivial, you should probably open an issue to
[discuss it](http://www.igvita.com/2011/12/19/dont-push-your-pull-requests/)
before attempting a pull request.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
