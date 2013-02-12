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

ActiveRecord::Schema.define(:version => 20130130143830) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "areas_of_interest", :force => true do |t|
    t.string   "name",                            :null => false
    t.integer  "workspace_id",                    :null => false
    t.boolean  "is_summary",   :default => false, :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "calculations", :force => true do |t|
    t.string   "display_name",     :null => false
    t.string   "unit"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "project_layer_id"
    t.string   "operation"
  end

  create_table "polygon_uploads", :force => true do |t|
    t.text     "filename"
    t.string   "state"
    t.text     "message"
    t.integer  "area_of_interest_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "table_name"
  end

  create_table "polygons", :force => true do |t|
    t.text     "geometry",            :null => false
    t.integer  "area_of_interest_id", :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "project_layers", :force => true do |t|
    t.string   "display_name"
    t.string   "type"
    t.string   "tile_url"
    t.boolean  "is_displayed"
    t.integer  "provider_id",  :default => 1
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "results", :force => true do |t|
    t.float    "value"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "area_of_interest_id"
    t.integer  "calculation_id"
    t.text     "value_json"
    t.string   "type"
  end

  create_table "workspaces", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
