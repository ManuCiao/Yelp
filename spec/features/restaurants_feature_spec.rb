require 'rails_helper'
require_relative 'sign_in_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should disaplay a prompt to addd a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Waffle')
    end

    scenario 'displays restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Waffle')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurant' do
    context 'user not signed in' do
      scenario 'user cannot add a new restaurant' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        expect(page).not_to have_css 'h2', text: 'Waffle'
        expect(page).to have_content 'You need to sign in or sign up before continuing'
      end
    end

    context 'user signed in' do
      scenario 'user fills out a form and adds restaurant' do
        sign_in
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'Waffle'
        click_button 'Create Restaurant'
        expect(page).to have_content('Waffle')
        expect(current_path).to eq '/restaurants'
      end

      context 'an invalid restaurant' do
        scenario 'does not let you submit a name that is too short' do
          sign_in
          click_link 'Add a restaurant'
          fill_in 'Name', with: 'kf'
          click_button 'Create Restaurant'
          expect(page).not_to have_css 'h2', text: 'kf'
          expect(page).to have_content 'error'
        end
      end
    end
  end

  context 'viewing restaurants' do

    let!(:waffle){ Restaurant.create(name:'Waffle')}

    scenario 'let a user view a restaurant' do
      visit '/restaurants'
      click_link 'Waffle'
      expect(page).to have_content 'Waffle'
      expect(current_path).to eq "/restaurants/#{waffle.id}"
    end
  end

  context 'editing restaurants' do

    before { Restaurant.create name: 'Waffle', description: 'Tasty Waffle' }

    scenario 'let a user edit a restaurant' do
      sign_in
      click_link 'Edit Waffle'
      fill_in 'Name', with: 'Waffle'
      fill_in 'Description', with: 'Tasty Waffle'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Waffle'
      expect(page).to have_content 'Tasty Waffle'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do
    before { Restaurant.create name: 'KFC', description: 'Deep fried goodness'}

    scenario 'removes a restaurant when a user clicks a delete link' do
      sign_in
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  context 'uploading a picture' do
    scenario 'user can add a picture to the restaurant' do
      sign_in
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Waffle'
      page.attach_file("restaurant_image", Rails.root + 'app/assets/images/restaurant.jpg')
      click_button 'Create Restaurant'
      expect(page).to have_content('Waffle')
      expect(current_path).to eq '/restaurants'
    end
  end
end
