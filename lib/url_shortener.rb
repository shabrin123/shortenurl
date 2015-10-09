require 'rubygems'
require 'net/http'
require 'uri'

module UrlShortener
  
class Client
   
   extend ShortenerBase    

    def self.shorten(url, opts={})
      unless url.include?(URL)
        if url.is_a? String
          request = self.create_url(url)
        else
          raise ArgumentError.new("Shorten requires either a url")
        end
      else
         false
      end
    end


  def self.create_url(url)
   short_url = ShortenerBase.encode
#  "http://#{URL}/#{short_url}"
   
  end 
  def self.generate_shorten_url(key)
   "http://#{URL}/#{key}"
  end  
  end

end


