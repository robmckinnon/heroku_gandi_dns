require_relative 'zone_version'

module HerokuGandiDns

  class Zone

    attr_reader :versions, :zone_id

    def initialize session, zone_id
      @session = session
      @zone_id = zone_id
      refresh_versions
    end

    def zone_versions_with_single_a_record
      @versions.select { |v| v.single_a_record? }
    end

    def set_zone_version zone_version
      if current_zone_version_id == zone_version.version_id
        puts 'no change to IP address'
      else
        @session.set_zone_version @zone_id, zone_version.version_id
      end
    end

    def available_zone_version
      if zone_version = non_current_versions.last
        puts "reusing version: #{zone_version.version_id}"
        zone_version
      else
        clone_current_zone_version
      end
    end

    def clone_current_zone_version
      version_id = @session.clone_current_zone_version @zone_id
      initialize_version version_id
    end

    private

    def non_current_versions
      version_id = current_zone_version_id
      @versions.select {|v| v.version_id != version_id }
    end

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
