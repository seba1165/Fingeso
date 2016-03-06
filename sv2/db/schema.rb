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

ActiveRecord::Schema.define(version: 20160302131712) do

  create_table "cargo_empleado", primary_key: "cargo_cod", force: :cascade do |t|
    t.string "cargo_nom"
  end

  create_table "empleado", primary_key: "emp_rut", force: :cascade do |t|
    t.integer  "cargo_cod",                                      null: false
    t.string   "emp_nom",                limit: 20
    t.string   "emp_ape",                limit: 20
    t.string   "emp_tel",                limit: 10
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "empleado", ["cargo_cod"], name: "relationship_43_fk", using: :btree
  add_index "empleado", ["emp_rut"], name: "empleados_pk", unique: true, using: :btree
  add_index "empleado", ["reset_password_token"], name: "index_empleados_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "empleado", "cargo_empleado", column: "cargo_cod", primary_key: "cargo_cod", name: "fk_empleado_relations_cargo_em", on_update: :cascade, on_delete: :restrict
end
