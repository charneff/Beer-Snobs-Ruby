class BreweriesController < ApplicationController
  before_action :redirect_if_not_logged_in

  def index
    @breweries = Brewery.alpha
  end

end
