require 'rails_helper'
require_relative 'sign_in_helper'

feature 'reviewing' do
    before { Restaurant.create name: 'KFC' }

    scenario 'allows users to leave a review using a forum' do
        visit '/restaurants'
        click_link 'Review KFC'
        fill_in 'Thoughts', with: 'so so'
        select '3', from: 'Rating'
        click_button 'Leave Review'

        expect(current_path).to eq '/restaurants'
        expect(page).to have_content('so so')
    end
end

feature 'reviewing' do
    before { Restaurant.create name: 'KFC' }
    def leave_review(thoughts, rating)
        visit '/restaurants'
        click_link 'Review KFC'
        fill_in 'Thoughts', with: thoughts
        select rating, from: 'Rating'
        click_button 'Leave Review'
    end

    scenario 'displays an average rating for all reviews' do
        leave_review('So so', '3')
        leave_review('Great', '5')
        expect(page).to have_content('Average rating: 4')
    end
end
