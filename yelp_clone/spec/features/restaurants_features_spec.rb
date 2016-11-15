require 'rails_helper'

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
      Restaurant.create(name: 'Pret')
    end

    scenario 'displays restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Pret')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurant' do
    scenario 'user fills out a form and adds restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'name', with: 'Pret'
      click_button 'Create restaurant'
      expect(page).to have_content('Pret')
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing restaurants' do

    let!(:pret){ Restaurant.create(name:'Pret')}

    scenario 'let a user view a restaurant' do
      visit '/restaurants'
      click_link 'Pret'
      expect(page).to have_content 'Pret'
      expect(current_path).to eq "/restaurants/#{pret.id}"
    end
  end
end
