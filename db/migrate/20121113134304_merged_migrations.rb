class MergedMigrations < ActiveRecord::Migration
  def up
    create_table "analyses", :force => true do |t|
      t.string   "name"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  
    create_table "areas", :force => true do |t|
      t.string   "name"
      t.boolean  "is_summary",  :default => false, :null => false
      t.integer  "analysis_id",                    :null => false
      t.datetime "created_at",                     :null => false
      t.datetime "updated_at",                     :null => false
    end
  
    create_table "calculated_stats", :force => true do |t|
      t.integer  "calculation_id"
      t.integer  "area_id"
      t.float    "value"
      t.datetime "created_at",     :null => false
      t.datetime "updated_at",     :null => false
    end
  
    create_table "calculations", :force => true do |t|
      t.string   "display_name"
      t.integer  "operation_id"
      t.integer  "layer_id"
      t.datetime "created_at",   :null => false
      t.datetime "updated_at",   :null => false
    end
  
    create_table "layers", :force => true do |t|
      t.string   "name"
      t.integer  "type"
      t.string   "url"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  
    create_table "operations", :force => true do |t|
      t.string   "name"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  
    create_table "polygons", :force => true do |t|
      t.integer  "area_id"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
      t.text     "geometry"
    end
  
    create_table "tenant_layers", :force => true do |t|
      t.integer  "layer_id"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  
    create_table "tenants", :force => true do |t|
      t.string   "name"
      t.string   "subdomain"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  end

  def down
    drop_table :analyses
    drop_table :areas
    drop_table :calculated_stats
    drop_table :calculations
    drop_table :layers
    drop_table :operations
    drop_table :polygons
    drop_table :tenant_layers
    drop_table :tenants
  end
end
