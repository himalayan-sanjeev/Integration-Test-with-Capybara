require 'rails_helper'

RSpec.feature "Users Features", type: :feature do
  context 'create new user' do 
    before(:each) do
      visit new_user_path
      # User.create!(first_name: 'ram', last_name: 'bahadur',email:'ram.bahadur@example.com')
      within("form") do
        fill_in('First name', with: 'ram')
        fill_in('Last name', with: 'bahadur')
      end
    end

    scenario "should be successful" do 
      #visit new_user_path
      within('form') do
        fill_in('Email', with: 'ram.bahadur@example.com')
      end
      click_button 'Create User'
      expect(page).to have_content "User was created successfully !"
    end 

    scenario "should fail" do 
      # email not filled, only fname and lname from before each block, so as to get failed result
      click_button 'Create User'
      expect(page).to have_content "User creation failed, Email should also be filled !"
    
    end
  end

  context 'update user' do 
    let!(:user) {User.create!(first_name: 'ram', last_name: 'bahadur',email:'ram.bahadur@example.com')}
    
    before(:each) do 
      visit edit_user_path(user)
    end
    
    scenario "should be successful" do
      within('form') do
        fill_in('First Name', with: 'ram')
        # fill_in('last_name', with: 'bahadur')
        fill_in('Email', with: 'ram.bahadur@example.com')
      end
      click_button 'Update User'
      expect(page).to have_content "User was updated successfully !"
      expect(page).to have_content "ram.bahadur@example.com !"

    end 

    scenario "should fail" do 
      within('form') do
        fill_in('First Name', with: '')
        # fill_in('Last Name', with: 'bahadur')
        # fill_in('Email', with: 'ram.bahadur@example.com')
      end
      click_button 'Update User'
      expect(page).to have_content "First Name cannot be blank, user update failed !"
    end

  end

  context 'destroy user' do 
    scenario "should be successful" do
      user = User.create!(first_name: 'ram', last_name: 'bahadur',email:'ram.bahadur@example.com')
      visit users_path
      accept_confirm do 
        expect { click_link "Destroy" }.to change(User, :count).by(-1)
      end 
      expect(page).to have_content "User was deleted successfully !"
    end
  end
end
