class BattersController < ApplicationController
  def index
    @batters = Batter.all

    params[:stats] ? stats = JSON.parse(params[:stats]) : stats = ['avg', 'hr', 'r', 'rbi', 'sb']
    stats = stats.map { |stat| [stat, {'min' => Batter.stat_min(stat), 'max' => Batter.stat_max(stat)}] }.to_h

    respond_to do |format|
      format.json { render :json => @batters, :stats => stats}
    end
  end
end
