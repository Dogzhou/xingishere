# encoding : utf-8
require 'spec_helper'

describe "登录验证Authentication" do
  let(:user) { FactoryGirl.create(:user) }
  subject { page }

  describe "登录界面" do
    before { visit login_path }

    it { should have_content("登录") }
    it { should have_title("登录") }

    describe "输入正确时点击登录" do
      before do
        fill_in "email",        with: user.email.downcase
        fill_in "password",        with: user.password
        click_button "登录"
      end

      # before { login user }

      it { should have_title(full_title('主页')) }
      it { should have_link("我的主页", href: user_path(user)) }
      it { should have_link("个人资料设置", href: account_profile_path) }
      it { should have_link("退出", href: logout_path) }
      it { should_not have_link("登录", href: login_path) }
    end

    describe "输入错误时点击登录" do
      before do
        fill_in "email",      with: user.email.downcase
        fill_in "password",   with: "invalid_password"
        click_button "登录"
      end

      it { should have_title(full_title('登录')) }
      it { should have_content("登录失败,请检查邮件地址和密码") }
      it { should have_link("登录", href: login_path) }

    end
  end

  describe "authentication" do
    let(:no_admin) { FactoryGirl.create(:user) }

    before { login no_admin, no_capybara: true }

    describe "submitting a DELETE request to User destroy action" do
      before { delete user_path(user) }
      specify { expect(response).to redirect_to(root_path) }
    end

  end
end