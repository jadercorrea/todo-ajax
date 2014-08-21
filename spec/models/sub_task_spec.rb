require 'rails_helper'

RSpec.describe SubTask, :type => :model do
  describe 'associations' do
    it { should belong_to :task }
  end
end
