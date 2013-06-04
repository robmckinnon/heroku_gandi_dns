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
    end

    it 'should have versions' do
      zone = HerokuGandiDns::Zone.new(session, zone_id)
      zone.versions.size.must_equal 2
      zone.versions_with_single_a_record.size.must_equal 1
      zone.versions_with_single_a_record.first.version_id.must_equal 2
    end
  end

end
