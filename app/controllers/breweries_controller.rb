class BreweriesController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :set_brewery, only: [:show, :edit, :update]

  def index
    if params[:q]
      @breweries = Brewery.where("name like ?", "%#{params[:q]}%").alpha
    else
      @breweries = Brewery.alpha
    end
  end

  def new
    @brewery = Brewery.new
  end

  def show
  end

  def create
    if !!logged_in?
      @brewery = Brewery.create(brewery_params)

      if @brewery.save
        flash[:alert] = "Brewery created!"
        redirect_to brewery_path(@brewery)
      else
        render :new
      end
    else
      redirect_to login_path
    end
  end

  def edit
  end

  def update
    @brewery.update(brewery_params)
    if @brewery.save
      flash[:alert] = "Brewery updated"
      redirect_to brewery_path(@brewery)
    else
      render :edit
    end
  end

  private

  def brewery_params
     params.require(:brewery).permit(:name, :location)
  end

  def set_brewery
    @brewery = Brewery.find_by_id(params[:id])
  end

end
