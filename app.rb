require "sinatra"
require "sinatra/reloader"
require "httparty"
def view(template); erb template.to_sym; end

get "/" do
  ### Get the weather
  # Evanston, Kellogg Global Hub... replace with a different location if you want
  lat = 42.0574063
  long = -87.6722787

  units = "metric" # or imperial, whatever you like
  key = "7c9512cb0254c92d9b41b22e973a51a2" # replace this with your real OpenWeather API key

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&units=#{units}&appid=#{key}"

  # make the call
  @forecast = HTTParty.get(url).parsed_response.to_hash

  ### Get the news
  url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=a8d78b6bd51a47ac9cb2ebeaf8a9c22b"
  @news = HTTParty.get(url).parsed_response.to_hash

  view "news"
end