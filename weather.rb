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
puts "date        city        wind_avg    wind_median     temp_avg     temp_median "

cities.each do|city,country|
  wind = []
  #preparing the endpoint beforehand
  endpoint = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/#{city},%20#{country}/last29days?unitGroup=us&include=days&key=WQQ3LTJVN6Y6SV623RCLEK6RK&contentType=json"
  uri = URI(endpoint)
  params = { :unitGroup => 'us', :include => 'days', :key => "WQQ3LTJVN6Y6SV623RCLEK6RK", :contentType => "json" }

  uri.query = URI.encode_www_form(params)
  res = Net::HTTP.get_response(uri)

  data = JSON.parse(res.body)

  data['days'].each do |day|

    #Getting mean and median for temperature and wind
    temp_avg = (day['tempmax'] + day['tempmin'] / 2.0).round(1)
    temp_median = get_median([day['tempmax'],day['tempmin']])

    wind.append(day['windspeed'])
    wind_median = get_median(wind)
    wind_avg = (wind.sum(2)/wind.size).round(1)

    #outputing the data for each city.
    puts "#{day['datetime']}        #{city}, #{country}        #{wind_avg}    #{wind_median}     #{temp_avg}     #{temp_median}"
  end


end