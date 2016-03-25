# require 'rails_helper'
#
# describe SeekerController do
#   let(:category1) { FactoryGirl.create(:category, id: 1, name: 'category 1') }
#   let(:category2) { FactoryGirl.create(:category, id: 2, name: 'category 2') }
#   let(:category3) { FactoryGirl.create(:category, id: 3, name: 'category 3') }
#
#   describe 'create' do
#
#     context 'with bad params' do
#       it 'should return error messages' do
#         post :create, seeker: { name: '' }
#         expect(json_response['success']).to be_falsey
#         expect(json_response['errors'].count > 0 ).to be_truthy
#       end
#     end
#
#     context 'with good params' do
#       let(:params) {
#         {
#           seeker: {
#             name: 'Khorne',
#             email: 'bloodgod@wh40k.com',
#             city: 'Denver',
#             state: 'Colorado',
#             country: 'US',
#             radius: 50,
#           },
#           categories: ['1', '2']
#         }
#       }
#
#       let(:seeker) { Seeker.first }
#
#       before do
#         post :create, params
#       end
#
#       it 'should return success' do
#         expect(json_response['success']).to be_truthy
#       end
#
#       it 'should create a seeker' do
#         expect(seeker.name).to eql('Khorne')
#         expect(seeker.email).to eql('bloodgod@wh40k.com')
#         expect(seeker.city).to eql('Denver')
#         expect(seeker.state).to eql('Colorado')
#         expect(seeker.country).to eql('US')
#         expect(seeker.radius).to eql(50)
#       end
#
#       it 'should geocode correctly' do
#         expect(seeker.full_address).to eql('Denver Colorado US')
#         expect(seeker.latitude.blank?).to be_falsey
#         expect(seeker.longitude.blank?).to be_falsey
#       end
#
#       it 'should set the correct category relationships' do
#         #expect(seeker.categories.count).to eql 2
#       end
#     end
#
#   end
#
#   private
#
#   def json_response
#     JSON.parse(response.body)
#   end
#
# end
