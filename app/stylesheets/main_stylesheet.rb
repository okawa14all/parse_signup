class MainStylesheet < ApplicationStylesheet

  def setup
    # Add sytlesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.white
  end

  def name(st)
    st.frame = {t: 150, w: app_width, h: 30, centered: :horizontal}
    st.font = font.medium
    st.text_alignment = :center
  end

  def email(st)
    st.frame = {t: 190, w: app_width, h: 30, centered: :horizontal}
    st.font = font.medium
    st.text_alignment = :center
  end

  def logout_button(st)
    st.frame = {l: 10, t: 290, w: app_width - 20, h: 50}
    st.text = 'Log out'
    st.background_color = color.button_bg_color
    st.font = font.medium
    st.color = color.white
  end

end
