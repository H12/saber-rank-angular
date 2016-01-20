class BattersController < ApplicationController
  def index
    @batters = Batter.all

    params[:stats] ? stats = JSON.parse(params[:stats]) : stats = ['r', 'hr', 'rbi', 'sb', 'obp', 'slg']

    respond_to do |format|
      format.json { render :json => @batters, :stats => stats}
    end
  end
end
