# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_161_004_112_548) do
  create_table 'server_infos', force: :cascade do |t|
    t.string   'remote_ip', limit: 15, null: false
    t.string   'remote_dns'
    t.string   'local_ip', limit: 15
    t.string   'local_dns'
    t.datetime 'created_at',            null: false
    t.datetime 'updated_at',            null: false
    t.string   'os_type'
  end

  add_index 'server_infos', ['remote_ip'], name: 'index_server_infos_on_remote_ip', unique: true
end
