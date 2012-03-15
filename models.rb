require "data_mapper"

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/db/application.sqlite")

class Weighin
  include DataMapper::Resource
  
  property :id, 		  			Serial
  property :kg, 		  			Float
  property :created_at, 	  Date

  def self.last_x_days days
    all(:created_at.gte => Time.now - (days*(60*60*24)), :order => [:created_at.desc] )
  end

end

DataMapper.finalize.auto_upgrade!

