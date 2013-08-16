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

ActiveRecord::Schema.define(:version => 20120912133556) do

  create_table "animations", :force => true do |t|
    t.string   "event"
    t.string   "type"
    t.integer  "length"
    t.integer  "delay",              :default => 0
    t.float    "interpolationParam"
    t.string   "interpolation"
    t.boolean  "persist",            :default => false
    t.boolean  "repeat",             :default => false
    t.float    "from"
    t.float    "to"
    t.float    "axisX"
    t.float    "axisY"
    t.float    "axisZ"
    t.integer  "animatable_id"
    t.string   "animatable_type"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "hotspot_objects", :force => true do |t|
    t.string   "contentType"
    t.string   "hotspot_object_url"
    t.float    "size"
    t.string   "reducedUrl"
    t.string   "previewImage"
    t.boolean  "rotateRel"
    t.float    "rotateAxisX"
    t.float    "rotateAxisY"
    t.float    "rotateAxisZ"
    t.float    "rotateAngle"
    t.float    "translateX"
    t.float    "translateY"
    t.float    "translateZ"
    t.float    "scale"
    t.integer  "hotspot_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "hotspots", :force => true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.float    "altitude"
    t.string   "title"
    t.string   "description"
    t.string   "footnote"
    t.string   "image_url"
    t.boolean  "showSmallBiw",      :default => true
    t.boolean  "showBiwOnClick",    :default => true
    t.string   "biwStyle",          :default => "classic"
    t.string   "ciwIcon_url"
    t.integer  "ciwIcon_type"
    t.boolean  "inFocus",           :default => false
    t.integer  "layer_id"
    t.integer  "hotspot_object_id"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "interactions", :force => true do |t|
    t.string   "uri"
    t.string   "label"
    t.string   "contentType"
    t.string   "method",               :default => "GET"
    t.string   "params"
    t.integer  "activityType",         :default => 0
    t.boolean  "showActivity",         :default => true
    t.string   "activityMessage"
    t.boolean  "closeBiw",             :default => false
    t.integer  "autoTriggerRange"
    t.boolean  "autoTrigger",          :default => false
    t.boolean  "autoTriggerOnly",      :default => false
    t.integer  "interactionable_id"
    t.string   "interactionable_type"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "layers", :force => true do |t|
    t.string   "name"
    t.string   "layer_type"
    t.integer  "radius"
    t.integer  "refreshInterval", :default => 300
    t.integer  "refreshDistance", :default => 100
    t.boolean  "fullRefresh",     :default => true
    t.string   "showMessage"
    t.string   "title"
    t.string   "description"
    t.string   "iconUrl"
    t.string   "biwStyle"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
