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

ActiveRecord::Schema.define(version: 20151206172223) do

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

  create_table "hip_frontal_angles", force: true do |t|
    t.integer "user_id"
    t.integer "position"
    t.float   "left"
    t.float   "right"
  end

  create_table "hip_rotations", force: true do |t|
    t.integer "user_id"
    t.integer "position"
    t.float   "left"
    t.float   "right"
  end

  create_table "hip_sagital_angles", force: true do |t|
    t.integer "user_id"
    t.integer "position"
    t.float   "left"
    t.float   "right"
  end

  create_table "knee_frontal_angles", force: true do |t|
    t.integer "user_id"
    t.integer "position"
    t.float   "left"
    t.float   "right"
  end

  create_table "knee_rotations", force: true do |t|
    t.integer "user_id"
    t.integer "position"
    t.float   "left"
    t.float   "right"
  end

  create_table "knee_sagital_angles", force: true do |t|
    t.integer "user_id"
    t.integer "position"
    t.float   "left"
    t.float   "right"
  end

  create_table "levels", force: true do |t|
    t.string "name"
  end

  add_index "levels", ["name"], name: "index_levels_on_name", unique: true

  create_table "program_videos", force: true do |t|
    t.integer "user_id"
    t.string  "video_url"
  end

  create_table "programs", force: true do |t|
    t.integer "user_id"
    t.string  "video_url"
    t.integer "order_num"
    t.text    "text",      limit: 255
  end

  create_table "recommendations", force: true do |t|
    t.integer "user_id"
    t.text    "recommendation"
    t.integer "order_no"
  end

  create_table "session_videos", force: true do |t|
    t.integer "user_id"
    t.string  "video_url"
  end

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
    t.integer  "left_knee_abduction"
    t.integer  "right_knee_abduction"
    t.integer  "left_knee_abduction_speed"
    t.integer  "right_knee_abduction_speed"
    t.integer  "left_knee_rotation"
    t.integer  "right_knee_rotation"
    t.integer  "left_knee_flexion"
    t.integer  "right_knee_flexion"
    t.integer  "left_hip_abduction"
    t.integer  "right_hip_abduction"
    t.integer  "left_hip_basculation"
    t.integer  "right_hip_basculation"
    t.integer  "left_hip_rotation"
    t.integer  "right_hip_rotation"
    t.integer  "left_hip_max_extension"
    t.integer  "right_hip_max_extension"
    t.integer  "q_angle_left"
    t.integer  "q_angle_right"
    t.integer  "legs_length_discrepancy_left"
    t.integer  "back_foot_angle_left"
    t.integer  "back_tibial_strength_left"
    t.integer  "mid_gluteus_strength_left"
    t.integer  "isquiotibial_strength_left"
    t.integer  "vasto_intermedio_left"
    t.integer  "vasto_medial_left"
    t.integer  "vasto_lateral_left"
    t.integer  "psoas_iliaco_left"
    t.integer  "recto_femoral_left"
    t.integer  "isquiotibiales_left"
    t.integer  "iliotibial_band_left"
    t.integer  "hip_rotatoes_left"
    t.integer  "gastrocnemius_y_soleo_left"
    t.integer  "legs_length_discrepancy_right"
    t.integer  "back_foot_angle_right"
    t.integer  "back_tibial_strength_right"
    t.integer  "mid_gluteus_strength_right"
    t.integer  "isquiotibial_strength_right"
    t.integer  "vasto_intermedio_right"
    t.integer  "vasto_medial_right"
    t.integer  "vasto_lateral_right"
    t.integer  "psoas_iliaco_right"
    t.integer  "recto_femoral_right"
    t.integer  "isquiotibiales_right"
    t.integer  "iliotibial_band_right"
    t.integer  "hip_rotatoes_right"
    t.integer  "gastrocnemius_y_soleo_right"
    t.boolean  "published",                              default: false
    t.string   "solt"
    t.string   "raw_password"
    t.text     "conclusions"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["id", "solt"], name: "index_users_on_id_and_solt"
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
