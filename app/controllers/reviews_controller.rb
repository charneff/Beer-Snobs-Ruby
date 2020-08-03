class ReviewsController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :set_review, only: [:show, :edit, :update]

  def new
    if @beer = Beer.find_by_id(params[:beer_id])
      @review = @beer.reviews.build
    else
      @review = Review.new
    end
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:alert] = "Review created."
      redirect_to review_path(@review)
    else
      render :new
    end
  end

  def show

  end

  def index
    if @beer = Beer.find_by_id(params[:beer_id])
      @reviews = @beer.reviews
    else
      @reviews = Review.all
    end
  end

  def edit

  end

  def update
    @review.update(review_params)
    if @review.save
      redirect_to review_path(@review)
    else
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(:beer_id, :stars, :title, :content)
  end

  def set_review
    @review = Review.find(params[:id])
  end

end
