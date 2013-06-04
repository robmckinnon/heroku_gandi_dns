require_relative '../../spec_helper'
require_relative '../../../lib/heroku_gandi_dns/zone_manager'

describe HerokuGandiDns::ZoneManager do

  describe 'constructed with session and domain' do

    let(:domain)       { mock }
    let(:ip_address)   { mock }
    let(:zone_version) { mock }

    before do
      @manager = HerokuGandiDns::ZoneManager.new(domain)
    end

    it 'should exist' do
      assert_equal @manager.class, HerokuGandiDns::ZoneManager
    end

    describe 'asked for zone matching ip address' do
      before do
        domain.expects(:zone_versions_with_single_a_record).returns [zone_version]
      end

      it 'should return match' do
        zone_version.expects(:ip_address).returns ip_address
        assert_equal @manager.zone_for_ip(ip_address), zone_version
      end

      it 'should return nil when no match' do
        zone_version.expects(:ip_address).returns ''
        assert_nil @manager.zone_for_ip(ip_address)
      end
    end
  end
end
