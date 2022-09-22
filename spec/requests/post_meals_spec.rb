require 'rails_helper'

RSpec.describe 'Meals', type: :request do
  describe 'POST /create' do
    context 'with valid parameters' do
    #   let!(:my_meal) { FactoryBot.create(:meal) }
    
      
    #   before do
    #     post '/meals', params:
    #                       { meal: {
    #                         title: my_meal.title,
    #                         description: my_meal.description
    #                       } }
    #   end

    #   it 'returns the title' do
    #     expect(json['title']).to eq(my_meal.title)
    #   end

    #   it 'returns the description' do
    #     expect(json['description']).to eq(my_meal.description)
    #   end

    #   it 'returns a created status' do
    #     expect(response).to have_http_status(:created)
    #   end
    # end

    # context 'with invalid parameters' do
    #   before do
    #     post '/meals', params:
    #                       { meal: {
    #                         title: '',
    #                         description: ''
    #                       } }
    #   end

    #   it 'returns a unprocessable entity status' do
    #     expect(response).to have_http_status(:unprocessable_entity)
    #   end
    end
  end
end