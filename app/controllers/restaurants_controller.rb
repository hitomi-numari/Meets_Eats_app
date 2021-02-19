class RestaurantsController < ApplicationController
  def index
    url = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key="
    api_key = ENV['API']
    url << api_key
    if params[:search]
      word = params[:search]
      word = word.gsub(/[\s　]/, ',')
      url << "&keyword=" << word << "&format=json"
      url = URI.encode(url)
      uri = URI.parse(url)
      json = Net::HTTP.get(uri)
      @results = JSON.parse(json)["results"]["shop"]
    end
  end
end
