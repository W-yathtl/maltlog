class CreateWhiskies < ActiveRecord::Migration[7.1]
  def change
    create_table :whiskies do |t|

      t.string :whisky_name, null: false
      t.string :drink_style, null: false
      t.string :glass_name
      t.integer :glass_rating
      t.boolean :peat, null: false, default: false
      t.text :details
      t.references :user, null: false, foreign_key: true
      t.json :aromas, default: [] # MySQLではJSONで複数選択を保存

      t.timestamps
    end
  end
end

