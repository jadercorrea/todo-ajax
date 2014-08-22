require 'rails_helper'

RSpec.describe Task, :type => :model do
  describe 'associations' do
    it { should have_many :children }
    it { should belong_to :parent }
  end

  describe 'validations' do
    it { should validate_presence_of :description }
  end

  describe '.just_parents' do
    let(:task1) { FactoryGirl.create(:task, description: 'parent', finished: false, parent_id: nil) }
    let(:task2) { FactoryGirl.create(:task, description: 'children', finished: false, parent_id: task1.id) }

    before do
      task1 && task2
    end

    it 'returns parent tasks' do
      expect(Task.just_parents.to_a).to eql([task1])
    end
  end
end
