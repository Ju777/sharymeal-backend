require "test_helper"

class MealsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meal = meals(:one)
  end

  test "should get index" do
    get meals_url, as: :json
    assert_response :success
  end

  test "should create meal" do
    assert_difference("Meal.count") do
      post meals_url, params: { meal: { alcool: @meal.alcool, allergens: @meal.allergens, animals: @meal.animals, description: @meal.description, diet_type: @meal.diet_type, doggybag: @meal.doggybag, guest_capacity: @meal.guest_capacity, guest_registered: @meal.guest_registered, location: @meal.location, price: @meal.price, starting_date: @meal.starting_date, theme: @meal.theme, title: @meal.title } }, as: :json
    end

    assert_response :created
  end

  test "should show meal" do
    get meal_url(@meal), as: :json
    assert_response :success
  end

  test "should update meal" do
    patch meal_url(@meal), params: { meal: { alcool: @meal.alcool, allergens: @meal.allergens, animals: @meal.animals, description: @meal.description, diet_type: @meal.diet_type, doggybag: @meal.doggybag, guest_capacity: @meal.guest_capacity, guest_registered: @meal.guest_registered, location: @meal.location, price: @meal.price, starting_date: @meal.starting_date, theme: @meal.theme, title: @meal.title } }, as: :json
    assert_response :success
  end

  test "should destroy meal" do
    assert_difference("Meal.count", -1) do
      delete meal_url(@meal), as: :json
    end

    assert_response :no_content
  end
end
