require 'rails_helper'

describe Robo::Tretter do

  describe 'queue_spew' do
    let!(:category) { FactoryGirl.create(:category) }
    let(:job_ids) { [job.id] }
    subject { Robo::Tretter::queue_spew(job_ids) }

    context 'a valid job' do
      let(:job) { FactoryGirl.create(:job, category: category.id, title: 'asdf') }

      it 'should queue a tweet' do
        expect { subject }.to change{ Worker::Spew.jobs.size }.by(1)
      end

      it 'should build the correct text' do
        subject
        text = Worker::Spew.jobs.first['args'][0]
        expect(text).to match(/https\:\/\/www.wehirefitness.com\/jobs\//)
      end

    end

    context 'an invalid job' do
      let(:job) { FactoryGirl.create(:job, category: category.id, title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ")}

      it 'should not be queued if the message is to long' do
        expect { subject }.to change { Worker::Spew.jobs.size }.by(0)
      end
    end
  end

end
