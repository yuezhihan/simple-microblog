require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup infomation" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "",
                                        email: "user@invalid",
                                        password: "foo",
                                        password_confirmation: "bar"} }
    end
    assert_template 'new'
    assert_select '.field_with_errors'
    assert_select '#error_explanation'
    assert_select 'form[action=?]', signup_path
  end

  test "valid signup infomation" do
    get signup_path
    assert_difference 'User.count' do
      post signup_path, params: { user: { name: "Yue",
                                      email: "zhihan.yue@foxmail.com",
                                      password: "mimashishenme",
                                      password_confirmation: "mimashishenme"} }
    end

    follow_redirect!
    assert_template 'users/show'
    assert logged_in?
    assert_not flash.empty?
  end
end
