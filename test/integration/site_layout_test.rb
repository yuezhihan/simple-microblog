require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "layout links" do
  	get root_path
  	assert_template 'static_pages/home'
  	assert_select "a[href=?]", root_path
  	assert_select "a[href=?]", help_path
  	assert_select "a[href=?]", about_path
  	assert_select "a[href=?]", contact_path
  	get contact_path
  	assert_select "title", 'Contact | ' + BASE_TITLE
  	get signup_path
  	assert_select "title", 'Sign up | ' + BASE_TITLE
  end
end
