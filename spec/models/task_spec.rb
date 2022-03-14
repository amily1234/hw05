require 'rails_helper'

RSpec.describe Task, type: :model do 

  subject {
    Task.new({title: 'A Task', content: 'this is a content'})
  }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end 

  it 'it is invalid with nil title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'it is invalid with nil content' do
    subject.content = nil
    expect(subject).to_not be_valid
  end
  
end
