class AddUserRefToWhiskies < ActiveRecord::Migration[7.1]
  def change
    add_reference :whiskies, :user, null: false, foreign_key: true
  end
end
