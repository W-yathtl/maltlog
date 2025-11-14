class ChangePeatToBooleanInWhiskies < ActiveRecord::Migration[7.0]
  def up
    # 一時的に新しい boolean カラムを追加
    add_column :whiskies, :peat_temp, :boolean, default: false

    # 既存の peat カラムの値を true/false に変換してコピー
    execute <<-SQL.squish
      UPDATE whiskies
      SET peat_temp =
        CASE
          WHEN peat = 'true' THEN TRUE
          WHEN peat = 'false' THEN FALSE
          ELSE NULL
        END;
    SQL

    # 元のカラムを削除して、名前を戻す
    remove_column :whiskies, :peat
    rename_column :whiskies, :peat_temp, :peat
  end

  def down
    # 逆マイグレーション（戻す場合）
    add_column :whiskies, :peat_temp, :string

    execute <<-SQL.squish
      UPDATE whiskies
      SET peat_temp =
        CASE
          WHEN peat = TRUE THEN 'true'
          WHEN peat = FALSE THEN 'false'
          ELSE NULL
        END;
    SQL

    remove_column :whiskies, :peat
    rename_column :whiskies, :peat_temp, :peat
  end
end
