class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show update destroy ]

  # GET /reviews
  def index
    @reviews = Review.all

    render json: @reviews
  end

  # GET /host_reviews
  def get_host_reviews
    host_reviews = Review.all.where(host: User.find(params[:id]))

    render json: {
      host_reviews: host_reviews
    }
  end

  # GET /reviews/1
  def show
    render json: @review
  end

  # POST /reviews
  def create
    user = get_user_from_token
    @review = Review.new(review_params)
    @review.author = user

    if @review.save
      render json: @review, status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reviews/1
  def update
    if @review.update(review_params)
      render json: @review
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reviews/1
  def destroy
    @review.destroy
  end

  private

    def get_user_from_token
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], ENV["JWT_SECRET_KEY"]).first
      user_id = jwt_payload['sub']
      User.find(user_id.to_s)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:content, :rating, :host)
    end
end
