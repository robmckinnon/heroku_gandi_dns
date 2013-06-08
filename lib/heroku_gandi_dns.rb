require_relative 'heroku_gandi_dns/gandi_api'
require_relative 'heroku_gandi_dns/ip_list'
require_relative 'heroku_gandi_dns/domain'

module HerokuGandiDns

  class << self
    def update_dns
      if ARGV.size == 3
      else
        puts_usage
      end
    end

    private

    def puts_usage
      puts ''
      puts 'usage: ruby lib/heroku_gandi_dns.rb <heroku_domain> <custom_domain> <gandi_api_key>'
      puts ''
      puts ' e.g.: ruby lib/heroku_gandi_dns.rb yourapp.herokuapp.com yourapp.com eXAMP1EkEY7'
      puts ''
    end
  end
end
