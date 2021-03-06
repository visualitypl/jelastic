# Archived

This project's support has been ceased. No future fixes or features are planned. 

# Jelastic
[![Gem Version](https://badge.fury.io/rb/jelastic.svg)](https://badge.fury.io/rb/jelastic) [![Build Status](https://travis-ci.org/visualitypl/jelastic.svg?branch=master)](https://travis-ci.org/visualitypl/jelastic) [![Code Climate](https://codeclimate.com/github/visualitypl/jelastic/badges/gpa.svg)](https://codeclimate.com/github/visualitypl/jelastic) [![Coverage Status](https://coveralls.io/repos/github/visualitypl/jelastic/badge.svg?branch=master)](https://coveralls.io/github/visualitypl/jelastic?branch=master)

A Ruby wrapper for Jelastic API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jelastic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jelastic

## Configuration

```ruby
client = Jelastic::Client.new do |config|
  config.login    = 'LOGIN'
  config.password = 'PASSWORD'
  config.api_url  = 'API URL HOST PROVIDER' # e.g. https://app.j.layershift.co.uk/1.0/
  # add unique id to have multiple connections from the same ip
  config.user_agent  = nil # e.g. Task1-UniqueID1
end
```

## Usage

TODO: Write usage instructions here

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/visualitypl/jelastic.

## Copyright
Copyright (c) 2016 Visuality.
See [LICENSE][] for details.

[license]: LICENSE
