require_relative '../../spec_helper'
require_relative '../../../lib/heroku_gandi_dns/zone'

describe HerokuGandiDns::Zone do

  let(:zone_id) { mock }
  let(:session) { mock }

  let(:version_id)   { mock }
  let(:zone_version) { stub version_id: version_id }

  describe 'after initialized' do

    before do
      session.expects(:zone_version_ids).with(zone_id).returns [1, 2]

      session.expects(:record_list).with(zone_id, 1).returns [stub(type: 'A'), stub(type: 'A')]
      session.expects(:record_list).with(zone_id, 2).returns [stub(type: 'A')]
      @zone = HerokuGandiDns::Zone.new(session, zone_id)
    end

    it 'should have versions' do
      @zone.versions.size.must_equal 2
      @zone.zone_versions_with_single_a_record.size.must_equal 1
      @zone.zone_versions_with_single_a_record.first.version_id.must_equal 2
    end

    describe 'asked to set_zone_version' do
      it 'should set zone version' do
        session.expects(:set_zone_version).with(zone_id, version_id)
        @zone.set_zone_version zone_version
      end
    end
  end

end
