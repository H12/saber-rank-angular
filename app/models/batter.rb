class Batter < ActiveRecord::Base

  BAD_STATS = [:so, :cs, :gdp]

  def as_json(options = {})
    response = {'name' => name, 'team' => team}
    options[:stats].each do |stat|
      response[stat] = method(stat).call
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

  def normalized(stat_method)
    case stat_method
    when :tb
      min = stat_query("tb", "singles + doubles * 2 + triples * 3 + hr * 4", "min")
      max = stat_query("tb", "singles + doubles * 2 + triples * 3 + hr * 4", "max")
    when :ppa
      min = stat_query("ppa", "pitches / pa", "min")
      max = stat_query("ppa", "pitches / pa", "max")
    when :rc
      min = stat_query("rc", "r + rbi - hr", "min")
      max = stat_query("rc", "r + rbi - hr", "max")
    when :sbn
      min = stat_query("sbn", "sb - cs", "min")
      max = stat_query("sbn", "sb - cs", "max")
    when :sac
      min = stat_query("sac", "sh + sf", "min")
      max = stat_query("sac", "sh + sf", "max")
    when :xbh
      min = stat_query("xbh", "doubles + triples + hr", "min")
      max = stat_query("xbh", "doubles + triples + hr", "max")
    else
      min = Batter.minimum(stat_method)
      max = Batter.maximum(stat_method)
    end

    result = ((method(stat_method).call.to_f - min) / (max - min))
    (BAD_STATS.include? stat_method) ? sprintf('%.2f', (1 - result)) : sprintf('%.2f', (result))
  end

  private

  def stat_query(column_name, calculation, option)
    ActiveRecord::Base.connection.execute("SELECT #{option}(#{calculation}) AS #{column_name} FROM batters")[0][column_name].to_f
  end

end
