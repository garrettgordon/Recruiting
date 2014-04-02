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

ActiveRecord::Schema.define(version: 20140402032008) do

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "date"
    t.string   "description"
    t.string   "link"
    t.string   "event_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "foodPresent"
    t.boolean  "acceptingResumes"
    t.integer  "numberOfSpeakers"
    t.integer  "numberOfOrganizers"
    t.string   "resumeCollection"
    t.string   "speakers"
  end

  create_table "events_organizations", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "organization_id"
  end

  add_index "events_organizations", ["event_id", "organization_id"], name: "by_event_and_organization", unique: true

  create_table "events_users", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  add_index "events_users", ["event_id", "user_id"], name: "by_event_and_user", unique: true

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.string   "description"
    t.string   "location"
  end

  create_table "organizations_users", id: false, force: true do |t|
    t.integer "organization_id"
    t.integer "user_id"
  end

  add_index "organizations_users", ["organization_id", "user_id"], name: "by_organization_and_user", unique: true

  create_table "user_sessions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "perishable_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "major"
    t.string   "minor"
    t.string   "name"
    t.integer  "graduating_year"
    t.float    "gpa"
    t.string   "website"
    t.string   "position"
    t.boolean  "recruiter"
    t.boolean  "verified",          default: false
    t.string   "resume"
  end

end
