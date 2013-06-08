require 'gandi'

module HerokuGandiDns

  class GandiApi

    def initialize api
      @api = api
    end

    def zone_id domain
      domain_info(domain).zone_id
    end

    def domain_info domain
      @api.domain.info(domain)
    end

    def zone_info zone_id
      @api.domain.zone.info(zone_id)
    end

    def zone_version_id zone_id
      zone_info(zone_id).version
    end

    def zone_version_ids zone_id
      zone_info(zone_id).versions
    end

    def record_list zone_id, version_id
      @api.domain.zone.record.list(zone_id, version_id)
    end

    def set_zone_version zone_id, version_id
      @api.domain.zone.version.set(apikey, zone_id, version_id)
    end

    # returns new zone version id
    def clone_current_zone_version zone_id
      zone_info = @api.domain.zone.clone(zone_id)
      zone_info.version
    end

    def delete_records zone_id, version_id, record_ids
      record_ids.each do |record_id|
        @api.domain.zone.record.delete(zone_id, version_id, record_id)
      end
    end

  end

end
