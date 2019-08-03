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

ActiveRecord::Schema.define(version: 20_190_803_202_651) do
  create_table 'clients', force: :cascade do |t|
    t.string 'name', default: '', null: false
    t.string 'company', default: '', null: false
    t.string 'phone'
    t.string 'email', default: '', null: false
    t.string 'country', default: '', null: false
    t.string 'referred_by'
    t.string 'compnay_phone'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'employees_projects', id: false, force: :cascade do |t|
    t.integer 'project_id', null: false
    t.integer 'employee_id', null: false
  end

  create_table 'payments', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'project_id'
    t.float 'amount'
    t.integer 'creator_id'
    t.index ['project_id'], name: 'index_payments_on_project_id'
  end

  create_table 'projects', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.integer 'creator_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'manager_id'
    t.integer 'client_id'
    t.float 'cost'
    t.index ['client_id'], name: 'index_projects_on_client_id'
    t.index ['manager_id'], name: 'index_projects_on_manager_id'
  end

  create_table 'time_logs', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'hours', default: 1, null: false
    t.integer 'creator_id', default: -1, null: false
    t.integer 'project_id'
    t.integer 'employee_id', default: -1, null: false
    t.index ['project_id'], name: 'index_time_logs_on_project_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'name'
    t.string 'type'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'status', default: false
    t.string 'image', default: 'null'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end
