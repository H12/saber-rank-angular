class BattersController < ApplicationController
  def index
    @batters = Batter.all

    respond_to do |format|
      format.json { render :json => @batters, :stats => [:r, :hr, :rbi, :sb, :obp, :slg]}
    end
  end
end
