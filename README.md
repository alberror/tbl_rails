# The Blooming Lab | Corporate WebSite

## Ruby & Rails version

Ruby: 2.4.2
Rails: 5.1.4

## Noteworthy gems

* Passenger (WebServer) | https://www.phusionpassenger.com/library/walkthroughs/start/ruby.html
* Route Translator (Url localization) | https://github.com/enriclluelles/route_translator

## Required environement variables

* `SECRET_KEY_BASE`

## Running script (cf. Procfile)

`web: bundle exec passenger start -p $PORT --max-pool-size 3`

## Release notes

### v1.0

...
