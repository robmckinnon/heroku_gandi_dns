require_relative '../../spec_helper'
require_relative '../../../lib/heroku_gandi_dns/ip_list'

describe HerokuGandiDns::IpList do

  describe 'given valid url' do
    it 'should return IPs from resolver' do
      uri = 'uri'
      ip_address = '123.456.789.000'
      eval "class TestResolver; def each_address; yield OpenStruct.new(to_string: '#{ip_address}'); end; end"
      Net::DNS::Resolver.expects(:start).returns TestResolver.new
      list = HerokuGandiDns::IpList.new(uri)
      list.ips.must_equal [ip_address]

      list.ip_address.must_equal ip_address
    end
  end
end
