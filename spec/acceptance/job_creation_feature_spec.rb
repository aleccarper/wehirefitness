require 'rails_helper'

describe 'Job Creation', type: :feature, js: true do

  it 'works' do

    visit('/')

    click_link('Post a job - $25 for 30 days')

    within('#new_job') do
      fill_in('job[title]', with: 'My job title')
      select('Management', from: 'job_category')
      fill_in('job[city]', with: 'denver')
      select('Colorado', from: 'job_state')
      fill_in('job[zip]', with: '80111')
      fill_in('job[description]', with: 'Job description')
      fill_in('job[how_to_apply]', with: 'How to apply')
      fill_in('job[company_name]', with: 'Company Name')
      fill_in('job[company_description]', with: 'Company Description')
      fill_in('job[company_url]', with: 'http://www.example.com')
      fill_in('job[company_email]', with: 'aleccarper@gmail.com')

      click_button('Preview your job posting')
    end

    expect(page).to have_content('My job title')

    click_link('Purchase Listing')

    within('#payment-form') do
      fill_in('stripe_number', with: '4242424242424242')
      select('12', from: 'exp_month')
      fill_in('stripe_cvc', with: '123')

      click_button('Submit Payment')
    end

    expect(page).to have_content('Your job has been posted!')
  end

end
