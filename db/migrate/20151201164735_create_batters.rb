class CreateBatters < ActiveRecord::Migration
  def change
    create_table :batters do |t|
      t.string  :name
      t.string  :team
      t.string   :avg
      t.integer :hr
      t.integer :r
      t.integer :rbi
      t.integer :sb
      t.string   :slg
      t.string   :obp
      t.string   :ops
      t.integer :so
      t.integer :singles
      t.integer :doubles
      t.integer :triples
      t.integer :ab
      t.integer :bb
      t.integer :cs
      t.integer :gdp
      t.integer :h
      t.integer :hbp
      t.integer :ibb
      t.integer :pitches
      t.integer :pa
      t.integer :sf
      t.integer :sh

      t.timestamps null: false
    end
  end
end
