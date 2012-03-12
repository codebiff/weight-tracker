require "data_mapper"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/application.sqlite")

class WeightStore
  include DataMapper::Resource
  
  property :id, 		  			Serial
  property :kg, 		  			Float
  property :lbs, 		  			Float
  property :stone, 					String
  property :bmi, 		  			Float
  property :created_at, 	  DateTime

  after :create, :update do
  	
  	self.lbs = (self.kg * 2.2).floor
  	stone  = (self.lbs / 14).floor
  	remain = (self.lbs.to_f % 14).floor
  	self.stone = "#{stone}st #{remain}lbs"
  	self.bmi = (self.kg/(1.8*1.8)).round(2)

  end

  def last_7_days
    
  end

end

class Setting
  include DataMapper::Resource

  property :id,             Serial
  property :setting_key,    String
  property :setting_value,  String
end

DataMapper.finalize.auto_upgrade!

