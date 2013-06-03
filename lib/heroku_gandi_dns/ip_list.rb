require 'net/dns'

class IpList

  attr_reader :ips

  def initialize uri
    resolver = Net::DNS::Resolver.start(uri, Net::DNS::A)
    @ips = []
    resolver.each_address { |ip| @ips << ip }
  end
end
