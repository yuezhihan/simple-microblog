require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
  end

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

  test "valid signup infomation with account activation" do
    get signup_path
    assert_difference 'User.count' do
      post signup_path, params: { user: { name: "Yue",
                                      email: "zhihan.yue@foxmail.com",
                                      password: "mimashishenme",
                                      password_confirmation: "mimashishenme"} }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # 尝试在激活之前登录
    log_in user
    assert_not logged_in?
    # 激活令牌无效
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not logged_in?
    # 令牌有效，电子邮件地址不对
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not logged_in?
    # 激活令牌有效
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert logged_in?
  end
end
