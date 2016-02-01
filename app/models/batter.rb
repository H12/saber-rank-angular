class Batter < ActiveRecord::Base

  BAD_STATS = ['so', 'cs', 'gdp']

  def as_json(options = {})
    response = {'name' => name, 'team' => team}

    options[:stats].each { |stat, min_max_values| response[stat] = method(stat).call }
    response.each { |key, value| response[key] = sprintf('%.3f', value) if value.is_a?(Float) }

    stat_value = 0
    options[:stats].each do |stat, min_max_values|
      stat_value += normalize(stat, min_max_values['min'], min_max_values['max']).to_f
    end
    response['stat'] = ((stat_value * 60 / options[:stats].length) + 20).to_i

    mappings = {'singles' => 's', 'doubles' => 'd', 'triples' => 't', 'pitches' => 'p'}
    response = response.map {|k,v| mappings.keys.include?(k) ? [mappings[k], v] : [k,v]}.to_h

    response
  end

  def tb
    singles + doubles * 2 + triples * 3 + hr * 4
  end

  def ppa
    sprintf('%.2f', (pitches.to_f / pa.to_f))
  end

  def rc
    r + rbi - hr
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

  def normalize(stat_method, min, max)
    result = ((method(stat_method).call.to_f - min) / (max - min))
    (BAD_STATS.include? stat_method) ? 1 - result : result
  end

  def self.stat_min(stat_method, min_pa)
    case stat_method
    when "tb"
      Batter.stat_query("tb", "singles + doubles * 2 + triples * 3 + hr * 4", "MIN", min_pa)
    when "ppa"
      Batter.stat_query("ppa", "pitches / pa", "MIN", min_pa)
    when "rc"
      Batter.stat_query("rc", "r + rbi - hr", "MIN", min_pa)
    when "sbn"
      Batter.stat_query("sbn", "sb - cs", "MIN", min_pa)
    when "sac"
      Batter.stat_query("sac", "sh + sf", "MIN", min_pa)
    when "xbh"
      Batter.stat_query("xbh", "doubles + triples + hr", "MIN", min_pa)
    else
      Batter.where('pa > 500').minimum(stat_method)
    end
  end

  def self.stat_max(stat_method, min_pa)
    case stat_method
    when "tb"
      Batter.stat_query("tb", "singles + doubles * 2 + triples * 3 + hr * 4", "MAX", min_pa)
    when "ppa"
      Batter.stat_query("ppa", "pitches / pa", "MAX", min_pa)
    when "rc"
      Batter.stat_query("rc", "r + rbi - hr", "MAX", min_pa)
    when "sbn"
      Batter.stat_query("sbn", "sb - cs", "MAX", min_pa)
    when "sac"
      Batter.stat_query("sac", "sh + sf", "MAX", min_pa)
    when "xbh"
      Batter.stat_query("xbh", "doubles + triples + hr", "MAX", min_pa)
    else
      Batter.where('pa > 500').maximum(stat_method)
    end
  end

  def self.stat_query(column_name, calculation, option, min_pa)
    ActiveRecord::Base.connection.execute("SELECT #{option}(#{calculation}) AS #{column_name} FROM batters WHERE pa > #{min_pa}")[0][column_name].to_f
  end

end
