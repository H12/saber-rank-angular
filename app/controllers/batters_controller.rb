class BattersController < ApplicationController
  def index
    params[:min_pa] ||= 500
    @batters = Batter.where("pa >= :min_pa", {min_pa: params[:min_pa]})

    params[:stats] && JSON.parse(params[:stats]).length > 0 ? stats = JSON.parse(params[:stats]) : stats = ['avg', 'hr', 'r', 'rbi', 'sb']
    stats = stats.map { |stat| [stat, {'min' => Batter.stat_min(stat, params[:min_pa]), 'max' => Batter.stat_max(stat, params[:min_pa])}] }.to_h

    respond_to do |format|
      format.json { render :json => @batters, :stats => stats}
    end
  end
end
