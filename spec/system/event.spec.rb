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

    sign_in @user01

  end

  describe 'イベント一覧画面' do
    context 'カテゴリー別に一覧画面を選択する場合'
      it 'カテゴリーが表示される' do
        visit search_top_events_path
        expect(page).to have_content 'ジャンルから探す'
        expect(page).to have_content 'エリアから探す'
        expect(page).to have_content '全てのイベントから探す'
      end
    end

    context 'イベントを作成した場合' do
      it '作成済みのイベントが表示される' do
        visit events_path
        expect(page).to have_content 'Aの会'
        expect(page).to have_content 'Bの会'
        expect(page).to have_content 'Cの会'
      end
    end

    context '複数のイベントを作成した場合' do
      it 'イベントが作成日時の降順に並んでいる' do
        visit events_path
        event_list = all('.list_group') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(event_list[0]).to have_content 'Aの会'
        expect(event_list[1]).to have_content 'Bの会'
        expect(event_list[2]).to have_content 'Cの会'
      end
    end
    context '終了期限でソートをした場合' do
      it 'イベントが終了期限順に並んでいる' do
        visit events_path
        click_on '終了期限'
        visit events_path(sort_expired: "true")
        event_list = all('.list_group') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(event_list[0]).to have_content 'Aの会'
        expect(event_list[1]).to have_content 'Bの会'
        expect(event_list[2]).to have_content 'Cの会'
      end
    end
    context 'scopeメソッドで検索をした場合' do
      it "scopeメソッドでタイトル検索ができる" do
        visit events_path
        fill_in 'q[title_cont]', with: 'Aの会'
        click_on '検索'
        expect(page).to have_content 'Aの会'
      end
      it "scopeメソッドでジャンル検索ができる" do
        visit events_path
        select "恋愛", from: "q[genres_id_eq_any]"
        click_on '検索'
        expect(page).to have_content '恋愛'
      end
      it "scopeメソッドでタイトルとジャンルの両方が検索できる" do
        visit events_path
        fill_in 'q[title_cont]', with: "Aの会"
        select "恋愛", from: "q[genres_id_eq_any]"
        click_on '検索'
        expect(page).to have_content 'Aの会', "恋愛"
      end
      it "scopeメソッドでエリア検索ができる" do
        visit events_path
        select "台東区", from: "q[area_id_eq]"
        click_on '検索'
        expect(page).to have_content 'Bの会'
      end
      it "scopeメソッドでタイトル、ジャンル、エリア検索ができる" do
        visit events_path
        fill_in 'q[title_cont]', with: "Cの会"
        select "趣味", from: "q[genres_id_eq_any]"
        select "新宿区", from: "q[area_id_eq]"
        click_on '検索'
        expect(page).to have_content 'Cの会', "趣味"
        expect(page).to have_content "新宿区"
      end
    end
  end

  describe 'イベント登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存される' do
        visit new_event_path
        fill_in 'タイトル', with: 'Aの会'
        fill_in '詳細', with: '渋谷でパスタを食べながら恋話をしたい'
        check "恋愛"
        check "その他"
        fill_in "飲食店名", with: "https://tabelog.com/tokyo/A1303/A130301/13010743/"
        select "予算",　from: 'event[budget]'
        select "場所", from: 'event[area_id]'
        select '2020', from: 'event_start_at_1i'
        select '10', from: 'event_start_at_2i'
        select '1', from: 'event_start_at_3i'
        select '12', from: 'event_start_at_4i'
        select '00', from: 'event_start_at_5i'
        select '2020', from: 'event_start_at_1i'
        select '10', from: 'event_start_at_2i'
        select '1', from: 'event_start_at_3i'
        select '14', from: 'event_start_at_4i'
        select '00', from: 'event_start_at_5i'
        select 'before_24hours', from: 'event[check_in_time]'
        click_on "投稿する"
        expect(page).to have_content 'Aの会'
        expect(page).to have_content '渋谷でパスタを食べながら恋話をしたい'
        expect(page).to have_content "恋愛"
        expect(page).to have_content "その他"
        expect(page).to have_content "https://tabelog.com/tokyo/A1303/A130301/13010743/"
        expect(page).to have_content "¥1,000~¥1,999"
        expect(page).to have_content "¥1,000~¥1,999"
        expect(page).to have_content '2020-10-01 12:00:00'
        expect(page).to have_content '2020-10-01 14:00:00'
        expect(page).to have_content '1日前'
      end
    end
  end

  describe 'イベント詳細画面' do
     context '任意のイベント詳細画面に遷移した場合' do
       it '該当イベントの内容が表示されたページに遷移する' do
         visit event_path(@event01.id)
         expect(page).to have_content 'Aの会'
         expect(page).to have_content '渋谷でパスタを食べながら恋話をしたい'
       end
     end
  end
