class CreateWhiskies < ActiveRecord::Migration[7.0]
  def change
    create_table :whiskies do |t|
      t.string :whisky_name, null: false
      t.string :drink_style, null: false
      t.string :glass_name
      t.integer :glass_rating
      t.string :peat, default: "no"
      t.json :aromas
      t.text :details

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
