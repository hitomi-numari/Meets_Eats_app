require 'rails_helper'
RSpec.describe 'ログイン機能', type: :system do
  before do
    @user01 = create(:user)
    @user02 = create(:second_user)
    @user03 = create(:third_user)

    @user_profile01 = create(:profile, user: @user01)
    @user_profile02 = create(:second_profile, user: @user02)
    @user_profile03 = create(:third_profile, user: @user03)
  end

  describe 'ログイン画面' do
    context '新規ユーザー登録する場合' do
      it 'ユーザーの新規作成が成功' do
        visit unauthenticated_root_path
        click_on 'サインアップ'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_button '新規登録'
        expect(current_path).to eq authenticated_root_path
        expect(page).to have_content 'アカウント登録が完了しました。'
        expect(page).to have_content 'こんにちは、ゲストさん'

        image_path = File.join(Rails.root, "spec/factories/images/gyaian.png")
        attach_file('profile_icon', image_path)
        fill_in 'profile_nickname', with: 'ジャイアン'
        select '1995', from: 'profile_birthday_1i'
        select '8', from: 'profile_birthday_2i'
        select '11', from: 'profile_birthday_3i'
        choose 'profile_gender_1'
        fill_in 'profile_details', with: 'カラオケ大好きな、会社員！'
        click_on 'プロフィール登録'
        expect(page).to have_content 'ジャイアン'
        expect(page).to have_content 'こんにちは、ジャイアンさん'
        expect(page).to have_content '25歳'
      end
    end

    context 'ログインする場合' do
      it 'ログインに成功する' do
        visit unauthenticated_root_path
        fill_in 'user_email', with: 'nobita@doraemon.com'
        fill_in 'パスワード', with: 'password'
        click_on 'ログインする'
        expect(page).to have_content 'ログインしました。'
        expect(page).to have_content 'こんにちは、のび太さん'
        expect(current_path).to eq search_top_events_path
      end
    end
  end
end
