require_relative '../../spec_helper'
require_relative '../../../lib/heroku_gandi_dns/zone'

describe HerokuGandiDns::Zone do

  let(:zone_id) { mock }
  let(:session) { mock }

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

      let(:zone_version) { stub version_id: 1 }

      describe 'and current zone version is the same' do
        it 'should not set zone version' do
          session.expects(:zone_version_id).with(zone_id).returns 1

          session.expects(:set_zone_version).never
          @zone.set_zone_version zone_version
        end
      end

      describe 'and current zone version is different' do
        it 'should set zone version' do
          session.expects(:zone_version_id).with(zone_id).returns 2

          session.expects(:set_zone_version).with(zone_id, zone_version.version_id)
          @zone.set_zone_version zone_version
        end
      end
    end
  end

end
