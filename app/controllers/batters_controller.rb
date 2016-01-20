class BattersController < ApplicationController
  def index
    @batters = Batter.all

    params[:stats] ? stats = JSON.parse(params[:stats]) : stats = ['avg', 'hr', 'r', 'rbi', 'sb']

    respond_to do |format|
      format.json { render :json => @batters, :stats => stats}
    end
  end
end
