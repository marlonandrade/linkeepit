module TestHelpers
  module SessionHelper
    def sign_in user
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.email.sub(/@.*/, '')
      click_button 'Log in'
    end
  end
end
