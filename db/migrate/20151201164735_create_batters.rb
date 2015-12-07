class CreateBatters < ActiveRecord::Migration
  def change
    create_table :batters do |t|
      t.string  :name
      t.string  :team
      t.float   :avg
      t.integer :hr
      t.integer :r
      t.integer :rbi
      t.integer :sb
      t.float   :slg
      t.float   :obp
      t.float   :ops
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
