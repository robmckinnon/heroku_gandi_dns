require 'forwardable'
require_relative 'gandi_api'
require_relative 'zone'

module HerokuGandiDns

  class Domain

    attr_reader :zone

    extend Forwardable
    def_delegators :@zone, :zone_versions_with_single_a_record, :set_zone_version

    def initialize session, domain
      zone_id = session.zone_id(domain)
      @zone = Zone.new(session, zone_id)
    end

    def create_zone_version ip_address
      zone_version = @zone.clone_current_zone_version
    end

  end
end
