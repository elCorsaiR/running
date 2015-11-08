# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151108152402) do

  create_table "ankles", force: true do |t|
    t.integer "user_id"
    t.integer "position"
    t.float   "left"
    t.float   "right"
  end

  create_table "foot_and_knee_angels", force: true do |t|
    t.integer "user_id"
    t.integer "position"
    t.float   "left_foot_angle"
    t.float   "right_foot_angle"
    t.float   "left_knee_angle"
    t.float   "right_knee_angle"
  end

  create_table "levels", force: true do |t|
    t.string "name"
  end

  add_index "levels", ["name"], name: "index_levels_on_name", unique: true

  create_table "sports", force: true do |t|
    t.string "name"
  end

  add_index "sports", ["name"], name: "index_sports_on_name", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "level_id"
    t.integer  "sport_id"
    t.integer  "distance_id"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "report_date"
    t.date     "birthday"
    t.integer  "gender_id"
    t.integer  "weight"
    t.integer  "height"
    t.string   "injury"
    t.string   "distance"
    t.integer  "ankle"
    t.integer  "knee"
    t.integer  "hip"
    t.integer  "functionality"
    t.integer  "total"
    t.integer  "max_pronation_left"
    t.integer  "max_pronation_right"
    t.integer  "pronation_speed_left"
    t.integer  "pronation_speed_right"
    t.integer  "tibia_max_rotation_left"
    t.integer  "tibia_max_rotation_right"
    t.integer  "tibia_rotation_left"
    t.integer  "tibia_rotation_right"
    t.float    "left_stride_time"
    t.float    "left_stride_time_stance"
    t.integer  "left_stride_time_stance_per"
    t.float    "left_stride_time_swing"
    t.integer  "left_stride_time_swing_per"
    t.float    "right_stride_time"
    t.float    "right_stride_time_stance"
    t.integer  "right_stride_time_stance_per"
    t.float    "right_stride_time_swing"
    t.integer  "right_stride_time_swing_per"
    t.float    "stride_time"
    t.integer  "left_stride_time_per"
    t.integer  "right_stride_time_per"
    t.float    "stride_length"
    t.float    "left_stride_length"
    t.integer  "left_stride_length_per"
    t.float    "right_stride_length"
    t.integer  "right_stride_length_per"
    t.integer  "stride_frequency"
    t.integer  "left_stride_frequency"
    t.integer  "left_stride_frequency_per"
    t.integer  "right_stride_frequency"
    t.integer  "right_stride_frequency_per"
    t.integer  "left_stride_frequency_evaluation"
    t.integer  "right_stride_frequency_evaluation"
    t.integer  "width_between_left_stances_evaluation"
    t.integer  "width_between_right_stances_evaluation"
    t.integer  "tip_direction_of_left_foot_evaluation"
    t.integer  "tip_direction_of_right_foot_evaluation"
    t.integer  "instant_of_left_max_pronation"
    t.integer  "instant_of_right_max_pronation"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
