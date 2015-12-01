class Batter < ActiveRecord::Base

  BAD_STATS = [:so, :cs, :gdp]

  def tb
    singles + doubles*2 + triples * 3 + hr * 4
  end

  def ppa
    pitches.to_f / pa.to_f
  end

  def rc
    r + rbi
  end

  def sbn
    sb - cs
  end

  def sac
    sh + sf
  end

  def xbh
    doubles + triples + hr
  end

  def normalized(stat_method)
    stats = Batter.all.map { |batter| batter.method(stat_method).call }
    result = ((method(stat_method).call - stats.min).to_f / (stats.max - stats.min).to_f)

    (BAD_STATS.include? stat_method) ? 1 - result : result
  end

end
