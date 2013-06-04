require_relative 'zone'

module HerokuGandiDns

  class Domain

    attr_reader :zone

    def initialize session, domain
      zone_id = session.zone_id(domain)
      @zone = Zone.new(session, zone_id)
    end

    def zone_versions_with_single_a_record
      @zone.versions_with_single_a_record
    end

  end
end
