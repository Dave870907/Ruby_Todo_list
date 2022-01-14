module Helpers

    def sign_in
      # here is where you can put the steps to fill out the log in form
      sign_up

      visit login_path
      within('form') do
        fill_in 'session_email', with:'d2cb103@gmail.com'
        fill_in 'session_password', with:'0907'
      end
      click_button 'commit'
    end
  
    def sign_up
      visit admin_sign_up_path
      within('form') do
        fill_in 'user_user_name', with: 'Dave'
        fill_in 'user_email', with: 'd2cb103@gmail.com'
        fill_in 'user_password', with: '0907'
      end
      click_button 'commit'
    end
  end