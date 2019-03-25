# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:barebones)
    @new_user = User.new(name: 'new', email: 'new@test.com', password: 'new')
  end

  test 'visiting the login' do
    visit login_url
    assert_selector 'h1', text: 'ログイン'
  end

  test 'login succeed' do
    login_as(@user)

    assert_text 'ログインしました'
  end

  test 'login failed with invalid email' do
    visit login_url
    fill_in 'email', with: 'invalid@email'
    fill_in 'password', with: 'barebones'
    find(:xpath, "//input[contains(@name, 'commit')]").click

    assert_text 'メールアドレスまたはパスワードが間違っています'
  end

  test 'login failed with invalid password' do
    visit login_url
    fill_in 'email', with: @user.email
    fill_in 'password', with: 'invalid password'
    find(:xpath, "//input[contains(@name, 'commit')]").click

    assert_text 'メールアドレスまたはパスワードが間違っています'
  end

  test 'creating a User' do
    visit login_url
    click_on '新規登録'

    fill_in 'user[name]', with: @new_user.name
    fill_in 'user[email]', with: @new_user.email
    fill_in 'user[password]', with: @new_user.password
    find(:xpath, "//input[contains(@name, 'commit')]").click

    assert_text 'ユーザー登録が完了しました'
  end

  test 'updating a User' do
    login_as(@user)
    click_on @user.name, match: :first
    click_on '編集'

    fill_in 'user[name]', with: @user.name
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: 'password'
    find(:xpath, "//input[contains(@name, 'commit')]").click

    assert_text 'ユーザー情報を編集しました'
  end

  # test 'destroying a User' do
  #   visit users_url
  #   page.accept_confirm do
  #     click_on 'Destroy', match: :first
  #   end

  #   assert_text 'User was successfully destroyed'
  # end
end
