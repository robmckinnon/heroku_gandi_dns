require 'forwardable'
require_relative 'zone'

module HerokuGandiDns

  class Domain

    attr_reader :zone

    extend Forwardable
    def_delegators :@zone, :zone_versions_with_single_a_record, :set_zone_version

    def initialize session, domain
      @session = session
      zone_id = @session.zone_id(domain)
      @zone = Zone.new(session, zone_id)
    end

    def create_zone_version ip_address, ttl_secs
      zone_version = @zone.clone_current_zone_version
      set_a_record zone_version, ip_address, ttl_secs
      zone_version
    end

    private

    def set_a_record zone_version, ip_address, ttl_secs
      delete_a_records(zone_version)
      add_a_record(zone_version, ip_address, ttl_secs)
    end

    def delete_a_records zone_version
      @session.delete_records(zone_id, zone_version.version_id, zone_version.a_record_ids)
    end

    def add_a_record zone_version, ip_address, ttl_secs
      @session.add_a_record(zone_id, zone_version.version_id, ip_address, ttl_secs)
    end

    def zone_id
      @zone.zone_id
    end

  end
end
