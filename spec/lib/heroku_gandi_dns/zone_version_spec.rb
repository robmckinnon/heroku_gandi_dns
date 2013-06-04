require_relative '../../spec_helper'
require_relative '../../../lib/heroku_gandi_dns/zone_version'

describe HerokuGandiDns::ZoneVersion do

  describe 'constructed with session and domain' do

    let(:version_id) { mock }
    let(:ip_address) { mock }

    before do
      @version = HerokuGandiDns::ZoneVersion.new(version_id, records)
    end

    describe 'after initialized' do
      let(:records)    { mock }

      it 'should have version_id' do
        @version.version_id.must_equal version_id
      end

      it 'should have records' do
        @version.records.must_equal records
      end
    end

    describe 'with no A records' do
      let(:records)    { [mock(type: 'M')] }

      it 'should have single_a_record? false' do
        @version.single_a_record?.must_equal false
      end
    end

    describe 'with two A records' do
      let(:records)    { [mock(type: 'A'), mock(type: 'A')] }

      it 'should have single_a_record? false' do
        @version.single_a_record?.must_equal false
      end
    end

    describe 'with one A record' do
      let(:records)    { [stub(type: 'A', value: ip_address)] }

      it 'should have single_a_record? true' do
        @version.single_a_record?.must_equal true
      end

      it 'should have ip_address correct' do
        @version.ip_address.must_equal ip_address
      end
    end
  end
end
