require 'rails_helper'

describe ReviewsHelper, type: :helper do
    context '#star_rating' do
        it 'returns five black stars for five' do
            expect(helper.star_rating(5)).to eq '★★★★★'
        end
        it 'returns three black stars and two white stars for three' do
            expect(helper.star_rating(3)).to eq '★★★☆☆'
        end
        it 'returns four black stars and one white star for 3.5' do
            expect(helper.star_rating(3.5)).to eq '★★★★☆'
        end
    end
end
