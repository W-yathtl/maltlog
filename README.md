## データベース設計

### whiskiesテーブル
| カラム名        | 型        | 制約                     | 説明 |
|----------------|-----------|--------------------------|------|
| id             | bigint    | PK                       | 自動採番 |
| whisky_name    | string    | null: false              | 銘柄 |
| drink_style    | string    | null: false              | 飲み方 |
| glass_name     | string    |                          | グラス名 |
| glass_rating   | integer   |                          | グラスとの相性（1〜5） |
| peat           | boolean   | null: false, default: false | ピート（スモーキーさ） |
| aromas         | string[]  | default: [] (PostgreSQL) | 香り（複数選択） |
| details        | text      |                          | テイスティングノート |
| user_id        | bigint    | FK                       | 作成者（usersテーブル参照） |
| created_at     | datetime  |                          | 作成日時 |
| updated_at     | datetime  |                          | 更新日時 |