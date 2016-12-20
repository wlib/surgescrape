#!/usr/bin/env ruby
# "Scrape" the website and decide what files need to be downloaded
# Daniel Ethridge

require 'net/http'
require 'fileutils'

module SurgeScrape
  def scrape(site)
    uri = URI.parse("#{site}/auto.appcache")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    puts response.body
  end
end