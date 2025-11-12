class CreateWhiskies < ActiveRecord::Migration[7.1]
  def change
    create_table :whiskies do |t|

      t.timestamps
    end
  end
end
