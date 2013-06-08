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
      begin
        @api.domain.zone.record.list(zone_id, version_id)
      rescue Exception => e
        puts e.to_s
        []
      end
    end

    def set_zone_version zone_id, version_id
      puts 'set version ' + version_id.to_s
      @api.domain.zone.version.set(zone_id, version_id)
    end

    # returns new zone version id
    def clone_current_zone_version zone_id,
      version_id = @api.domain.zone.version.new_version(zone_id)
      version_id
    end

    def delete_records zone_id, version_id, record_ids
      record_ids.each do |record_id|
        @api.domain.zone.record.delete(zone_id, version_id, id: record_id)
      end
    end

    def add_a_record zone_id, version_id, ip_address, ttl_secs
      params = { name: '@', type: 'A', value: ip_address, ttl: ttl_secs }
      @api.domain.zone.record.add zone_id, version_id, params
    end

  end

end
