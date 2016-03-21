require 'rails_helper'

describe Coupon do

  describe 'creation' do
    context 'with good information' do
      it 'should be valid' do
        coupon = Coupon.new(code: 'asdf', max_uses: 10, percent_off: 25)
        expect(coupon.valid?).to be_truthy
      end
    end

    context "with bad information" do
      it 'should not be valid' do
        coupon1 = Coupon.create(code: 'asdf')
        coupon2 = Coupon.new(code: 'asdf')
        expect(coupon2.valid?).to be_falsey
      end
    end
  end

  describe 'use' do
    let(:coupon) { FactoryGirl.create(:coupon) }

    it 'should increment uses count' do
      expect { coupon.use }.to change { coupon.uses }.by(1)
    end
  end

  describe 'as_float' do
    let(:coupon) { FactoryGirl.create(:coupon) }

    it 'should return the correct percent off as a float' do
      coupon.percent_off = 33
      expect(coupon.as_float).to eql(0.33)
    end

    it 'should never return more than 1' do
      coupon.percent_off = 110
      expect(coupon.as_float).to eql(1)
    end
  end

  describe 'can_use?' do
    let(:coupon) { FactoryGirl.create(:coupon) }

    it 'should return false if uses maxed out' do
      coupon.update_attributes(max_uses: 10, uses: 10)
      expect(coupon.can_use?).to be_falsey
    end

    it 'should always return true if max_uses is zero' do
      coupon.update_attributes(max_uses: 0, uses: 10)
      expect(coupon.can_use?).to be_truthy
    end

    it 'should return true if there are still uses' do
      coupon.update_attributes(max_uses: 10, uses: 9)
      expect(coupon.can_use?).to be_truthy
    end
  end
end
