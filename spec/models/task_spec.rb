require 'rails_helper'

RSpec.describe Task, :type => :model do
  describe 'associations' do
    it { should have_many :sub_tasks }
  end

  describe 'validations' do
    it { should validate_presence_of :description }
    it { should accept_nested_attributes_for :sub_tasks }
  end
end
