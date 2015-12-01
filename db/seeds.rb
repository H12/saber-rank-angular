require 'csv'

CSV.foreach("lib/assets/csvs/batters_2015.csv", headers: true) do |row|
  Batter.create(row.to_hash)
end