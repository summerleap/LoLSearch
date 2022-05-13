class SearchController < ApplicationController

  require 'net/http'
  require 'uri'
  require 'json'
  API_KEY = "RGAPI-34af3007-de34-4d5e-865c-0d23979a2704"

  def search
    if name = params[:name]
      summoner_name = URI.encode_www_form_component(name)
      uri = URI.parse("https://jp1.api.riotgames.com/lol/summoner/v4/summoners/by-name/#{summoner_name}?api_key=#{API_KEY}")
      response = Net::HTTP.get_response(uri)
      info = JSON.parse(response.body)
      @summoner_name = info["name"]
      @summoner_level = info["summonerLevel"]
      @summoner_icon = info["profileIconId"]
      @summoner_id = info["id"]
    end

    uri = URI.parse("https://jp1.api.riotgames.com/lol/league/v4/entries/by-summoner/#{@summoner_id}?api_key=#{API_KEY}")
    response = Net::HTTP.get_response(uri)
    stats = JSON.parse(response.body)
    if stats[0]
    @tier = stats[0]["tier"]
    @rank = stats[0]["rank"]
    @LP = stats[0]["leaguePoints"]
    @wins = stats[0]["wins"]
    @losses = stats[0]["losses"]
    end
  end
end