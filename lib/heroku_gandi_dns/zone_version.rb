
module HerokuGandiDns

  class ZoneVersion

    attr_reader :version_id, :records

    def initialize version_id, records
      @version_id, @records = version_id, records
    end

    def ip_address
      if single_a_record?
        a_records.first.value
      else
        raise 'no single IP address'
      end
    end

    def single_a_record?
      a_records.size == 1
    end

    def a_records
      @records.select {|r| r.type == 'A'}
    end

  end

end
