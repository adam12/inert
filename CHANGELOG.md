## master
- Copy static assets before building site
- Remove html extension from default filename
- Show missing view filename in 404 error
- More verbose url skipping
- Add starting url to history
- Fix scope of routes being called
- Empty page object before initializing
- Actually expose Inert::VERSION
- Add `Inert.development?` and `Inert.building?` predicate methods

## 0.2.0 (2017-11-16)
- Use Rack builder and add CommonLogger middleware
- Move require of inert until `RACK_ENV` is set.
- Allow views path to be configurable
- Add hooks to extend underlying Roda app
- Fix custom layout property
- Proper file join
- Support other rendering engines outside of ERB
- Only use path portion for filename
- Add `content_for` plugin

## 0.1.0 (2017-11-08)
- Initial release
