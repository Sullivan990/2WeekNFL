require 'sinatra'
require 'csv'

# We start with something like this in the CSV file...

# home_team,away_team,home_score,away_score
# Patriots,Broncos,7,3
# Broncos,Colts,3,0
# Patriots,Colts,11,7
# Steelers,Patriots,7,21

# and want to end up with something like this:

{
  'Patriots' => { wins: 3, losses: 0 },
  'Broncos' => { wins: 2, losses: 1 },
  'Colts' => { wins: 0, losses: 2 },
  'Steelers' => { wins: 0, losses: 1 }
}

before do
  game_data_file = 'data/season_games.csv'

  team_stats = {}

  CSV.foreach(game_data_file, headers: true) do |game|
    home_team = game['home_team']
    away_team = game['away_team']

    # Our team_stats hash is initially empty so we have
    # to check if both teams have a previous record. If
    # not, we can give them a blank record (no wins, no losses).
    if !team_stats.has_key?(home_team)
      team_stats[home_team] = { wins: 0, losses: 0 }
    end

    if !team_stats.has_key?(away_team)
      team_stats[away_team] = { wins: 0, losses: 0 }
    end

    # Now figure out who the winner and loser of each game
    # was and update their records.

    home_score = game['home_score'].to_i
    away_score = game['away_score'].to_i

    # Assume there were no ties...
    if home_score > away_score
      team_stats[home_team][:wins] += 1
      team_stats[away_team][:losses] += 1
    else
      team_stats[home_team][:losses] += 1
      team_stats[away_team][:wins] += 1
    end
  end

  # Sort the stats by the number of wins in descending order
  # first and then the number of losses in ascending. The
  # output from sort_by would look something like:
  #
  # [["Patriots", {:wins=>3, :losses=>0}],
  #  ["Broncos", {:wins=>2, :losses=>1}],
  #  ["Steelers", {:wins=>0, :losses=>1}],
  #  ["Colts", {:wins=>0, :losses=>2}]]

  @team_stats = team_stats.sort_by do |team_name, record|
    [-record[:wins], record[:losses]]
  end

end

get '/' do
  erb :index
end

get '/leaderboard' do
  erb :leaderboard
end
