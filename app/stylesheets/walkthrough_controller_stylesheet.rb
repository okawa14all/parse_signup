class WalkthroughControllerStylesheet < ApplicationStylesheet
  # Add your view stylesheets here. You can then override styles if needed, example:
  # include FooStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.white
  end

  def welcome(st)
    st.frame = {t: app_height / 2, w: app_width, h: 30, centered: :horizontal}
    st.color = color.battleship_gray
    st.font = font.medium
    st.text = 'welcome!'
    st.text_alignment = :center
  end

  def signup(st)
    st.frame = {l: 0, fb: 0, w: app_width / 2, h: 50 }
    st.text = 'Sign Up'
    st.background_color = color.button_bg_color
    st.font = font.medium
    st.color = color.white
  end

  def login(st)
    st.frame = {r: app_width, fb: 0, w: app_width / 2, h: 50 }
    st.text = 'Log In'
    st.background_color = color.button_bg_color
    st.font = font.medium
    st.color = color.white
  end

  def btn_divider(st)
    st.frame = {r: app_width / 2 - 1, fb: 5, w: 2, h: 40 }
    st.background_color = color.white
  end

  def overlay(st)
    st.frame = :full
    st.background_color = color.from_rgba(0, 0, 0, 0.7)
  end

  def overlay_label(st)
    st.frame = {t: app_height / 2, w: app_width, h: 30}
    st.font = font.medium
    st.color = color.white
    st.text_alignment = :center
  end

  def signup_with_facebook_button(st)
    st.frame = {l: 0, fb: 100, w: app_width, h: 50 }
    st.text = 'Sign Up with Facebook'
    st.background_color = color.fb_button_bg_color
    st.font = font.small
    st.color = color.white
  end

  def signup_with_twitter_button(st)
    st.frame = {l: 0, fb: 50, w: app_width, h: 50 }
    st.text = 'Sign Up with Twitter'
    st.background_color = color.tw_button_bg_color
    st.font = font.small
    st.color = color.white
  end

  def signup_with_email_button(st)
    st.frame = {l: 0, fb: 0, w: app_width, h: 50 }
    st.text = 'Sign Up with Emal'
    st.background_color = color.button_bg_color
    st.font = font.small
    st.color = color.white
  end

  def cancel_button(st)
    st.frame = {l: 5, t: 25, w: 55, h: 30}
    st.text = 'cancel'
    st.background_color = color.clear
    st.font = font.small
    st.color = color.white
  end

  def login_with_facebook_button(st)
    st.frame = {l: 0, fb: 100, w: app_width, h: 50 }
    st.text = 'Log In with Facebook'
    st.background_color = color.fb_button_bg_color
    st.font = font.small
    st.color = color.white
  end

  def login_with_twitter_button(st)
    st.frame = {l: 0, fb: 50, w: app_width, h: 50 }
    st.text = 'Log In with Twitter'
    st.background_color = color.tw_button_bg_color
    st.font = font.small
    st.color = color.white
  end

  def login_with_email_button(st)
    st.frame = {l: 0, fb: 0, w: app_width, h: 50 }
    st.text = 'Log In with Emal'
    st.background_color = color.button_bg_color
    st.font = font.small
    st.color = color.white
  end
end
