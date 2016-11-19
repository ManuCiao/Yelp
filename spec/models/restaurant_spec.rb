require 'rails_helper'

describe Restaurant, type: :model do
  it 'is not valid with a nameless than 3 characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

       it 'is not valid with a nameless than 3 characters' do
          restaurant = Restaurant.new(name: 'kf')
          expect(restaurant).to have(1).error_on(:name)
          expect(restaurant).not_to be_valid
      end

      it 'is not valid unless it has a unique name' do
          Restaurant.create(name: 'Dial Arch')
          restaurant = Restaurant.new(name: 'Dial Arch')
          expect(restaurant).to have(1).error_on(:name)
      end

      describe 'reviews' do
          describe 'build_with_user' do
              let(:user) { User.create email: 'test@test.com,' }
              let(:restaurant) { Restaurant.create name: 'Test' }
              let(:review_params) { { rating: 5, thoughts: 'yum' } }

              subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

              it 'builds a review' do
                  expect(review).to be_a Review
              end

              it 'builds a review associated with the specified user' do
                  expect(review.user).to eq user
              end
          end
      end

      describe '#average_rating' do
          context 'no reviews' do
              it 'returns "N/A" when there are no reviews' do
                  restaurant = Restaurant.create(name: 'The Ivy')
                  expect(restaurant.average_rating).to eq 'N/A'
              end
          end

          context '1 review' do
              it 'returns that rating' do
                  restaurant = Restaurant.create(name: 'The Ivy')
                  restaurant.reviews.create(rating: 4)
                  expect(restaurant.average_rating).to eq 4
              end
          end

          context 'multiple reviews' do
              it 'returns the average' do
                  restaurant = Restaurant.create(name: 'The Ivy')
                  restaurant.reviews.create(rating: 1)
                  restaurant.reviews.create(rating: 5)
                  expect(restaurant.average_rating).to eq 3
              end
          end
      end
end
