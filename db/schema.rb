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

ActiveRecord::Schema.define(version: 20150421202916) do

  create_table "clients", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "email"
    t.string   "home_number"
    t.string   "cel_number"
    t.string   "address"
    t.string   "id_number"
    t.date     "birth_day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "document_type_id"
    t.integer  "country_id"
  end

  create_table "person_has_projects", force: true do |t|
    t.integer  "person_id"
    t.integer  "project_id"
    t.date     "start_date"
    t.date     "finish_date"
    t.boolean  "current_project"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_has_projects", ["person_id"], name: "index_person_has_projects_on_person_id", using: :btree
  add_index "person_has_projects", ["project_id"], name: "index_person_has_projects_on_project_id", using: :btree

  create_table "person_has_skills", force: true do |t|
    t.integer  "person_id"
    t.integer  "skill_id"
    t.integer  "rating"
    t.integer  "projects"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_has_skills", ["person_id"], name: "index_person_has_skills_on_person_id", using: :btree
  add_index "person_has_skills", ["skill_id"], name: "index_person_has_skills_on_skill_id", using: :btree

  create_table "project_has_skills", force: true do |t|
    t.integer  "project_id"
    t.integer  "skill_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_has_skills", ["project_id"], name: "index_project_has_skills_on_project_id", using: :btree
  add_index "project_has_skills", ["skill_id"], name: "index_project_has_skills_on_skill_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "start_date"
    t.date     "finish_date"
    t.string   "website"
    t.string   "github"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["client_id"], name: "index_projects_on_client_id", using: :btree

  create_table "skills", force: true do |t|
    t.string   "name"
    t.string   "skill_type"
    t.string   "origin"
    t.text     "description"
    t.string   "documentation"
    t.date     "release_date"
    t.string   "current_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "role"
    t.string   "last_name"
    t.text     "address"
    t.string   "phone"
    t.string   "cell_phone"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
