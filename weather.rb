require 'uri'
require 'net/http'
require 'json'

def get_median(arr)
  sorted = arr.sort
  mid = sorted.length/2
  sorted[mid-1,2].sum/2.0
end

cities_data = []
uri = URI("https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Karachi,%20Pakistan/last29days?unitGroup=us&include=days&key=WQQ3LTJVN6Y6SV623RCLEK6RK&contentType=json")
params = { :unitGroup => 'us', :include => 'days', :key => "WQQ3LTJVN6Y6SV623RCLEK6RK", :contentType => "json" }

uri.query = URI.encode_www_form(params)
res = Net::HTTP.get_response(uri)

data = JSON.parse(res.body)

days_temp = data['days'].collect{|day| day["temp"]}
days_speed = data['days'].collect{|day| day["windspeed"]}

temp_median = get_median(days_temp)
speed_median = get_median(days_speed)

temp_avg = (days_tmp.sum(2)/days_tmp.size).round(2)
speed_avg = (days_speed.sum(2)/days_speed.size).round(2)
