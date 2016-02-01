require 'csv'

CSV.foreach("lib/assets/csvs/batters_full_2015.csv", headers: true) do |row|
  Batter.create(row.to_hash) unless row.to_hash['pa'].to_i <= 0
end