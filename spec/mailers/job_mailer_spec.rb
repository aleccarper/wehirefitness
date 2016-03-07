require 'spec_helper'

RSpec.describe JobMailer do
  describe 'new_job_receipt' do
    let(:job) { FactoryGirl.create(:job, title: 'Job Title') }
    let(:charge) {
      {
        created: 1457291145,
        amount: 1000,
        source: { brand: 'Visa' },
        id: 'charge_id'
      }
    }
    let(:mail) { JobMailer.new_job_receipt(job, charge) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Your Job Title job has been posted!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([job.company_email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['support@wehirefitness.com'])
    end

    it 'renders the correct body information' do
      expect(mail.body.encoded).to match(/https\:\/\/www.wehirefitness.com\/jobs\/#{job.id}/)
      expect(mail.body.encoded).to match(/\$10\.00/)
      expect(mail.body.encoded).to match(/Visa/)
      expect(mail.body.encoded).to match(/charge_id/)
    end
  end

  describe 'new_job_admin_notification' do
    let(:job) { FactoryGirl.create(:job, title: 'Job Title') }
    let(:mail) { JobMailer.new_job_admin_notification(job) }

    it 'renders the subject' do
      expect(mail.subject).to eql('A job has been posted')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql(['jobs@wehirefitness.com', 'xarious@gmail.com', 'setretter@gmail.com'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['support@wehirefitness.com'])
    end

    it 'renders the correct body information' do
      expect(mail.body.encoded).to match(/https\:\/\/www.wehirefitness.com\/jobs\/#{job.id}/)
    end
  end
end
