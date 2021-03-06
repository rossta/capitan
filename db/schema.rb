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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120331195226) do

  create_table "authentications", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "html_url"
    t.string   "provider_url"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "authentications", ["provider", "uid"], :name => "index_users_on_provider_and_uid"

  create_table "branches", :force => true do |t|
    t.string   "name",              :null => false
    t.integer  "job_id",            :null => false
    t.integer  "last_build_number"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "branches", ["job_id"], :name => "index_branches_on_job_id"

  create_table "builds", :force => true do |t|
    t.integer  "number",                         :null => false
    t.boolean  "building"
    t.datetime "built_at"
    t.integer  "branch_id"
    t.integer  "job_id"
    t.string   "result_message"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "sha",            :default => "", :null => false
  end

  add_index "builds", ["sha"], :name => "index_builds_on_sha"

  create_table "jobs", :force => true do |t|
    t.string   "name",                         :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "enabled",    :default => true
    t.integer  "stack_id"
  end

  add_index "jobs", ["stack_id"], :name => "index_jobs_on_stack_id"

  create_table "stacks", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
