#!/usr/bin/env ruby
# "Scrape" the website based on its `/auto.appcache` file
# Daniel Ethridge

require 'net/http'
require 'digest'
require 'fileutils'

module SurgeScrape
  def rm_dot(path)
    return path[1..-1]
  end

  def get(site, file)
    uri = URI.parse("#{site}/#{file}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)#, {"Accept-Encoding" => "gzip"})
    response = http.request(request)
    return response.body
  end

  def get_cache_list(site)
    cache_manifest = get(site, "auto.appcache")
    cache = cache_manifest
    files = cache.scan( /^\/.+\..+$/ )
    hashes = cache.scan( /[a-f0-9]{32}/i )
    out = {}
    for i in 0...hashes.length
      out[files[i].chomp] = hashes[i].chomp
    end
    if out.empty?
      puts "Website does not have a `/auto.appcache` file, try a *.surge.sh URL"
      exit
    end
    return out
  end

  def get_local_list()
    files = Dir.glob("./**/*", File::FNM_DOTMATCH).select{ |e| File.file?(e) }
    hashes = []
    files.each { |f| hashes << Digest::MD5.file(f).hexdigest }
    out = {}
    for i in 0...hashes.length
      out[files[i].chomp] = hashes[i].chomp
    end
    return out
  end

  def compare_lists(cache, local)
    local.keys.each { |k| local[rm_dot(k)] = local.delete k }
    diffs = ( cache.to_a - local.to_a ).to_h.keys
    extra = ( local.to_a - cache.to_a ).to_h.keys - diffs
    if ! extra.empty?
      puts "This directory has file(s) that are not recorded on the website, \
they will not be overwritten : \n#{extra.join("\n")} \n\n"
    end
    if ! diffs.empty?
      puts "The website has different versions of your files and/or new files, \
your version of these will be overwritten : \n#{diffs.join("\n")} \n\n"
      return diffs
    else
      return nil
    end
  end

  def get_files(site, files)
    puts "Downloading #{files.length} file(s)..."
    files.each do |file|
      retrieved = get(site, file)
      if retrieved.nil?
        puts "#{file} could not be downloaded"
        next
      end
      FileUtils.mkdir_p("./#{File.dirname(file)}") unless Dir.exists?("./#{File.dirname(file)}")
      local = File.open("./#{file}", "w")
      local.write retrieved
      puts "Downloaded #{file}"
    end
  end

  def scrape(site)
    puts "Scraping the files from #{site}..."
    cache = get_cache_list(site)
    local = get_local_list()
    files = compare_lists(cache, local)
    if files.nil?
      puts "Nothing to download"
      exit
    end
    get_files(site, files)
    puts "Finished!"
  end
end