require 'sinatra'
require 'csv'
require 'pry'

before do
  @game = {}

  CSV.foreach('public/season_games.csv', headers: true) do |row|

    if @game = [{
      home_team: row[0],
      away_team: row[1],
      home_score: row[2],
      away_score: row[3]
    }]
    @team_stat = {
      "Patriots" => {
        win: 0,
        loss: 0
      },
      "Colts" => {
        win: 0,
        loss: 0
      },
      "Broncos" => {
        win: 0,
        loss: 0
      },
      "Steelers" => {
        win: 0,
        loss: 0
      }
    }
  end
end
binding.pry
get '/' do
  erb :index
end

get '/leaderboard' do
  erb :leaderboard
end
