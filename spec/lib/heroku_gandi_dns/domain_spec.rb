require_relative '../../spec_helper'
require_relative '../../../lib/heroku_gandi_dns/domain'

describe HerokuGandiDns::Domain do

  let(:domain)  { stub }
  let(:session) { stub }
  let(:zone_id) { stub }
  let(:zone_version) { stub }
  let(:zone) { stub(zone_versions_with_single_a_record: [zone_version], zone_id: zone_id) }

  before do
    HerokuGandiDns::Zone.expects(:new).with(session, zone_id).returns zone
    session.expects(:zone_id).with(domain).returns zone_id

    @domain = HerokuGandiDns::Domain.new(session, domain)
  end

  it 'should have zone' do
    @domain.zone.must_equal zone
  end

  it 'should get zone_versions_with_single_a_record from zone' do
    @domain.zone_versions_with_single_a_record.must_equal [zone_version]
  end

  it 'should pass set_zone_version to zone' do
    zone.expects(:set_zone_version).with(zone_version)
    @domain.set_zone_version(zone_version)
  end

  describe 'asked to create_zone_version for ip_address' do
    let(:ip_address) { stub }
    let(:version_id) { stub }
    let(:ttl_secs)   { stub }

    it 'should clone current, delete A records, add new A record, return zone_version' do
      zone_version = stub(version_id: version_id, a_record_ids: [123])

      zone.expects(:clone_current_zone_version).returns zone_version
      session.expects(:delete_records).with(zone_id, version_id, [123])

      session.expects(:add_a_record).with(zone_id, version_id, ip_address, ttl_secs)

      @domain.create_zone_version(ip_address, ttl_secs).must_equal zone_version
    end

  end
end
