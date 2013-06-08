
module HerokuGandiDns

  class ZoneManager

    def initialize domain
      @domain = domain
    end

    def zone_version_for_ip ip_address
      zone_versions.detect { |z| z.ip_address == ip_address }
    end

    def set_zone_for_ip ip_address, ttl_secs
      zone_version = obtain_zone_version(ip_address, ttl_secs)
      @domain.set_zone_version zone_version
    end

    private

    def obtain_zone_version ip_address, ttl_secs
      zone_version_for_ip(ip_address) || @domain.create_zone_version(ip_address, ttl_secs)
    end

    def zone_versions
      @domain.zone_versions_with_single_a_record
    end
  end

end
