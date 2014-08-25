class LoginControllerStylesheet < ApplicationStylesheet
  # Add your view stylesheets here. You can then override styles if needed, example:
  # include FooStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.white
  end

  def email(st)
    st.frame = {l: 10, t: 170, w: app_width - 20, h: 50 }
    st.background_color = color.white
    st.view.font = font.small
    st.placeholder = 'Email'
    st.border_width = 1.0
    st.border_color = color.silver
    st.border_radius = 2
    st.masks_to_bounds = true
    st.view.leftViewMode = UITextFieldViewModeAlways
  end

  def password(st)
    st.frame = {l: 10, t: 230, w: app_width - 20, h: 50}
    st.background_color = color.white
    st.view.font = font.small
    st.placeholder = 'Password'
    st.view.secureTextEntry = true
    st.border_width = 1.0
    st.border_color = color.silver
    st.border_radius = 2
    st.masks_to_bounds = true
    st.view.leftViewMode = UITextFieldViewModeAlways
  end

  def text_field_padding(st)
    st.frame = {l: 0, t: 0, w: 10, h: 50 }
    st.view.opaque = false
    st.background_color = color.clear
  end

  def submit_button(st)
    st.frame = {l: 10, t: 290, w: app_width - 20, h: 50}
    st.text = 'Log In'
    st.background_color = color.button_bg_color
    st.font = font.medium
    st.color = color.white
  end
end
