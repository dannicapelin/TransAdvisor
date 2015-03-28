class ReviewsController < ApplicationController
  before_action :set_institution
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews/1
  def show
  end

  # GET /reviews/new
  def new
    @institution = Institution.find(params[:institution_id])
    @review = Review.new(institution: @institution)
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to institution_review_path(@institution, @review),
                  notice: 'Review was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /reviews/1
  def update
    if @review.update(review_params)
      redirect_to @review, notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /reviews/1
  # def destroy
  #   @review.destroy
  #   redirect_to reviews_url, notice: 'Review was successfully destroyed.'
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  def set_institution
    @institution = Institution.find(params[:institution_id])
  end

  # Only allow a trusted parameter "white list" through.
  def review_params
    args = params.require(:review).permit(
      :rating, :youth_friendly, :title, :body
    )
    args[:institution_id] = params.require(:institution_id)
    args
  end
end
