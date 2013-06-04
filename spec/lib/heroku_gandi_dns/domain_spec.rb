require_relative '../../spec_helper'
require_relative '../../../lib/heroku_gandi_dns/domain'

describe HerokuGandiDns::Domain do

  let(:domain)  { stub }
  let(:session) { stub }
  let(:zone_id) { stub }
  let(:version) { stub }

  describe 'after initialized' do

    it 'should have zone' do
      zone = stub(versions_with_single_a_record: [version])

      HerokuGandiDns::Zone.expects(:new).with(session, zone_id).returns zone
      session.expects(:zone_id).with(domain).returns zone_id

      the_domain = HerokuGandiDns::Domain.new(session, domain)
      the_domain.zone.must_equal zone
      the_domain.zone_versions_with_single_a_record.must_equal [version]
    end
  end

end
