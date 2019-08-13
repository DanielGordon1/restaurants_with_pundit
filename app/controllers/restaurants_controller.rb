class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # YAGNI
  # You Arent Gonna Need It
  # Dont overcomplicate stuff

  # GET /restaurants
  # GET /restaurants.json
  def index
    # @restaurants = Restaurant.all
    @restaurants = policy_scope(Restaurant) # returns a colleciton of objects(restaurants)
    # collection of objects -> policy scope -> resolve inside the RestaurantsPolicy
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    # authorize(@restaurant) # -> show? inside RestaurantPolicy
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
    # When we call authorize
    # Pundit will look for a policy with the same name as the controller
    # RestaurantsController -> RestaurantPolicy
    # And then look for an action with the same name, suffixed with a ? in that policy
    # action
    # new -> new?
    authorize(@restaurant)
  end

  # GET /restaurants/1/edit
  def edit
    # current_user is a helper method implemented in devise.
    # In any controller or any view you have access to the person who is currently logged in.
    # Manual authorization
    # authorize(@restaurant)
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)
    authorize(@restaurant)
    @restaurant.user = current_user
    if @restaurant.save
      redirect_to @restaurant, notice: 'Restaurant was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    # authorize(@restaurant)
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: 'Restaurant was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    # authorize(@restaurant)
    @restaurant.destroy
    redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
      authorize(@restaurant)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name)
    end
end
