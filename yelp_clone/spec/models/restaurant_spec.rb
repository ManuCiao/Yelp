require 'rails_helper'

describe Restaurant, type: :model do
  it 'is not valid with a nameless than 3 characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end
end
