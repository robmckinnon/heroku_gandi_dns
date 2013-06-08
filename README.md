# heroku_gandi_dns

[![Build Status](https://travis-ci.org/robmckinnon/heroku_gandi_dns.png?branch=master)](https://travis-ci.org/robmckinnon/heroku_gandi_dns)
[![Dependency Status](https://gemnasium.com/robmckinnon/heroku_gandi_dns.png)](https://gemnasium.com/robmckinnon/heroku_gandi_dns)
[![Code Climate](https://codeclimate.com/github/robmckinnon/heroku_gandi_dns.png)](https://codeclimate.com/github/robmckinnon/heroku_gandi_dns)
[![Coverage Status](https://coveralls.io/repos/robmckinnon/heroku_gandi_dns/badge.png?branch=master)](https://coveralls.io/r/robmckinnon/heroku_gandi_dns?branch=master)

Manage DNS records at Gandi for the domains used by your Heroku applications.

## Installation

    git clone git@github.com:robmckinnon/heroku_gandi_dns.git

    cd heroku_gandi_dns

    bundle install --without test


## Usage

usage:

    bundle exec ruby lib/heroku_gandi_dns.rb <heroku_domain> <custom_domain> <gandi_api_key> <ttl_secs>

e.g.:

    bundle exec ruby lib/heroku_gandi_dns.rb your-app.herokuapp.com your-app.com eXAMP1EkEY7 1800

