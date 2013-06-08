require_relative 'heroku_gandi_dns/gandi_api'
require_relative 'heroku_gandi_dns/ip_list'
require_relative 'heroku_gandi_dns/domain'
require_relative 'heroku_gandi_dns/zone_manager'

module HerokuGandiDns

  class << self
    def update_dns
      if ARGV.size == 3
        do_update_dns ARGV[0], ARGV[1], ARGV[2]
      else
        puts_usage
      end
    end

    def do_update_dns heroku_domain, custom_domain, gandi_api_key
      manager = HerokuGandiDns::ZoneManager.new domain(custom_domain, gandi_api_key)

      manager.set_zone_for_ip ip_address(heroku_domain)
    end

    private

    def ip_address domain_name
      HerokuGandiDns::IpList.new(domain_name).ip_address
    end

    def domain custom_domain, gandi_api_key
      HerokuGandiDns::Domain.new gandi_session(gandi_api_key), custom_domain
    end

    def gandi_session gandi_api_key
      Gandi::Session.new gandi_api_key, 'https://rpc.gandi.net/xmlrpc/'
    end

    def puts_usage
      puts ''
      puts 'usage: ruby lib/heroku_gandi_dns.rb <heroku_domain> <custom_domain> <gandi_api_key>'
      puts ''
      puts ' e.g.: ruby lib/heroku_gandi_dns.rb yourapp.herokuapp.com yourapp.com eXAMP1EkEY7'
      puts ''
    end
  end
end
