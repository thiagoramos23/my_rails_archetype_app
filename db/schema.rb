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

ActiveRecord::Schema.define(version: 20140221203140) do

  create_table "alerts", force: true do |t|
    t.integer  "task_id"
    t.integer  "material_id"
    t.boolean  "resolvido"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "razao_social"
    t.string   "cnpj"
    t.string   "nome_fantasia"
    t.string   "endereco"
    t.string   "telefone"
    t.integer  "responsavel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cep"
  end

  create_table "container_locations", force: true do |t|
    t.integer  "material_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "endereco"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entulhos", force: true do |t|
    t.string   "descricao"
    t.decimal  "valor_cobrado", precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entulhos_tasks", id: false, force: true do |t|
    t.integer "entulho_id"
    t.integer "task_id"
  end

  create_table "images", force: true do |t|
    t.integer  "imageable_id"
    t.integer  "imageable_type"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materials", force: true do |t|
    t.string   "codigo"
    t.string   "descricao"
    t.decimal  "peso",        precision: 10, scale: 0
    t.decimal  "largura",     precision: 10, scale: 2
    t.decimal  "altura",      precision: 10, scale: 2
    t.decimal  "comprimento", precision: 10, scale: 2
    t.string   "cor"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "in_deposito"
  end

  create_table "operations", force: true do |t|
    t.string   "descricao"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pessoas", force: true do |t|
    t.string   "nome"
    t.string   "cpf"
    t.string   "rg"
    t.string   "endereco"
    t.string   "cep"
    t.string   "bairro"
    t.string   "cidade"
    t.string   "estado"
    t.integer  "idade"
    t.string   "email"
    t.string   "telefone_residencial"
    t.string   "telefone_comercial"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problems", force: true do |t|
    t.text     "descricao"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "task_id"
  end

  create_table "tasks", force: true do |t|
    t.integer  "ajudante_id"
    t.integer  "motorista_id"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "material_id"
    t.integer  "operation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "truck_id"
    t.string   "endereco"
    t.string   "status"
    t.integer  "company_id"
    t.boolean  "finalizado"
  end

  create_table "trucks", force: true do |t|
    t.string   "placa"
    t.string   "modelo"
    t.string   "chassi"
    t.string   "cor"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
