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

ActiveRecord::Schema.define(version: 20160228013804) do

  create_table "accesorio", primary_key: "art_cod", force: :cascade do |t|
    t.integer "art_tipo_cod"
    t.string  "art_nom",      limit: 40
    t.integer "art_stock"
    t.integer "art_precio"
    t.string  "art_imagen",   limit: 254
  end

  add_index "accesorio", ["art_cod"], name: "accesorio_pk", unique: true, using: :btree

  create_table "art_hist_pre", primary_key: "hist_cod", force: :cascade do |t|
    t.integer "art_precio"
    t.date    "precio_desde"
    t.date    "precio_hasta"
    t.string  "art_cod",      limit: 20, null: false
  end

  add_index "art_hist_pre", ["art_cod"], name: "relationship_35_fk", using: :btree
  add_index "art_hist_pre", ["hist_cod"], name: "art_hist_pre_pk", unique: true, using: :btree

  create_table "art_prop_valor", id: false, force: :cascade do |t|
    t.integer "prop_cod",             null: false
    t.integer "dom_cod",              null: false
    t.string  "art_cod",  limit: 20,  null: false
    t.string  "valor",    limit: 300
  end

  add_index "art_prop_valor", ["art_cod"], name: "relationship_30_fk", using: :btree
  add_index "art_prop_valor", ["dom_cod"], name: "relationship_32_fk", using: :btree
  add_index "art_prop_valor", ["prop_cod", "dom_cod"], name: "art_prop_valor_pk", unique: true, using: :btree
  add_index "art_prop_valor", ["prop_cod"], name: "relationship_31_fk", using: :btree

  create_table "articulo", primary_key: "art_cod", force: :cascade do |t|
    t.integer "art_tipo_cod",             null: false
    t.string  "art_nom",      limit: 40
    t.integer "art_stock"
    t.integer "art_precio"
    t.string  "art_imagen",   limit: 254
  end

  add_index "articulo", ["art_cod"], name: "articulo_pk", unique: true, using: :btree
  add_index "articulo", ["art_tipo_cod"], name: "relationship_19_fk", using: :btree

  create_table "boleta", primary_key: "doc_pago_cod", force: :cascade do |t|
    t.date   "doc_pago_fecha"
    t.string "doc_pago_obs",   limit: 50
  end

  add_index "boleta", ["doc_pago_cod"], name: "boleta_pk", unique: true, using: :btree

  create_table "cargo_empleado", primary_key: "cargo_cod", force: :cascade do |t|
    t.string "cargo_nom", limit: 20
  end

  add_index "cargo_empleado", ["cargo_cod"], name: "cargo_empleado_pk", unique: true, using: :btree

  create_table "cliente", primary_key: "cliente_cod", force: :cascade do |t|
    t.integer "tipo_cliente_cod",             null: false
    t.string  "cliente_nom",       limit: 30
    t.string  "cliente_ape",       limit: 30
    t.string  "cliente_direccion", limit: 50
    t.string  "cliente_comuna",    limit: 30
    t.string  "cliente_tel",       limit: 15
    t.string  "cliente_correo",    limit: 50, null: false
    t.string  "cliente_emp",       limit: 30
    t.boolean "cliente_frecuente"
    t.string  "cliente_rut",       limit: 10
  end

  add_index "cliente", ["cliente_cod"], name: "cliente_pk", unique: true, using: :btree
  add_index "cliente", ["tipo_cliente_cod"], name: "relationship_9_fk", using: :btree

  create_table "compatibilidad", id: false, force: :cascade do |t|
    t.string  "art_cod",    limit: 20, null: false
    t.integer "marca_cod",             null: false
    t.integer "modelo_cod",            null: false
  end

  add_index "compatibilidad", ["art_cod"], name: "relationship_27_fk", using: :btree
  add_index "compatibilidad", ["marca_cod", "art_cod", "modelo_cod"], name: "compatibilidad_pk", unique: true, using: :btree
  add_index "compatibilidad", ["marca_cod", "modelo_cod"], name: "relationship_28_fk", using: :btree

  create_table "cot_odc_art", primary_key: "doc_cod", force: :cascade do |t|
    t.integer "cliente_cod"
    t.integer "not_ven_cod"
    t.string  "emp_rut",        limit: 10
    t.date    "doc_fecha"
    t.string  "doc_obs",        limit: 100
    t.integer "doc_neto"
    t.integer "doc_iva"
    t.integer "doc_total"
    t.integer "doc_total_desc"
  end

  add_index "cot_odc_art", ["doc_cod"], name: "cot_odc_art_pk", unique: true, using: :btree

  create_table "cot_odc_serv", primary_key: "doc_cod", force: :cascade do |t|
    t.integer "cliente_cod"
    t.integer "not_ven_cod"
    t.string  "emp_rut",        limit: 10
    t.date    "doc_fecha"
    t.string  "doc_obs",        limit: 100
    t.integer "doc_neto"
    t.integer "doc_iva"
    t.integer "doc_total"
    t.integer "doc_total_desc"
  end

  add_index "cot_odc_serv", ["doc_cod"], name: "cot_odc_serv_pk", unique: true, using: :btree

  create_table "cotizacion", primary_key: "doc_cod", force: :cascade do |t|
    t.integer "cot_est_cod",                null: false
    t.integer "cliente_cod"
    t.integer "not_ven_cod"
    t.string  "emp_rut",        limit: 10
    t.date    "doc_fecha"
    t.string  "doc_obs",        limit: 100
    t.integer "doc_neto"
    t.integer "doc_iva"
    t.integer "doc_total"
    t.integer "doc_total_desc"
  end

  add_index "cotizacion", ["cot_est_cod"], name: "relationship_53_fk", using: :btree
  add_index "cotizacion", ["doc_cod"], name: "cotizacion_pk", unique: true, using: :btree

  create_table "det_cot_odc_art", id: false, force: :cascade do |t|
    t.integer "doc_cod",                  null: false
    t.integer "det_num_linea",            null: false
    t.string  "art_cod",       limit: 20, null: false
    t.integer "art_cant"
    t.integer "art_desc"
  end

  add_index "det_cot_odc_art", ["art_cod"], name: "relationship_2_fk", using: :btree
  add_index "det_cot_odc_art", ["doc_cod", "det_num_linea"], name: "det_cot_odc_art_pk", unique: true, using: :btree
  add_index "det_cot_odc_art", ["doc_cod"], name: "relationship_1_fk", using: :btree

  create_table "det_ot", id: false, force: :cascade do |t|
    t.integer "ot_cod",       null: false
    t.integer "ot_num_linea", null: false
    t.integer "serv_cod",     null: false
    t.integer "marca_cod",    null: false
    t.integer "modelo_cod",   null: false
    t.integer "sr_ad_precio"
    t.integer "sr_ad_cant"
  end

  add_index "det_ot", ["ot_cod", "ot_num_linea"], name: "det_ot_pk", unique: true, using: :btree
  add_index "det_ot", ["ot_cod"], name: "relationship_40_fk", using: :btree
  add_index "det_ot", ["serv_cod", "marca_cod", "modelo_cod"], name: "relationship_41_fk", using: :btree

  create_table "doc_previo", primary_key: "doc_cod", force: :cascade do |t|
    t.integer "cliente_cod",                null: false
    t.integer "not_ven_cod"
    t.string  "emp_rut",        limit: 10,  null: false
    t.date    "doc_fecha"
    t.string  "doc_obs",        limit: 100
    t.integer "doc_neto"
    t.integer "doc_iva"
    t.integer "doc_total"
    t.integer "doc_total_desc"
  end

  add_index "doc_previo", ["cliente_cod"], name: "relationship_8_fk", using: :btree
  add_index "doc_previo", ["doc_cod"], name: "doc_previo_pk", unique: true, using: :btree
  add_index "doc_previo", ["emp_rut"], name: "relationship_66_fk", using: :btree
  add_index "doc_previo", ["not_ven_cod"], name: "relationship_7_fk", using: :btree

  create_table "documento_de_pago", primary_key: "doc_pago_cod", force: :cascade do |t|
    t.date   "doc_pago_fecha"
    t.string "doc_pago_obs",   limit: 50
  end

  add_index "documento_de_pago", ["doc_pago_cod"], name: "documento_de_pago_pk", unique: true, using: :btree

  create_table "dom_val_art", primary_key: "dom_cod", force: :cascade do |t|
    t.string  "dom_nom",  limit: 30
    t.string  "dom_tipo", limit: 40
    t.integer "dom_min"
    t.integer "dom_max"
  end

  add_index "dom_val_art", ["dom_cod"], name: "dom_val_art_pk", unique: true, using: :btree

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

  create_table "estado_cotizacion", primary_key: "cot_est_cod", force: :cascade do |t|
    t.string "cot_est_descr", limit: 30
  end

  add_index "estado_cotizacion", ["cot_est_cod"], name: "estado_cotizacion_pk", unique: true, using: :btree

  create_table "estado_factura", primary_key: "fact_est_cod", force: :cascade do |t|
    t.string "fact_est_descr", limit: 30
  end

  add_index "estado_factura", ["fact_est_cod"], name: "estado_factura_pk", unique: true, using: :btree

  create_table "estado_nota_de_venta", primary_key: "not_ven_est_cod", force: :cascade do |t|
    t.string "not_ven_est_descr", limit: 30
  end

  add_index "estado_nota_de_venta", ["not_ven_est_cod"], name: "estado_nota_de_venta_pk", unique: true, using: :btree

  create_table "estado_oc", primary_key: "oc_est_cod", force: :cascade do |t|
    t.string "oc_est_descr", limit: 30
  end

  add_index "estado_oc", ["oc_est_cod"], name: "estado_oc_pk", unique: true, using: :btree

  create_table "estado_od", primary_key: "od_est_cod", force: :cascade do |t|
    t.string "od_est_descr", limit: 30
  end

  add_index "estado_od", ["od_est_cod"], name: "estado_od_pk", unique: true, using: :btree

  create_table "estado_ot", primary_key: "ot_est_cod", force: :cascade do |t|
    t.string "ot_est_descr", limit: 30
  end

  add_index "estado_ot", ["ot_est_cod"], name: "estado_ot_pk", unique: true, using: :btree

  create_table "factura", primary_key: "doc_pago_cod", force: :cascade do |t|
    t.integer "fact_est_cod",              null: false
    t.date    "doc_pago_fecha"
    t.string  "doc_pago_obs",   limit: 50
  end

  add_index "factura", ["doc_pago_cod"], name: "factura_pk", unique: true, using: :btree
  add_index "factura", ["fact_est_cod"], name: "relationship_97_fk", using: :btree

  create_table "herramienta", primary_key: "art_cod", force: :cascade do |t|
    t.integer "art_tipo_cod"
    t.string  "art_nom",      limit: 40
    t.integer "art_stock"
    t.integer "art_precio"
    t.string  "art_imagen",   limit: 254
  end

  add_index "herramienta", ["art_cod"], name: "herramienta_pk", unique: true, using: :btree

  create_table "hist_est_cot", id: false, force: :cascade do |t|
    t.integer "doc_cod",          null: false
    t.integer "cot_est_cod",      null: false
    t.date    "cot_estado_desde"
    t.date    "cot_estado_hasta"
  end

  add_index "hist_est_cot", ["cot_est_cod"], name: "relationship_104_fk", using: :btree
  add_index "hist_est_cot", ["doc_cod", "cot_est_cod"], name: "hist_est_cot_pk", unique: true, using: :btree
  add_index "hist_est_cot", ["doc_cod"], name: "relationship_103_fk", using: :btree

  create_table "hist_est_fact", id: false, force: :cascade do |t|
    t.integer "fact_est_cod",      null: false
    t.integer "doc_pago_cod",      null: false
    t.date    "fact_estado_desde"
    t.date    "fact_estado_hasta"
  end

  add_index "hist_est_fact", ["doc_pago_cod"], name: "relationship_99_fk", using: :btree
  add_index "hist_est_fact", ["fact_est_cod", "doc_pago_cod"], name: "hist_est_fact_pk", unique: true, using: :btree
  add_index "hist_est_fact", ["fact_est_cod"], name: "relationship_98_fk", using: :btree

  create_table "hist_est_nv", id: false, force: :cascade do |t|
    t.integer "not_ven_cod",          null: false
    t.integer "not_ven_est_cod",      null: false
    t.date    "not_ven_estado_desde"
    t.date    "not_ven_estado_hasta"
  end

  add_index "hist_est_nv", ["not_ven_cod", "not_ven_est_cod"], name: "hist_est_nv_pk", unique: true, using: :btree
  add_index "hist_est_nv", ["not_ven_cod"], name: "relationship_83_fk", using: :btree
  add_index "hist_est_nv", ["not_ven_est_cod"], name: "relationship_84_fk", using: :btree

  create_table "hist_est_oc", id: false, force: :cascade do |t|
    t.integer "doc_cod",         null: false
    t.integer "oc_est_cod",      null: false
    t.date    "oc_estado_desde"
    t.date    "oc_estado_hasta"
  end

  add_index "hist_est_oc", ["doc_cod", "oc_est_cod"], name: "hist_est_oc_pk", unique: true, using: :btree
  add_index "hist_est_oc", ["doc_cod"], name: "relationship_111_fk", using: :btree
  add_index "hist_est_oc", ["oc_est_cod"], name: "relationship_116_fk", using: :btree

  create_table "hist_est_od", id: false, force: :cascade do |t|
    t.integer "od_cod",          null: false
    t.integer "od_est_cod",      null: false
    t.date    "od_estado_desde"
    t.date    "od_estado_hasta"
  end

  add_index "hist_est_od", ["od_cod", "od_est_cod"], name: "hist_est_od_pk", unique: true, using: :btree
  add_index "hist_est_od", ["od_cod"], name: "relationship_93_fk", using: :btree
  add_index "hist_est_od", ["od_est_cod"], name: "relationship_94_fk", using: :btree

  create_table "hist_est_ot", id: false, force: :cascade do |t|
    t.integer "ot_cod",          null: false
    t.integer "ot_est_cod",      null: false
    t.date    "ot_estado_desde"
    t.date    "ot_estado_hasta"
  end

  add_index "hist_est_ot", ["ot_cod", "ot_est_cod"], name: "hist_est_ot_pk", unique: true, using: :btree
  add_index "hist_est_ot", ["ot_cod"], name: "relationship_87_fk", using: :btree
  add_index "hist_est_ot", ["ot_est_cod"], name: "relationship_88_fk", using: :btree

  create_table "insumo", primary_key: "art_cod", force: :cascade do |t|
    t.integer "art_tipo_cod"
    t.string  "art_nom",      limit: 40
    t.integer "art_stock"
    t.integer "art_precio"
    t.string  "art_imagen",   limit: 254
  end

  add_index "insumo", ["art_cod"], name: "insumo_pk", unique: true, using: :btree

  create_table "log", primary_key: "pk_audit", force: :cascade do |t|
    t.string   "TableName",  limit: 45, null: false
    t.string   "Operation",  limit: 1,  null: false
    t.text     "OldValue"
    t.text     "NewValue"
    t.datetime "UpdateDate",            null: false
    t.string   "UserName",   limit: 45, null: false
  end

  create_table "marca", primary_key: "marca_cod", force: :cascade do |t|
    t.string "marca_nombre", limit: 30
  end

  add_index "marca", ["marca_cod"], name: "marca_pk", unique: true, using: :btree

  create_table "metodo_de_pago", primary_key: "pago_cod", force: :cascade do |t|
    t.string "pago_tipo", limit: 20
  end

  add_index "metodo_de_pago", ["pago_cod"], name: "metodo_de_pago_pk", unique: true, using: :btree

  create_table "modelo", id: false, force: :cascade do |t|
    t.integer "marca_cod",                                                            null: false
    t.integer "modelo_cod",               default: "nextval('modelo_sec'::regclass)", null: false
    t.string  "modelo_nombre", limit: 30
    t.integer "modelo_ano"
  end

  add_index "modelo", ["marca_cod", "modelo_cod"], name: "modelo_pk", unique: true, using: :btree
  add_index "modelo", ["marca_cod"], name: "relationship_11_fk", using: :btree

  create_table "nota_de_venta", primary_key: "not_ven_cod", force: :cascade do |t|
    t.integer "od_cod"
    t.integer "not_ven_est_cod",             null: false
    t.integer "doc_pago_cod",                null: false
    t.integer "pago_cod"
    t.date    "not_ven_fecha"
    t.string  "not_ven_obs",     limit: 100
  end

  add_index "nota_de_venta", ["doc_pago_cod"], name: "relationship_69_fk", using: :btree
  add_index "nota_de_venta", ["not_ven_cod"], name: "nota_de_venta_pk", unique: true, using: :btree
  add_index "nota_de_venta", ["not_ven_est_cod"], name: "relationship_77_fk", using: :btree
  add_index "nota_de_venta", ["od_cod"], name: "relationship_51_fk", using: :btree
  add_index "nota_de_venta", ["pago_cod"], name: "relationship_42_fk", using: :btree

  create_table "orden_de_compra", primary_key: "doc_cod", force: :cascade do |t|
    t.integer "oc_est_cod",                 null: false
    t.integer "cliente_cod"
    t.integer "not_ven_cod"
    t.string  "emp_rut",        limit: 10
    t.date    "doc_fecha"
    t.string  "doc_obs",        limit: 100
    t.integer "doc_neto"
    t.integer "doc_iva"
    t.integer "doc_total"
    t.integer "doc_total_desc"
  end

  add_index "orden_de_compra", ["doc_cod"], name: "orden_de_compra_pk", unique: true, using: :btree
  add_index "orden_de_compra", ["oc_est_cod"], name: "relationship_80_fk", using: :btree

  create_table "orden_de_despacho", primary_key: "od_cod", force: :cascade do |t|
    t.integer "not_ven_cod",             null: false
    t.integer "od_est_cod",              null: false
    t.date    "od_fecha"
    t.string  "od_obs",      limit: 100
    t.date    "desp_fecha"
    t.string  "od_dir",      limit: 50
  end

  add_index "orden_de_despacho", ["not_ven_cod"], name: "relationship_52_fk", using: :btree
  add_index "orden_de_despacho", ["od_cod"], name: "orden_de_despacho_pk", unique: true, using: :btree
  add_index "orden_de_despacho", ["od_est_cod"], name: "relationship_55_fk", using: :btree

  create_table "orden_de_trabajo", primary_key: "ot_cod", force: :cascade do |t|
    t.string  "veh_pat",     limit: 6
    t.integer "not_ven_cod"
    t.integer "doc_cod",                 null: false
    t.integer "ot_est_cod"
    t.string  "emp_rut",     limit: 10
    t.date    "ot_fecha",                null: false
    t.string  "ot_obs",      limit: 100
    t.integer "modelo_cod"
  end

  add_index "orden_de_trabajo", ["doc_cod"], name: "relationship_36_fk", using: :btree
  add_index "orden_de_trabajo", ["emp_rut"], name: "relationship_67_fk", using: :btree
  add_index "orden_de_trabajo", ["not_ven_cod"], name: "relationship_37_fk", using: :btree
  add_index "orden_de_trabajo", ["ot_cod"], name: "orden_de_trabajo_pk", unique: true, using: :btree
  add_index "orden_de_trabajo", ["ot_est_cod"], name: "relationship_56_fk", using: :btree
  add_index "orden_de_trabajo", ["veh_pat"], name: "relationship_39_fk", using: :btree

  create_table "para_instalacion", primary_key: "art_cod", force: :cascade do |t|
    t.integer "art_tipo_cod"
    t.string  "art_nom",      limit: 40
    t.integer "art_stock"
    t.integer "art_precio"
    t.string  "art_imagen",   limit: 254
  end

  add_index "para_instalacion", ["art_cod"], name: "para_instalacion_pk", unique: true, using: :btree

  create_table "parametros", primary_key: "param_cod", force: :cascade do |t|
    t.string  "param_nom",        limit: 20
    t.integer "param_valor"
    t.string  "param_valor_tipo", limit: 30
  end

  create_table "propiedad_articulo", primary_key: "prop_cod", force: :cascade do |t|
    t.integer "dom_cod",                 null: false
    t.integer "art_tipo_cod",            null: false
    t.string  "prop_nom",     limit: 40
    t.string  "prop_med",     limit: 20
  end

  add_index "propiedad_articulo", ["art_tipo_cod"], name: "relationship_29_fk", using: :btree
  add_index "propiedad_articulo", ["dom_cod"], name: "relationship_26_fk", using: :btree
  add_index "propiedad_articulo", ["prop_cod"], name: "propiedad_articulo_pk", unique: true, using: :btree

  create_table "proveedor", primary_key: "prov_cod", force: :cascade do |t|
    t.string "prov_nom", limit: 30
    t.string "prov_web", limit: 40
  end

  add_index "proveedor", ["prov_cod"], name: "proveedor_pk", unique: true, using: :btree

  create_table "proveedor_articulo", id: false, force: :cascade do |t|
    t.integer "prov_cod",                null: false
    t.string  "art_cod",      limit: 20, null: false
    t.string  "cod_prov_art", limit: 30
  end

  add_index "proveedor_articulo", ["art_cod"], name: "relationship_15_fk", using: :btree
  add_index "proveedor_articulo", ["prov_cod", "art_cod"], name: "proveedor_articulo_pk", unique: true, using: :btree
  add_index "proveedor_articulo", ["prov_cod"], name: "relationship_14_fk", using: :btree

  create_table "repuesto", primary_key: "art_cod", force: :cascade do |t|
    t.integer "art_tipo_cod"
    t.string  "art_nom",      limit: 40
    t.integer "art_stock"
    t.integer "art_precio"
    t.string  "art_imagen",   limit: 254
  end

  add_index "repuesto", ["art_cod"], name: "repuesto_pk", unique: true, using: :btree

  create_table "serv_inst", primary_key: "doc_cod", force: :cascade do |t|
    t.integer "cliente_cod"
    t.integer "not_ven_cod"
    t.string  "emp_rut",        limit: 10
    t.date    "doc_fecha"
    t.string  "doc_obs",        limit: 100
    t.integer "doc_neto"
    t.integer "doc_iva"
    t.integer "doc_total"
    t.integer "doc_total_desc"
  end

  add_index "serv_inst", ["doc_cod"], name: "serv_inst_pk", unique: true, using: :btree

  create_table "serv_inst_det", id: false, force: :cascade do |t|
    t.integer "doc_cod",                 null: false
    t.integer "si_num_linea",            null: false
    t.integer "marca_cod",               null: false
    t.string  "art_cod",      limit: 20, null: false
    t.integer "modelo_cod",              null: false
    t.integer "si_desc"
  end

  add_index "serv_inst_det", ["doc_cod", "si_num_linea"], name: "serv_inst_det_pk", unique: true, using: :btree
  add_index "serv_inst_det", ["doc_cod"], name: "relationship_4_fk", using: :btree
  add_index "serv_inst_det", ["marca_cod", "art_cod", "modelo_cod"], name: "relationship_18_fk", using: :btree

  create_table "serv_rep", primary_key: "doc_cod", force: :cascade do |t|
    t.integer "cliente_cod"
    t.integer "not_ven_cod"
    t.string  "emp_rut",        limit: 10
    t.date    "doc_fecha"
    t.string  "doc_obs",        limit: 100
    t.integer "doc_neto"
    t.integer "doc_iva"
    t.integer "doc_total"
    t.integer "doc_total_desc"
  end

  add_index "serv_rep", ["doc_cod"], name: "serv_rep_pk", unique: true, using: :btree

  create_table "serv_rep_det", id: false, force: :cascade do |t|
    t.integer "doc_cod",      null: false
    t.integer "sr_num_linea", null: false
    t.integer "serv_cod",     null: false
    t.integer "marca_cod",    null: false
    t.integer "modelo_cod",   null: false
    t.integer "sr_desc"
    t.integer "sr_precio"
    t.integer "sr_cant"
  end

  add_index "serv_rep_det", ["doc_cod", "sr_num_linea"], name: "serv_rep_det_pk", unique: true, using: :btree
  add_index "serv_rep_det", ["doc_cod"], name: "relationship_6_fk", using: :btree
  add_index "serv_rep_det", ["serv_cod", "marca_cod", "modelo_cod"], name: "relationship_13_fk", using: :btree

  create_table "servicio_reparacion", primary_key: "serv_cod", force: :cascade do |t|
    t.string "serv_nom", limit: 40
  end

  add_index "servicio_reparacion", ["serv_cod"], name: "servicio_reparacion_pk", unique: true, using: :btree

  create_table "si_vehiculo_articulo", id: false, force: :cascade do |t|
    t.string  "art_cod",     limit: 20, null: false
    t.integer "marca_cod",              null: false
    t.integer "modelo_cod",             null: false
    t.integer "s_v_a_mo_pr"
  end

  add_index "si_vehiculo_articulo", ["art_cod"], name: "relationship_16_fk", using: :btree
  add_index "si_vehiculo_articulo", ["marca_cod", "art_cod", "modelo_cod"], name: "si_vehiculo_articulo_pk", unique: true, using: :btree
  add_index "si_vehiculo_articulo", ["marca_cod", "modelo_cod"], name: "relationship_17_fk", using: :btree

  create_table "tipo_articulo", primary_key: "art_tipo_cod", force: :cascade do |t|
    t.string "tipo_nom", limit: 40
  end

  add_index "tipo_articulo", ["art_tipo_cod"], name: "tipo_articulo_pk", unique: true, using: :btree

  create_table "tipo_cliente", primary_key: "tipo_cliente_cod", force: :cascade do |t|
    t.string "tipo_cliente_descr", limit: 30
  end

  add_index "tipo_cliente", ["tipo_cliente_cod"], name: "tipo_cliente_pk", unique: true, using: :btree

  create_table "tran_est_cot", id: false, force: :cascade do |t|
    t.integer "cot_est_cod",     null: false
    t.integer "est_cot_est_cod", null: false
  end

  add_index "tran_est_cot", ["cot_est_cod", "est_cot_est_cod"], name: "tran_est_cot_pk", unique: true, using: :btree
  add_index "tran_est_cot", ["cot_est_cod"], name: "relationship_101_fk", using: :btree
  add_index "tran_est_cot", ["est_cot_est_cod"], name: "relationship_102_fk", using: :btree

  create_table "trans_est_fact", id: false, force: :cascade do |t|
    t.integer "fact_est_cod",     null: false
    t.integer "est_fact_est_cod", null: false
  end

  add_index "trans_est_fact", ["est_fact_est_cod"], name: "relationship_96_fk", using: :btree
  add_index "trans_est_fact", ["fact_est_cod", "est_fact_est_cod"], name: "trans_est_fact_pk", unique: true, using: :btree
  add_index "trans_est_fact", ["fact_est_cod"], name: "relationship_95_fk", using: :btree

  create_table "trans_est_nv", id: false, force: :cascade do |t|
    t.integer "est_not_ven_est_cod", null: false
    t.integer "not_ven_est_cod",     null: false
  end

  add_index "trans_est_nv", ["est_not_ven_est_cod", "not_ven_est_cod"], name: "trans_est_nv_pk", unique: true, using: :btree
  add_index "trans_est_nv", ["est_not_ven_est_cod"], name: "relationship_81_fk", using: :btree
  add_index "trans_est_nv", ["not_ven_est_cod"], name: "relationship_82_fk", using: :btree

  create_table "trans_est_oc", id: false, force: :cascade do |t|
    t.integer "est_oc_est_cod", null: false
    t.integer "oc_est_cod",     null: false
  end

  add_index "trans_est_oc", ["est_oc_est_cod", "oc_est_cod"], name: "trans_est_oc_pk", unique: true, using: :btree
  add_index "trans_est_oc", ["est_oc_est_cod"], name: "relationship_114_fk", using: :btree
  add_index "trans_est_oc", ["oc_est_cod"], name: "relationship_115_fk", using: :btree

  create_table "trans_est_od", id: false, force: :cascade do |t|
    t.integer "od_est_cod",     null: false
    t.integer "est_od_est_cod", null: false
  end

  add_index "trans_est_od", ["est_od_est_cod"], name: "relationship_90_fk", using: :btree
  add_index "trans_est_od", ["od_est_cod", "est_od_est_cod"], name: "trans_est_od_pk", unique: true, using: :btree
  add_index "trans_est_od", ["od_est_cod"], name: "relationship_89_fk", using: :btree

  create_table "trans_est_ot", id: false, force: :cascade do |t|
    t.integer "ot_est_cod",     null: false
    t.integer "est_ot_est_cod", null: false
  end

  add_index "trans_est_ot", ["est_ot_est_cod"], name: "relationship_86_fk", using: :btree
  add_index "trans_est_ot", ["ot_est_cod", "est_ot_est_cod"], name: "trans_est_ot_pk", unique: true, using: :btree
  add_index "trans_est_ot", ["ot_est_cod"], name: "relationship_85_fk", using: :btree

  create_table "vehiculo", primary_key: "veh_pat", force: :cascade do |t|
    t.integer "marca_cod",             null: false
    t.integer "modelo_cod",            null: false
    t.integer "veh_km"
    t.string  "veh_color",  limit: 10
  end

  add_index "vehiculo", ["marca_cod", "modelo_cod"], name: "relationship_38_fk", using: :btree
  add_index "vehiculo", ["veh_pat"], name: "vehiculo_pk", unique: true, using: :btree

  create_table "vehiculo_serviciorep", id: false, force: :cascade do |t|
    t.integer "serv_cod",   null: false
    t.integer "marca_cod",  null: false
    t.integer "modelo_cod", null: false
    t.integer "sr_v_mo_pr"
    t.integer "sr_v_in_pr"
  end

  add_index "vehiculo_serviciorep", ["marca_cod", "modelo_cod"], name: "relationship_12_fk", using: :btree
  add_index "vehiculo_serviciorep", ["serv_cod", "marca_cod", "modelo_cod"], name: "vehiculo_serviciorep_pk", unique: true, using: :btree
  add_index "vehiculo_serviciorep", ["serv_cod"], name: "relationship_10_fk", using: :btree

  add_foreign_key "accesorio", "para_instalacion", column: "art_cod", primary_key: "art_cod", name: "fk_accesori_inheritan_para_ins", on_update: :cascade, on_delete: :cascade
  add_foreign_key "art_hist_pre", "articulo", column: "art_cod", primary_key: "art_cod", name: "fk_art_hist_relations_articulo", on_update: :cascade, on_delete: :cascade
  add_foreign_key "art_prop_valor", "articulo", column: "art_cod", primary_key: "art_cod", name: "fk_art_prop_relations_articulo", on_update: :cascade, on_delete: :cascade
  add_foreign_key "art_prop_valor", "dom_val_art", column: "dom_cod", primary_key: "dom_cod", name: "fk_art_prop_relations_dom_val_", on_update: :cascade, on_delete: :nullify
  add_foreign_key "art_prop_valor", "propiedad_articulo", column: "prop_cod", primary_key: "prop_cod", name: "fk_art_prop_relations_propieda", on_update: :cascade, on_delete: :cascade
  add_foreign_key "articulo", "tipo_articulo", column: "art_tipo_cod", primary_key: "art_tipo_cod", name: "fk_articulo_relations_tipo_art", on_update: :cascade, on_delete: :nullify
  add_foreign_key "boleta", "documento_de_pago", column: "doc_pago_cod", primary_key: "doc_pago_cod", name: "fk_boleta_inheritan_document", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cliente", "tipo_cliente", column: "tipo_cliente_cod", primary_key: "tipo_cliente_cod", name: "fk_cliente_relations_tipo_cli", on_update: :cascade, on_delete: :nullify
  add_foreign_key "compatibilidad", "modelo", column: "marca_cod", primary_key: "marca_cod", name: "fk_compatib_relations_modelo", on_update: :cascade, on_delete: :cascade
  add_foreign_key "compatibilidad", "para_instalacion", column: "art_cod", primary_key: "art_cod", name: "fk_compatib_relations_para_ins", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cot_odc_art", "doc_previo", column: "doc_cod", primary_key: "doc_cod", name: "fk_cot_odc__inheritan_doc_prev", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cot_odc_serv", "doc_previo", column: "doc_cod", primary_key: "doc_cod", name: "fk_cot_odc__inheritan_doc_prev", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cotizacion", "doc_previo", column: "doc_cod", primary_key: "doc_cod", name: "fk_cotizaci_inheritan_doc_prev", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cotizacion", "estado_cotizacion", column: "cot_est_cod", primary_key: "cot_est_cod", name: "fk_cotizaci_relations_estado_c", on_update: :cascade, on_delete: :restrict
  add_foreign_key "det_cot_odc_art", "articulo", column: "art_cod", primary_key: "art_cod", name: "fk_det_cot__relations_articulo", on_update: :cascade, on_delete: :nullify
  add_foreign_key "det_cot_odc_art", "cot_odc_art", column: "doc_cod", primary_key: "doc_cod", name: "fk_det_cot__relations_cot_odc_", on_update: :cascade, on_delete: :cascade
  add_foreign_key "det_ot", "orden_de_trabajo", column: "ot_cod", primary_key: "ot_cod", name: "fk_det_ot_relations_orden_de", on_update: :cascade, on_delete: :cascade
  add_foreign_key "det_ot", "vehiculo_serviciorep", column: "serv_cod", primary_key: "serv_cod", name: "fk_det_ot_relations_vehiculo", on_update: :cascade, on_delete: :nullify
  add_foreign_key "doc_previo", "cliente", column: "cliente_cod", primary_key: "cliente_cod", name: "fk_doc_prev_relations_cliente", on_update: :cascade, on_delete: :restrict
  add_foreign_key "doc_previo", "empleado", column: "emp_rut", primary_key: "emp_rut", name: "fk_doc_prev_relations_empleado", on_update: :cascade, on_delete: :restrict
  add_foreign_key "doc_previo", "nota_de_venta", column: "not_ven_cod", primary_key: "not_ven_cod", name: "fk_doc_prev_relations_nota_de_", on_update: :cascade, on_delete: :nullify
  add_foreign_key "empleado", "cargo_empleado", column: "cargo_cod", primary_key: "cargo_cod", name: "fk_empleado_relations_cargo_em", on_update: :cascade, on_delete: :restrict
  add_foreign_key "factura", "documento_de_pago", column: "doc_pago_cod", primary_key: "doc_pago_cod", name: "fk_factura_inheritan_document", on_update: :cascade, on_delete: :cascade
  add_foreign_key "factura", "estado_factura", column: "fact_est_cod", primary_key: "fact_est_cod", name: "fk_factura_relations_estado_f", on_update: :restrict, on_delete: :restrict
  add_foreign_key "herramienta", "articulo", column: "art_cod", primary_key: "art_cod", name: "fk_herramie_inheritan_articulo", on_update: :cascade, on_delete: :cascade
  add_foreign_key "hist_est_cot", "cotizacion", column: "doc_cod", primary_key: "doc_cod", name: "fk_hist_est_relations_cotizaci", on_update: :cascade, on_delete: :cascade
  add_foreign_key "hist_est_cot", "estado_cotizacion", column: "cot_est_cod", primary_key: "cot_est_cod", name: "fk_hist_est_relations_estado_c", on_update: :cascade, on_delete: :cascade
  add_foreign_key "hist_est_fact", "estado_factura", column: "fact_est_cod", primary_key: "fact_est_cod", name: "fk_hist_est_relations_estado_f", on_update: :cascade, on_delete: :cascade
  add_foreign_key "hist_est_fact", "factura", column: "doc_pago_cod", primary_key: "doc_pago_cod", name: "fk_hist_est_relations_factura", on_update: :cascade, on_delete: :cascade
  add_foreign_key "hist_est_nv", "estado_nota_de_venta", column: "not_ven_est_cod", primary_key: "not_ven_est_cod", name: "fk_hist_est_relations_estado_n", on_update: :cascade, on_delete: :cascade
  add_foreign_key "hist_est_nv", "nota_de_venta", column: "not_ven_cod", primary_key: "not_ven_cod", name: "fk_hist_est_relations_nota_de_", on_update: :cascade, on_delete: :cascade
  add_foreign_key "hist_est_oc", "estado_oc", column: "oc_est_cod", primary_key: "oc_est_cod", name: "fk_hist_est_relations_estado_o", on_update: :cascade, on_delete: :cascade
  add_foreign_key "hist_est_oc", "orden_de_compra", column: "doc_cod", primary_key: "doc_cod", name: "fk_hist_est_relations_orden_de", on_update: :cascade, on_delete: :cascade
  add_foreign_key "hist_est_od", "estado_od", column: "od_est_cod", primary_key: "od_est_cod", name: "fk_hist_est_relations_estado_o", on_update: :cascade, on_delete: :cascade
  add_foreign_key "hist_est_od", "orden_de_despacho", column: "od_cod", primary_key: "od_cod", name: "fk_hist_est_relations_orden_de", on_update: :cascade, on_delete: :cascade
  add_foreign_key "hist_est_ot", "estado_ot", column: "ot_est_cod", primary_key: "ot_est_cod", name: "fk_hist_est_relations_estado_o", on_update: :cascade, on_delete: :cascade
  add_foreign_key "hist_est_ot", "orden_de_trabajo", column: "ot_cod", primary_key: "ot_cod", name: "fk_hist_est_relations_orden_de", on_update: :cascade, on_delete: :cascade
  add_foreign_key "insumo", "articulo", column: "art_cod", primary_key: "art_cod", name: "fk_insumo_inheritan_articulo", on_update: :cascade, on_delete: :cascade
  add_foreign_key "modelo", "marca", column: "marca_cod", primary_key: "marca_cod", name: "fk_modelo_relations_marca", on_update: :cascade, on_delete: :cascade
  add_foreign_key "nota_de_venta", "documento_de_pago", column: "doc_pago_cod", primary_key: "doc_pago_cod", name: "fk_nota_de__relations_document", on_update: :cascade, on_delete: :restrict
  add_foreign_key "nota_de_venta", "estado_nota_de_venta", column: "not_ven_est_cod", primary_key: "not_ven_est_cod", name: "fk_nota_de__relations_estado_n", on_update: :cascade, on_delete: :restrict
  add_foreign_key "nota_de_venta", "metodo_de_pago", column: "pago_cod", primary_key: "pago_cod", name: "fk_nota_de__relations_metodo_d", on_update: :cascade, on_delete: :restrict
  add_foreign_key "nota_de_venta", "orden_de_despacho", column: "od_cod", primary_key: "od_cod", name: "fk_nota_de__relations_orden_de", on_update: :cascade, on_delete: :nullify
  add_foreign_key "orden_de_compra", "doc_previo", column: "doc_cod", primary_key: "doc_cod", name: "fk_orden_de_inheritan_doc_prev", on_update: :cascade, on_delete: :cascade
  add_foreign_key "orden_de_compra", "estado_oc", column: "oc_est_cod", primary_key: "oc_est_cod", name: "fk_orden_de_relations_estado_o", on_update: :cascade, on_delete: :restrict
  add_foreign_key "orden_de_despacho", "estado_od", column: "od_est_cod", primary_key: "od_est_cod", name: "fk_orden_de_relations_estado_o", on_update: :cascade, on_delete: :restrict
  add_foreign_key "orden_de_despacho", "nota_de_venta", column: "not_ven_cod", primary_key: "not_ven_cod", name: "fk_orden_de_relations_nota_de_", on_update: :cascade, on_delete: :cascade
  add_foreign_key "orden_de_trabajo", "doc_previo", column: "doc_cod", primary_key: "doc_cod", name: "fk_orden_de_relations_doc_prev", on_update: :cascade, on_delete: :restrict
  add_foreign_key "orden_de_trabajo", "empleado", column: "emp_rut", primary_key: "emp_rut", name: "fk_orden_de_relations_empleado", on_update: :cascade, on_delete: :restrict
  add_foreign_key "orden_de_trabajo", "estado_ot", column: "ot_est_cod", primary_key: "ot_est_cod", name: "fk_orden_de_relations_estado_o", on_update: :cascade, on_delete: :restrict
  add_foreign_key "orden_de_trabajo", "nota_de_venta", column: "not_ven_cod", primary_key: "not_ven_cod", name: "fk_orden_de_relations_nota_de_", on_update: :cascade, on_delete: :nullify
  add_foreign_key "orden_de_trabajo", "vehiculo", column: "veh_pat", primary_key: "veh_pat", name: "fk_orden_de_relations_vehiculo", on_update: :cascade, on_delete: :nullify
  add_foreign_key "para_instalacion", "articulo", column: "art_cod", primary_key: "art_cod", name: "fk_para_ins_inheritan_articulo", on_update: :cascade, on_delete: :cascade
  add_foreign_key "propiedad_articulo", "dom_val_art", column: "dom_cod", primary_key: "dom_cod", name: "fk_propieda_relations_dom_val_", on_update: :cascade, on_delete: :nullify
  add_foreign_key "propiedad_articulo", "tipo_articulo", column: "art_tipo_cod", primary_key: "art_tipo_cod", name: "fk_propieda_relations_tipo_art", on_update: :cascade, on_delete: :nullify
  add_foreign_key "proveedor_articulo", "articulo", column: "art_cod", primary_key: "art_cod", name: "fk_proveedo_relations_articulo", on_update: :cascade, on_delete: :cascade
  add_foreign_key "proveedor_articulo", "proveedor", column: "prov_cod", primary_key: "prov_cod", name: "fk_proveedo_relations_proveedo", on_update: :cascade, on_delete: :cascade
  add_foreign_key "repuesto", "para_instalacion", column: "art_cod", primary_key: "art_cod", name: "fk_repuesto_inheritan_para_ins", on_update: :cascade, on_delete: :cascade
  add_foreign_key "serv_inst", "cot_odc_serv", column: "doc_cod", primary_key: "doc_cod", name: "fk_serv_ins_inheritan_cot_odc_", on_update: :cascade, on_delete: :cascade
  add_foreign_key "serv_inst_det", "serv_inst", column: "doc_cod", primary_key: "doc_cod", name: "fk_serv_ins_relations_serv_ins", on_update: :cascade, on_delete: :cascade
  add_foreign_key "serv_inst_det", "si_vehiculo_articulo", column: "marca_cod", primary_key: "marca_cod", name: "fk_serv_ins_relations_si_vehic", on_update: :cascade, on_delete: :nullify
  add_foreign_key "serv_rep", "cot_odc_serv", column: "doc_cod", primary_key: "doc_cod", name: "fk_serv_rep_inheritan_cot_odc_", on_update: :cascade, on_delete: :cascade
  add_foreign_key "serv_rep_det", "serv_rep", column: "doc_cod", primary_key: "doc_cod", name: "fk_serv_rep_relations_serv_rep", on_update: :cascade, on_delete: :cascade
  add_foreign_key "serv_rep_det", "vehiculo_serviciorep", column: "serv_cod", primary_key: "serv_cod", name: "fk_serv_rep_relations_vehiculo", on_update: :cascade, on_delete: :nullify
  add_foreign_key "si_vehiculo_articulo", "modelo", column: "marca_cod", primary_key: "marca_cod", name: "fk_si_vehic_relations_modelo", on_update: :cascade, on_delete: :cascade
  add_foreign_key "si_vehiculo_articulo", "para_instalacion", column: "art_cod", primary_key: "art_cod", name: "fk_si_vehic_relations_para_ins", on_update: :cascade, on_delete: :cascade
  add_foreign_key "tran_est_cot", "estado_cotizacion", column: "cot_est_cod", primary_key: "cot_est_cod", name: "fk_tran_est_relations_estado_c1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "tran_est_cot", "estado_cotizacion", column: "est_cot_est_cod", primary_key: "cot_est_cod", name: "fk_tran_est_relations_estado_c2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "trans_est_fact", "estado_factura", column: "est_fact_est_cod", primary_key: "fact_est_cod", name: "fk_trans_es_relations_estado_f2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "trans_est_fact", "estado_factura", column: "fact_est_cod", primary_key: "fact_est_cod", name: "fk_trans_es_relations_estado_f1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "trans_est_nv", "estado_nota_de_venta", column: "est_not_ven_est_cod", primary_key: "not_ven_est_cod", name: "fk_trans_es_relations_estado_n1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "trans_est_nv", "estado_nota_de_venta", column: "not_ven_est_cod", primary_key: "not_ven_est_cod", name: "fk_trans_es_relations_estado_n2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "trans_est_oc", "estado_oc", column: "est_oc_est_cod", primary_key: "oc_est_cod", name: "fk_trans_es_relations_estado_o1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "trans_est_oc", "estado_oc", column: "oc_est_cod", primary_key: "oc_est_cod", name: "fk_trans_es_relations_estado_o2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "trans_est_od", "estado_od", column: "est_od_est_cod", primary_key: "od_est_cod", name: "fk_trans_es_relations_estado_o2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "trans_est_od", "estado_od", column: "od_est_cod", primary_key: "od_est_cod", name: "fk_trans_es_relations_estado_o1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "trans_est_ot", "estado_ot", column: "est_ot_est_cod", primary_key: "ot_est_cod", name: "fk_trans_es_relations_estado_o2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "trans_est_ot", "estado_ot", column: "ot_est_cod", primary_key: "ot_est_cod", name: "fk_trans_es_relations_estado_o1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "vehiculo", "modelo", column: "marca_cod", primary_key: "marca_cod", name: "fk_vehiculo_relations_modelo", on_update: :cascade, on_delete: :nullify
  add_foreign_key "vehiculo_serviciorep", "modelo", column: "marca_cod", primary_key: "marca_cod", name: "fk_vehiculo_relations_modelo", on_update: :cascade, on_delete: :cascade
  add_foreign_key "vehiculo_serviciorep", "servicio_reparacion", column: "serv_cod", primary_key: "serv_cod", name: "fk_vehiculo_relations_servicio", on_update: :cascade, on_delete: :cascade
end
