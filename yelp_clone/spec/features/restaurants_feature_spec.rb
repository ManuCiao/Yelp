require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end
  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Waffle House')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Waffle House')
      expect(page).not_to have_content('No restaurants yet')
    end
  end
  context 'creating restaurants' do
    scenario 'fill out a form, then displays new restaurants' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Waffle House'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Waffle House'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing restaurants' do
    let! (:waffles){Restaurant.create(name:"Waffle House")}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link "Waffle House"
      expect(page).to have_content "Waffle House"
      expect(current_path).to eq "/restaurants/#{waffles.id}"
    end
  end
end
