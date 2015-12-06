class HomeController < ApplicationController
  def index
    @batter = Batter.first
  end
end