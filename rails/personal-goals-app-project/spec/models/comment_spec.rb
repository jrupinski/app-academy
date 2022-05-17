require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should belong_to(:author) }
    it { should belong_to(:commentable) }
    it { should validate_presence_of(:body) }
  end
end
