
module HerokuGandiDns

  class ZoneManager

    def initialize domain
      @domain = domain
    end

    def zone_version_for_ip ip_address
      zone_versions.detect { |z| z.ip_address == ip_address }
    end

    def set_zone_for_ip ip_address
      if version = zone_version_for_ip(ip_address)
        @domain.set_zone_version(version)
      end
    end

    private

    def zone_versions
      @domain.zone_versions_with_single_a_record
    end
  end

end
