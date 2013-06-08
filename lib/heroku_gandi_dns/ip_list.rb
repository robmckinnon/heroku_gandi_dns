require 'net/dns'

module HerokuGandiDns

  class IpList

    attr_reader :ips

    def initialize uri
      resolver = Net::DNS::Resolver.start(uri, Net::DNS::A)
      @ips = []
      resolver.each_address { |ip| @ips << ip.to_string }
    end

    def ip_address
      ips.first
    end
  end

end
