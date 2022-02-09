#!/usr/bin/ruby

##Required libraries
require 'net/http'
require 'uri'
require "base64"
require "openssl"
require 'thread'

## Global Variables
$item_ids = ARGV
$url = URI.parse("https://challenges.qluv.io")


class ItemApi
  def initialize ids
    @item_ids = ids
  end
  
  ## Method to perform get-req for an id`
  def api_call id
    enc = Base64.encode64(id)
    path = "/items/#{id}" 
    req = Net::HTTP::Get.new($url+path)
    req['Authorization'] = enc.strip
    res = Net::HTTP.start($url.hostname, $url.port, :use_ssl => true) {|http|
      http.request(req)
    }
    res.body
  end
  
  ## Method to break ids in batches and create threads to perform get requests for ids
  def getItemsData
    results = {}
    @item_ids.each_slice(5) do |batch|
      threads = []
      puts "Fetching data for item: #{batch}"
      batch.each do |id|
        threads << Thread.new {
          results[id] ||= api_call(id)
        }  
      end
      puts "Data fetched for ids: #{batch}"
      threads.map(&:join)
    end
    return results
  end
end

## Main Method
def main
  if $item_ids.empty?
    p "Please Enter item ids in the following manner:"
    p "ruby getItemsData.rb id_1 id_2 id_2 ... id_n"
    p "For eg.:   ruby get-items-data.rb  1 2 3 4 5 "
  else
    obj = ItemApi.new($item_ids.uniq)
    items_data = obj.getItemsData
    puts items_data
  end
end

## Call inital logic of the script
main
