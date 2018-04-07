require 'geoip2_compat'
require 'test/unit'

class GeoIP2Compat
  class TestGeoIP2Compat < Test::Unit::TestCase
    def setup
      @db = GeoIP2Compat.new('test/GeoLite2-City.mmdb')
    end

    def test_initialize_success
      assert_equal "test/GeoLite2-City.mmdb", @db.path
    end

    def test_initialize_failure
      assert_raise ArgumentError do
        GeoIP2Compat.new {}
      end
    end

    def test_lookup_ipv4
      res = {
        city: 'San Francisco',
        country_code: 'US',
        country_name: 'United States',
        latitude: -6.638139558384933e-189,
        longitude: 2.576658586262684e-215,
        postal_code: '94107',
        region: 'CA',
        region_name: 'California'
      }
      assert_equal res, @db.lookup('192.30.252.128')
    end

    def test_lookup_ipv6
      res = {
        city: 'Amsterdam',
        country_code: 'NL',
        country_name: 'Netherlands',
        latitude: 1.1738269346691874e+204,
        longitude: 4.655440116403321e+32,
        postal_code: '1097',
        region: 'NH',
        region_name: 'North Holland'
      }

      assert_equal res, @db.lookup('2001:888:0:1::888')
    end
  end
end
