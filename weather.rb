require 'uri'
require 'net/http'
require 'json'

def get_median(arr)
  sorted = arr.sort
  mid = sorted.length/2
  (sorted[mid-1,2].sum/2.0).round(1)
end

cities = [['Copenhagen','Denmark'], ['Lodz','Poland'], ['Brussels','Belgium'], ['Islamabad','Pakistan']]

#outputs the first line.
puts "city        wind_avg    wind_median     temp_avg     temp_median "

cities.each do|city,country|

  #preparing the endpoint beforehand
  endpoint = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/#{city},%20#{country}/last29days?unitGroup=us&include=days&key=WQQ3LTJVN6Y6SV623RCLEK6RK&contentType=json"
  uri = URI(endpoint)
  params = { :unitGroup => 'us', :include => 'days', :key => "WQQ3LTJVN6Y6SV623RCLEK6RK", :contentType => "json" }

  uri.query = URI.encode_www_form(params)
  res = Net::HTTP.get_response(uri)

  data = JSON.parse(res.body)

  #extracting the necessary columns
  days_temp = data['days'].collect{|day| day["temp"]}
  days_speed = data['days'].collect{|day| day["windspeed"]}

  #Getting mean and median for temperature and wind
  temp_median = get_median(days_temp)
  speed_median = get_median(days_speed)
  temp_avg = (days_temp.sum(2)/days_temp.size).round(1)
  speed_avg = (days_speed.sum(2)/days_speed.size).round(1)

  #outputing the data for each city.
  puts "#{city}, #{country}        #{speed_avg}    #{speed_median}     #{temp_avg}     #{temp_median}"

end