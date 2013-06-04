require_relative '../../spec_helper'
require_relative '../../../lib/heroku_gandi_dns/ip_list'

describe HerokuGandiDns::IpList do

  describe 'given valid url' do
    it 'should return IPs from resolver' do
      uri = 'uri'
      eval "class TestResolver; def each_address; yield '123.456.789.000'; end; end"
      Net::DNS::Resolver.expects(:start).returns TestResolver.new
      list = HerokuGandiDns::IpList.new(uri)
      assert_equal list.ips, ['123.456.789.000']
    end
  end
end
