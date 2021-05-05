# README

# テーブル設計

## usersテーブル

| Column | Type | Option |
| ------ | ---- | ------ |
| nickname | string | null: false |
| email | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name | string | null: false |
| first_name | string | null: false |
| last_name_kana | string | null: false |
| first_name_kana | string | null: false |
| birthday | date | null: false |

### Association

- has_many :items
- has_many :purchase_logs

## itemsテーブル

| Column | Type | Option |
| ------ | ---- | ------ |
| item_name | string | null: false |
| description | text | null: false |
| category | integer | null: false |
| status | integer | null: false |
| charge | integer | null: false |
| area | integer | null: false |
| days | integer | null: false |
| price | integer | null: false |
| user | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_log

## purchase_logsテーブル

| Column | Type | Option |
| ------ | ---- | ------ |
| user | references | null: false, foreign_key: true |
| item | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addressesテーブル

| Column | Type | Option |
| ------ | ---- | ------ |
| postal_code | string | null: false |
| prefecture | string | null: false |
| municipality | string | null: false |
| house_number | string | null: false |
| building_name | string |  |
| phone_number | string | null: false |
| purchase_log | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase_log
