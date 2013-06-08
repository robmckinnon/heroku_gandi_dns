require_relative '../../spec_helper'
require_relative '../../../lib/heroku_gandi_dns/zone_version'

describe HerokuGandiDns::ZoneVersion do

  let(:version_id) { mock }
  let(:ip_address) { mock }

  before do
    @version = HerokuGandiDns::ZoneVersion.new(version_id, records)
  end

  describe 'after initialized' do
    let(:records)    { [stub(type: 'A', id: 123)] }

    it 'should have version_id' do
      @version.version_id.must_equal version_id
    end

    it 'should have records' do
      @version.records.must_equal records
    end

    it 'should have a_record_ids' do
      @version.a_record_ids.must_equal [123]
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

  describe 'with multiple A records' do
    let(:records)    { [stub(type: 'A', value: ip_address), stub(type: 'A', value: mock)] }

    it 'should have single_a_record? false' do
      @version.single_a_record?.must_equal false
    end

    it 'should have ip_address correct' do
      proc { @version.ip_address }.must_raise(RuntimeError)
    end
  end
end
