class BattersController < ApplicationController
  def index
    @batters = Batter.all

    respond_to do |format|
      format.json { render :json => @batters, :stats => [:avg, :hr, :r, :rbi, :sb]}
    end
  end
end
