class Batter < ActiveRecord::Base

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

end
