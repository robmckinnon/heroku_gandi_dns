require_relative 'zone_version'

module HerokuGandiDns

  class Zone

    attr_reader :versions

    def initialize session, zone_id
      @session = session
      @zone_id = zone_id
      refresh_versions
    end

    def zone_versions_with_single_a_record
      @versions.select { |v| v.single_a_record? }
    end

    def set_zone_version zone_version
      @session.set_zone_version @zone_id, zone_version.version_id
    end

    private

    def refresh_versions
      @versions = version_ids.map do |version_id|
        HerokuGandiDns::ZoneVersion.new version_id, record_list(version_id)
      end
    end

    def record_list version_id
      @session.record_list(@zone_id, version_id)
    end

    def version_ids
      @session.zone_version_ids(@zone_id)
    end

  end
end
