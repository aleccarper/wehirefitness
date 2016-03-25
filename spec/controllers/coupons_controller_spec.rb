require 'rails_helper'

describe CouponsController do

  describe 'POST #lookup' do
    context 'of an existing coupon' do
      let(:coupon) { FactoryGirl.create(:coupon, percent_off: 75, code: 'asdf') }
      subject { get :lookup, {code: coupon.code} }

      it 'returns the correct values' do
        subject
        expect(json_response).to eql(
          {
            "found"=>true,
            "can_use"=>true,
            "code"=>'asdf',
            "percent_off"=>75,
            "as_float"=>0.75
          }
        )
      end
    end

    context 'of a missing coupon' do
      subject { get :lookup, {code: 'ohwow'} }

      it 'should return not found' do
        subject
        expect(json_response).to eql(
          {
            "found"=>false
          }
        )
      end
    end

  end

  private

    def json_response
      JSON.parse(response.body)
    end

end
