# README

# テーブル設計

## usersテーブル

| Column | Type | Option |
| ------ | ---- | ------ |
| nickname | string | null: false |
| email | string | null: false |
| encrypted_password | string | null: false |
| password_confirmation | string | null: false |
| last_name | string | null: false |
| first_name | string | null: false |
| last_name_kana | string | null: false |
| first_name_kana | string | null: false |
| birth_year | integer | null: false |
| birth_month | integer | null: false |
| birth_day | integer | null: false |

### Association

- has_many :items
- has_many :purchase_logs

## itemsテーブル

| Column | Type | Option |
| ------ | ---- | ------ |
| item_name | string | null: false |
| description | text | null: false |
| category | string | null: false |
| status | string | null: false |
| charge | string | null: false |
| area | string | null: false |
| days | string | null: false |
| price | integer | null: false |
| user_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_log

## purchase_logsテーブル

| Column | Type | Option |
| ------ | ---- | ------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address
- has_one :creditcard

## addressesテーブル

| Column | Type | Option |
| ------ | ---- | ------ |
| postal_code | string | null: false |
| prefecture | string | null: false |
| municipality | string | null: false |
| house_number | string | null: false |
| building_name | string |  |
| phone_number | string | null: false |
| purchase_log_id | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase_log

## creditcardテーブル

| Column | Type | Option |
| ------ | ---- | ------ |
| card_number | string | null: false |
| expiration_month | integer | null: false |
| expiration_year | integer | null: false |
| security_code | integer | null: false |
| purchase_log_id | references | null: false, foreign_key: true |

### Association 

- belongs_to :purchase_log