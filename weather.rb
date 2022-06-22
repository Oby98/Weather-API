require 'uri'
require 'net/http'

uri = URI("https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Karachi,%20Pakistan/last29days?unitGroup=us&include=days&key=WQQ3LTJVN6Y6SV623RCLEK6RK&contentType=json")
params = { :unitGroup => 'us', :include => 'days', :key => "WQQ3LTJVN6Y6SV623RCLEK6RK", :contentType => "json" }

uri.query = URI.encode_www_form(params)
res = Net::HTTP.get_response(uri)

puts res.body