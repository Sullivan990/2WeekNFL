require 'sinatra'
require 'csv'
require 'pry'

before do
  @game = [
  { home_team: "Patriots",
    away_team: "Broncos",
    home_score: 7,
    away_score: 3
    },
  { home_team: "Broncos",
    away_team: "Colts",
    home_score: 3,
    away_score: 0
    },
  { home_team: "Patriots",
    away_team: "Colts",
    home_score: 11,
    away_score: 7
    },
  { home_team: "Steelers",
    away_team: "Patriots",
    home_score: 7,
    away_score: 21
    }
  ]
  @team_stat = {
    "Patriots" => {
      win: 3,
      loss: 0
    },
    "Broncos" => {
      win: 1,
      loss: 1
    },
    "Steelers" => {
      win: 0,
      loss: 1
    },
    "Colts" => {
      win: 0,
      loss: 2
    }
  }

end


get '/' do
  erb :index
end

get '/leaderboard' do
  erb :leaderboard
end
