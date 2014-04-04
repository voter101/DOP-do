require 'spec_helper'

describe TaskRepository do
  context "when added task" do
    subject { described_class.add(FactoryGirl.build(:task))}
    (subject === true).should be_true
  end
end