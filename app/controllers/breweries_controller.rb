class BreweriesController < ApplicationController

  def index
    @breweries = Brewery.alpha
  end

end
