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
      unless current_zone_version_id == zone_version.version_id
        @session.set_zone_version @zone_id, zone_version.version_id
      end
    end

    def clone_current_zone_version
      version_id = @session.clone_current_zone_version @zone_id
      initialize_version version_id
    end

    private

    def current_zone_version_id
      @session.zone_version_id(@zone_id)
    end

    def refresh_versions
      @versions = version_ids.map do |version_id|
        initialize_version version_id
      end
    end

    def record_list version_id
      @session.record_list(@zone_id, version_id)
    end

    def version_ids
      @session.zone_version_ids(@zone_id)
    end

    def initialize_version version_id
      HerokuGandiDns::ZoneVersion.new version_id, record_list(version_id)
    end

  end
end
