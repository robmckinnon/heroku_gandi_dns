require_relative '../../spec_helper'
require_relative '../../../lib/heroku_gandi_dns/domain'

describe HerokuGandiDns::Domain do

  let(:domain)  { stub }
  let(:session) { stub }
  let(:zone_id) { stub }
  let(:version) { stub }
  let(:zone) { stub(zone_versions_with_single_a_record: [version]) }

  before do
    HerokuGandiDns::Zone.expects(:new).with(session, zone_id).returns zone
    session.expects(:zone_id).with(domain).returns zone_id

    @domain = HerokuGandiDns::Domain.new(session, domain)
  end

  it 'should have zone' do
    @domain.zone.must_equal zone
  end

  it 'should get zone_versions_with_single_a_record from zone' do
    @domain.zone_versions_with_single_a_record.must_equal [version]
  end

  it 'should pass set_zone_version to zone' do
    zone.expects(:set_zone_version).with(version)
    @domain.set_zone_version(version)
  end

  describe 'asked to create_zone_version for ip_address' do
    let(:ip_address) { stub }

    it 'should clone current zone version' do
      zone.expects(:clone_current_zone_version)
      @domain.create_zone_version ip_address
    end

  end
end
