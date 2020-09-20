class ChangeNotnullToProfiles < ActiveRecord::Migration[5.2]
  def up
    change_column_null :profiles, :nickname, false, ""
    change_column :profiles, :nickname, :string, default: ""
    change_column_null :profiles, :icon, false, ""
    change_column :profiles, :icon, :string, default: ""
    change_column_null :profiles, :gender, false, 0
    change_column :profiles, :gender, :integer, default: 0
    change_column_null :profiles, :instagram_url, false, ""
    change_column :profiles, :instagram_url, :string, default: ""
    change_column_null :profiles, :facebook_url, false, ""
    change_column :profiles, :facebook_url, :string, default: ""
    change_column_null :profiles, :details, false, ""
    change_column :profiles, :details, :string, default: ""
  end

  def down
    change_column_null :profiles, :nickname, true, nil
    change_column :profiles, :nickname, :string, default: nil
    change_column_null :profiles, :icon, true, nil
    change_column :profiles, :icon, :string, default: nil
    change_column_null :profiles, :gender, true, nil
    change_column :profiles, :gender, :integer, default: nil
    change_column_null :profiles, :instagram_url, true, nil
    change_column :profiles, :instagram_url, :string, default: nil
    change_column_null :profiles, :facebook_url, true, nil
    change_column :profiles, :facebook_url, :string, default: nil
    change_column_null :profiles, :details, true, nil
    change_column :profiles, :details, :text, default: nil
  end
end
