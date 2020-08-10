class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update]
  before_action :redirect_if_not_logged_in

  def new
    @beer = Beer.new
    @beer.build_brewery
    flash[:alert] = "If you wish to create a new brewery select Create New Brewery from dropdown."
  end

  def create
    if !!logged_in?
      @beer = Beer.create(beer_params)
      @beer.user_id = session[:user_id]

      if @beer.save
        # @beer.image.purge
        @beer.image.attach(params[:image])
        flash[:alert] = "Beer created!"
        redirect_to beer_path(@beer)
      else
        @beer.build_brewery
        render :new
      end
    else
      redirect_to login_path
    end
  end

  def show
  end

  def edit
    if current_user != @beer.user
      flash[:alert] = "Only the creator of a beer can edit its details"
      redirect_to beer_path(@beer)
    else
      flash[:alert] = "If you wish to create a new brewery select Create New Brewery from dropdown."
    end
  end

  def index
    if params[:q]
      if !params[:brewery_id]
        @beers = Beer.where("name like ?", "%#{params[:q]}%")
      else
        @brewery = Brewery.find_by_id(params[:brewery_id])
        @beers = Beer.where("brewery_id like ? and name like ?", params[:brewery_id], "%#{params[:q]}%")
      end
    else
      if params[:brewery_id]
        @brewery = Brewery.find_by_id(params[:brewery_id])
        @beers = Beer.where(brewery_id: params[:brewery_id]).order_by_rating
      else
        @beers = Beer.order_by_rating.includes(:brewery)
      end
    end
  end

  def update
    @beer.image.purge
    @beer.image.attach(params[:image])
    if params[:brewery_id]
      @beer.update(beer_update_params)
    else
      @beer.update(beer_params)
    end

    if @beer.save
      flash[:alert] = "Beer updated"
      redirect_to beer_path(@beer)
    else
      render :edit
    end
  end

  def destroy
    Beer.find(params[:id]).destroy
    redirect_to beers_path
  end


  private

    def beer_params
       params.require(:beer).permit(:name, :style, :abv, :flavor_profile, :image, :brewery_id, brewery_attributes:[:name, :location])
    end

    def beer_update_params
      params.require(:beer).permit(:name, :style, :abv, :flavor_profile, :image, :brewery_id)
    end

    def set_beer
      @beer = Beer.find_by_id(params[:id])
      @brewery = @beer.brewery
      redirect_to beers_path if !@beer
    end
end
