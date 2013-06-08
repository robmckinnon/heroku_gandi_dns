require_relative '../spec_helper'
require_relative '../../lib/heroku_gandi_dns'

describe HerokuGandiDns do

  describe 'asked to update' do
    describe 'without params' do
      it 'should print usage' do
        HerokuGandiDns.expects(:puts_usage).at_least_once
        HerokuGandiDns.update_dns
      end
    end

    describe 'with params' do
      let(:heroku_domain) { stub }
      let(:custom_domain) { stub }
      let(:gandi_api_key) { stub }

      before do
        ARGV = [heroku_domain, custom_domain, gandi_api_key]
      end

      after do
        ARGV = []
      end

      it 'should not print usage' do
        HerokuGandiDns.expects(:puts_usage).never
        HerokuGandiDns.update_dns
      end
    end
  end
end
