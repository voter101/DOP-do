require 'spec_helper'

describe TasksRepository do
  context "correct task added" do
    subject { described_class.new.add(FactoryGirl.build(:task, :with_good_content_length)) }
    it { should be_true }
  end

  context "bad content length task added" do
    subject { lambda {described_class.new.add(FactoryGirl.build(:task, :with_bad_content_length))} }
    it { should raise_exception(TasksValidator::ContentTooLongError) }
  end
end
