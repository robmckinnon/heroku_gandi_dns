
module HerokuGandiDns

  class ZoneManager

    def initialize domain
      @domain = domain
    end

    def zone_for_ip ip_address
      zones.detect { |z| z.ip_address == ip_address }
    end

    private

    def zones
      @domain.zones
    end
  end

end
