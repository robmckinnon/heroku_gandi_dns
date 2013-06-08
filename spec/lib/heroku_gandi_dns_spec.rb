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

    let(:heroku_domain) { stub }
    let(:custom_domain) { stub }
    let(:gandi_api_key) { stub }

    describe 'with params' do

      before do
        ARGV = [heroku_domain, custom_domain, gandi_api_key]
      end
      after do
        ARGV = []
      end

      it 'should call do_update_dns' do
        HerokuGandiDns.expects(:puts_usage).never
        HerokuGandiDns.expects(:do_update_dns).with(heroku_domain, custom_domain, gandi_api_key)
        HerokuGandiDns.update_dns
      end
    end

    describe 'via do_update_dns' do
      let(:session)    { stub }
      let(:domain)     { stub }
      let(:ip_address) { stub }
      let(:zone_manager) { stub }

      it 'should connect to Gandi api and update dns' do

        Gandi::Session.expects(:new).with(gandi_api_key, 'https://rpc.gandi.net/xmlrpc/').returns session
        HerokuGandiDns::Domain.expects(:new).with(session, custom_domain).returns domain

        HerokuGandiDns::ZoneManager.expects(:new).with(domain).returns zone_manager

        HerokuGandiDns::IpList.expects(:new).with(heroku_domain).returns stub(ip_address: ip_address)

        zone_manager.expects(:set_zone_for_ip).with(ip_address)

        HerokuGandiDns.do_update_dns(heroku_domain, custom_domain, gandi_api_key)
      end
    end
  end
end
