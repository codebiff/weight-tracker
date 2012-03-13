require "data_mapper"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/application.sqlite")

class Weighin
  include DataMapper::Resource
  
  property :id, 		  			Serial
  property :kg, 		  			Float
  property :lbs, 		  			Float
  property :stone, 					String
  property :bmi, 		  			Float
  property :created_at, 	  DateTime

  before :update, :calc
  before :create, :calc

  def calc
    self.kg = self.kg.round(1)
    self.lbs = (self.kg * 2.2).floor
    stone  = (self.lbs / 14).floor
    remain = (self.lbs.to_f % 14).floor
    self.stone = "#{stone}st #{remain}lbs"
    self.bmi = (self.kg/(1.8*1.8)).round(2)
  end

  def self.last_x_days days
    all(:created_at.gte => Time.now - (days*(60*60*24)), :order => [:created_at.desc] )
  end

end

DataMapper.finalize.auto_upgrade!

