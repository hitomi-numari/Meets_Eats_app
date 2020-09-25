require 'rails_helper'
RSpec.describe 'イベント機能', type: :system do
  before do
    @user01 = create(:user)
    @user02 = create(:second_user)
    @user03 = create(:third_user)

    @user_profile01 = create(:profile, user: @user01)
    @user_profile02 = create(:second_profile, user: @user02)
    @user_profile03 = create(:third_profile, user: @user03)

    @area01 = create(:area13)
    @area02 = create(:area6)
    @area03 = create(:area13)

    @event01 = create(:event, user: @user01, area: @area01)
    @event02 = create(:second_event, user: @user02, area: @area02)
    @event03 = create(:third_event, user: @user03, area: @area03)

    @genre01 = create(:genre)
    @genre02 = create(:genre3)
    @genre03 = create(:genre5)

    create(:genre_tag, event: @event01, genre: @genre01)
    create(:genre_tag2, event: @event02, genre: @genre02)
    create(:genre_tag3, event: @event03, genre: @genre03)

    create(:apply_for_event, event: @event01, user: @user02 )
    create(:apply_for_event2, event: @event02, user: @user03 )
  end

  describe 'イベント詳細画面' do
    context 'ログインユーザーがイベント主催者の場合'
      it '編集ボタンが表示される' do
        sign_in @user01
        visit event_path(@event01.id)
        expect(page).to have_content 'のび太'
        expect(page).to have_content '編集'
      end

    context 'ログインユーザーがイベント主催者でなくかつイベントに参加していない場合' do
      it '参加ボタンが表示される' do
        sign_in @user03
        visit event_path(@event01.id)
        expect(page).to have_content 'スネ夫'
        expect(page).to have_content '参加する'
      end
    end

    context 'ログインユーザーがイベント主催者でなくかつイベントに参加している場合' do
      it 'キャンセルボタンが表示される' do
        sign_in @user02
        visit event_path(@event01.id)
        expect(page).to have_content '静香'
        expect(page).to have_content 'キャンセルする'
      end
    end
    context 'ログインユーザーがイベント主催者でなくかつイベントに参加していない人が参加ボタンを押した時' do
      it 'イベントに応募した旨の通知が表示される' do
        sign_in @user03
        visit event_path(@event01.id)
        expect(page).to have_content 'スネ夫'
        click_on "参加する"
        expect(page).to have_content 'のび太さんのイベントに応募しました'
      end
    end

    context 'ログインユーザーがイベント主催者でなくかつイベントに参加している人がキャンセルボタンを押した時' do
      it 'イベントにキャンセルした旨の通知が表示される' do
        sign_in @user02
        visit event_path(@event01.id)
        expect(page).to have_content 'のび太'
        accept_alert do
          click_link 'キャンセルする'
        end
        expect(page).to have_content 'のび太さんのイベントをキャンセルしました'
      end
    end
  end

  describe '応募者一覧からマッチング相手を決める' do
     context 'イベント主催者が応募者一覧ボタンを押した場合' do
       it '応募者一覧が表示される' do
         sign_in @user01
         visit apply_members_event_path(@event01.id)
         expect(page).to have_content '静香'
       end
     end

     context 'イベント主催者がこの人と行くボタンを押した場合' do
       it '応募者一覧が表示される' do
         sign_in @user01
         visit apply_members_event_path(@event01.id)
         click_on 'この人と行く'
         expect(page).to have_content '静香さんとイベントが成立しました'
       end
     end

     context 'イベントが成立して戻るボタンを押した場合' do
       it '募集中イベントからイベントが消える' do
         sign_in @user01
         visit apply_members_event_path(@event01.id)
         click_on 'この人と行く'
         expect(page).to have_content '静香さんとイベントが成立しました'
         click_on '戻る'
         expect(page).not_to have_content '渋谷でパスタを食べながら恋話をしたい'
         expect(current_path).to eq my_events_user_path(@user01.id)
       end
     end

  end
end
