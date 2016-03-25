# spec/vcr_helper.rb

# spec/vcr_helper.rb

# VCR RSpec integration
#

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "#{::Rails.root }/spec/cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.default_cassette_options = {:record => :none }

  # Custom request mather that ignores trailing id
  #
  config.register_request_matcher :uri_ignoring_trailing_id do |request_1, request_2|
    uri1, uri2 = request_1.uri, request_2.uri
    regexp_trail_id = %r(/\d+)
    if uri1.match(regexp_trail_id)
      r1_without_id = uri1.gsub(regexp_trail_id, '')
      r2_without_id = uri2.gsub(regexp_trail_id, '')
      uri1.match(regexp_trail_id) && uri2.match(regexp_trail_id) && r1_without_id == r2_without_id
    else
      uri1 == uri2
    end
  end

end
