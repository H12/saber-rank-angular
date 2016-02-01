class Batter < ActiveRecord::Base

  BAD_STATS = ['so', 'cs', 'gdp']

  def as_json(options = {})
    response = {'name' => name, 'team' => team}
    options[:stats].each { |stat| response[stat] = method(stat).call }
    response.each { |key, value| response[key] = sprintf('%.3f', value) if value.is_a?(Float) }
    stat_value = 0
    options[:stats].each do |stat|
      stat_value += normalize(stat, stat_min(stat), stat_max(stat)).to_f
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

  def stat_min(stat_method)
    case stat_method
    when "tb"
      stat_query("tb", "singles + doubles * 2 + triples * 3 + hr * 4", "min")
    when "ppa"
      stat_query("ppa", "pitches / pa", "min")
    when "rc"
      stat_query("rc", "r + rbi - hr", "min")
    when "sbn"
      stat_query("sbn", "sb - cs", "min")
    when "sac"
      stat_query("sac", "sh + sf", "min")
    when "xbh"
      stat_query("xbh", "doubles + triples + hr", "min")
    else
      Batter.minimum(stat_method)
    end
  end

  def stat_max(stat_method)
    case stat_method
    when "tb"
      stat_query("tb", "singles + doubles * 2 + triples * 3 + hr * 4", "max")
    when "ppa"
      stat_query("ppa", "pitches / pa", "max")
    when "rc"
      stat_query("rc", "r + rbi - hr", "max")
    when "sbn"
      stat_query("sbn", "sb - cs", "max")
    when "sac"
      stat_query("sac", "sh + sf", "max")
    when "xbh"
      stat_query("xbh", "doubles + triples + hr", "max")
    else
      Batter.maximum(stat_method)
    end
  end

  def normalize(stat_method, min, max)
    result = ((method(stat_method).call.to_f - min) / (max - min))
    (BAD_STATS.include? stat_method) ? 1 - result : result
  end

  private

  def stat_query(column_name, calculation, option)
    ActiveRecord::Base.connection.execute("SELECT #{option}(#{calculation}) AS #{column_name} FROM batters")[0][column_name].to_f
  end

end
