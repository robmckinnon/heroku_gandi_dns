require_relative '../../spec_helper'
require_relative '../../../lib/heroku_gandi_dns/zone_manager'

describe HerokuGandiDns::ZoneManager do

  describe 'constructed with session and domain' do

    let(:domain)       { mock }
    let(:ip_address)   { mock }
    let(:zone_version) { mock }
    let(:ttl_secs)     { mock }

    before do
      @manager = HerokuGandiDns::ZoneManager.new(domain)
    end

    describe 'asked for zone matching ip address' do
      before do
        domain.expects(:zone_versions_with_single_a_record).returns [zone_version]
      end

      it 'should return match' do
        zone_version.expects(:ip_address).returns ip_address
        assert_equal @manager.zone_version_for_ip(ip_address), zone_version
      end

      it 'should return nil when no match' do
        zone_version.expects(:ip_address).returns '127.0.0.1'
        assert_nil @manager.zone_version_for_ip(ip_address)
      end
    end

    describe 'asked to set ip address in zone' do
      describe 'and there is existing zone_version_for_ip' do
        before do
          @manager.expects(:zone_version_for_ip).returns zone_version, ttl_secs
        end

        it 'should set that to be the active version' do
          domain.expects(:set_zone_version).with(zone_version)

          @manager.set_zone_for_ip ip_address, ttl_secs
        end
      end

      describe 'and there is no existing zone_version_for_ip' do
        before do
          @manager.expects(:zone_version_for_ip).returns nil
        end

        it 'should create new zone version and set it' do
          domain.expects(:create_zone_version).with(ip_address, ttl_secs).returns zone_version
          domain.expects(:set_zone_version).with(zone_version)

          @manager.set_zone_for_ip ip_address, ttl_secs
        end
      end
    end
  end
end
