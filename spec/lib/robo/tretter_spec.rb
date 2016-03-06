require 'rails_helper'

describe Robo::Tretter do

  describe 'queue_spew' do
    let(:job_ids) { [] }
    subject { Robo::Tretter::queue_spew(job_ids) }

    context 'a valid job' do
      let!(:category) { FactoryGirl.create(:category) }
      let!(:job) { FactoryGirl.create(:job, category: category.id) }
      let(:job_ids) { [job.id] }

      it 'should queue a tweet' do
        expect { subject }.to change{ Worker::Spew.jobs.size }.by(1)
      end

      it 'should build the correct text' do
        subject
        text = Worker::Spew.jobs.first['args'][0]
        expect(text).to match(/https\:\/\/www.wehirefitness.com\/jobs\/#{job.id}/)
      end

    end

  end

end
