require 'rails_helper'

describe Job do

  describe 'charge_and_publish' do
    let(:job) { FactoryGirl.create(:job) }
    let(:coupon) { FactoryGirl.create(:coupon) }

    it 'should charge 25 dollars' do

    end

    it 'should set status to published', :vcr => {:cassette_name => 'models/job/sets_status_to_published', :record => :none } do
      expect(job.published).to be_falsey
      job.charge_and_publish
      expect(job.published).to be_truthy
    end

    it 'should return a success response hash', :vcr => {:cassette_name => 'models/job/returns_success_response_hash', :record => :none } do
      result = job.charge_and_publish
      expect(result[:success]).to be_truthy
      expect(result[:amount_charged]).to eql(2500)
    end

    context 'with a coupon' do
      let!(:coupon) { FactoryGirl.create(:coupon) }
      let(:job) { FactoryGirl.create(:job, coupon: coupon) }

      it 'should charge the correct amount', :vcr => {:cassette_name => 'models/job/coupon_charges_correct_amount', :record => :none } do
        coupon.percent_off = 75
        result = job.charge_and_publish
        expect(result[:amount_charged]).to eql(625)
        expect(job.published).to be_truthy
      end

      it 'should work with a 100% off coupon', :vcr => {:cassette_name => 'models/job/100_percent_off_coupon_works', :record => :all } do
        coupon.percent_off = 100
        result = job.charge_and_publish
        expect(result[:amount_charged]).to eql(0)
        expect(job.published).to be_truthy
      end
    end

  end

end
