require 'rails_helper'

RSpec.describe User, type: :model do

  #describe and context are similar stuffs/ alias
  # context encapsulates one type of tests ideas like validation or scope
  
  # Testing Validations
  context 'validation tests' do 
    it 'ensures first name presence' do 
      user = User.new(last_name: 'last',email: 'user@user.com').save
      expect(user).to eq(false)
    end

    it 'ensures last name presence' do 
      user = User.new(first_name: 'first',email: 'user@user.com').save
      expect(user).to eq(false)
    end

    it 'ensures email presence' do 
      user = User.new(first_name: 'first',last_name: 'last').save
      expect(user).to eq(false)
    end

    it 'ensures saved successfully' do 
      user = User.new(first_name: 'first',last_name: 'last',email: 'user@user.com').save
      expect(user).to eq(true)
    end
  end

  # Testing Scopes
  context 'scope tests' do 
    let (:subject){ {first_name: 'first',last_name: 'last',email: 'user@user.com'} }
    before(:each) do 
      User.new(subject.merge(active: true)).save
      User.new(subject.merge(active: true)).save
      User.new(subject.merge(active: false)).save
    end

    it 'should return active users' do 
      expect(User.active_users.size).to eq(2)
    end

    it 'should return inactive users' do 
      expect(User.inactive_users.size).to eq(1)
    end
  end

end
