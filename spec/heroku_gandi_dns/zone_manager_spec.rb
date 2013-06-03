require_relative '../spec_helper'
require_relative '../../lib/heroku_gandi_dns/zone_manager'

describe ZoneManager do

  # describe 'given Gandi::Session' do
  describe 'constructed with session and domain' do

    # let(:session)    { mock }
    let(:domain)     { mock }
    # let(:domain_api) { mock }
    let(:ip_address) { mock }
    let(:zone) { mock }

    before do
      @manager = ZoneManager.new(domain)
    end

    it 'should exist' do
      assert_equal @manager.class, ZoneManager
    end

    describe 'asked for zone matching ip address' do
      before do
        domain.expects(:zones).returns [zone]
      end

      it 'should return match' do
        zone.expects(:ip_address).returns ip_address
        assert_equal @manager.zone_for_ip(ip_address), zone
      end

      it 'should return nil when no match' do
        zone.expects(:ip_address).returns ''
        assert_nil @manager.zone_for_ip(ip_address)
      end
    end
  end
end
