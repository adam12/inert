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

## Asset Fingerprinting

Use asset fingerprinting to enable max-cache times on all your static assets.

```ruby
# Inertfile
Inert.config do |inert|
  inert.app do
    plugin :timestamp_public
  end

  inert.routes do |r|
    r.timestamp_public
  end
end
```

And inside your views, use the `timestamp_path` helper with the name of the file
in `static/` wherever you'd just use the filename itself:

```ruby
<img src="<%= timestamp_path "some_image_in_static_folder.png" %>">
```

## Live Reloads

Use the `roda-live_reload` gem to enable live reloads:


```ruby
# Gemfile
gem "roda-live_reload"
gem "puma" # Webrick wont' currently work with roda-live_reload


# Inertfile
Inert.config do |inert|
  inert.app do
    plugin :live_reload if ENV["RACK_ENV"] == "development"
  end

  inert.routes do |r|
    r.live_reload if ENV["RACK_ENV"] == "development"
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
