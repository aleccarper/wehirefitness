require 'rails_helper'

describe JobsController do

  describe 'POST #complete_purchase' do
    context 'as an admin' do
      login_admin

      context "using incomplete information" do
        subject { post :complete_purchase, :job => { } }

        it 'should not create the job with incomplete information' do
          subject
          expect(Job.all.count).to eql 0
        end

        it 'should redirect back to the purchase page' do
          expect(subject).to redirect_to jobs_purchase_path
        end

        it 'should display the correct error messages' do
          subject
          expect(flash[:error]).to eq(["Title can't be blank",
              "Category can't be blank",
              "Description can't be blank",
              "How to apply can't be blank",
              "Company description can't be blank",
              "Company name can't be blank",
              "Company url can't be blank",
              "Company email can't be blank",
              "Zip can't be blank",
              "City can't be blank",
              "State can't be blank"]
           )
        end
      end

      context "using complete information" do
        subject {
          session[:job] = FactoryGirl.attributes_for(:job)
          post :complete_purchase
        }

        it 'should create the job posting as published' do
          expect{subject}.to change{Job.all.count}.by(1)
          expect(Job.first.published).to be_truthy
        end

        it 'should redirect to the home page' do
          expect(subject).to redirect_to jobs_thank_you_path
        end

        it 'should display the correct flash message' do
          subject
          expect(flash[:notice]).to eq('Admin - job has been publisehd')
        end

        it 'should not send an email' do
          expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(0)
        end
      end
    end

    context 'as a normal user' do
      context "using incomplete information" do
        subject {
          session[:job] = { company_email: 'asdf' }
          post :complete_purchase
        }

        it 'should not create the job with incomplete information' do
          subject
          expect{subject}.to change{Job.all.count}.by(0)
        end

        it 'should redirect to the thank you page' do
          expect(subject).to redirect_to jobs_purchase_path
        end

        it 'should display the correct error messages' do
          subject
          expect(flash[:error]).to eq(["Title can't be blank",
              "Category can't be blank",
              "Description can't be blank",
              "How to apply can't be blank",
              "Company description can't be blank",
              "Company name can't be blank",
              "Company url can't be blank",
              "Zip can't be blank",
              "City can't be blank",
              "State can't be blank"]
           )
        end

        it 'should not send an email' do
          expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(0)
        end
      end

      context "using complete information", :vcr => {:cassette_name => 'controllers/job/create_job_using_complete_information', :record => :none } do
        let(:coupon) { FactoryGirl.create(:coupon) }
        subject {
          session[:job] = FactoryGirl.attributes_for(:job)
          post :complete_purchase, { coupon_code: coupon.code }
        }

        it 'should create the job posting as published' do
          expect{subject}.to change{Job.all.count}.by(1)
          expect(Job.first.published).to be_falsey
        end

        it 'should redirect to the home page' do
          expect(subject).to redirect_to jobs_thank_you_path
        end

        it 'should display the correct flash message' do
          subject
          expect(flash[:notice]).to eq('Your job has been created!')
        end

        it 'should send an email' do
          expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(2)
        end

        it 'should have a coupon' do
          subject
          expect(Job.first.coupon).to_be be_nil
        end
      end
    end
  end

  describe 'POST #charge_and_publish' do

  end

  describe 'POST #unpublish' do

  end


  private


end
