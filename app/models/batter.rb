class Batter < ActiveRecord::Base

  BAD_STATS = [:so, :cs, :gdp]

  def as_json(options = {})
    response = attributes.merge(tb: tb, ppa: ppa, rc: rc, sbn: sbn, sac: sac, xbh: xbh).select do |key|
      (options[:stats].map { |stat| stat.to_s } + ['name', 'team']).include?(key)
    end
    response.each { |key, value| response[key] = sprintf('%.3f', value) if value.is_a?(Float) }
    options[:stats].each {|stat| response[:"n_#{stat.to_s}"] = normalized(stat)}

    response
  end

  def tb
    singles + doubles * 2 + triples * 3 + hr * 4
  end

  def ppa
    sprintf('%.2f', (pitches.to_f / pa.to_f))
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
    stats = Batter.all.map { |batter| batter.method(stat_method).call.to_f }
    result = ((method(stat_method).call.to_f - stats.min) / (stats.max - stats.min))

    (BAD_STATS.include? stat_method) ? sprintf('%.2f', (1 - result)) : sprintf('%.2f', (result))
  end

end
