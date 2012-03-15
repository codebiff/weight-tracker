class WeightConverter

	attr_reader :kg, :lbs, :stone, :bmi
	attr_accessor :label

	def initialize(kg = 0)
		@kg = kg.round(1)
		convert
	end

	def lbs
		@lbs = (@kg*2.20462262185).floor
	end

	def stone
		stone  = (@lbs / 14).floor
		remain = (@lbs.to_f % 14).floor
		@stone = {:st => stone, :lbs => remain, :string => "#{stone}st #{remain}lbs"}
	end

	def bmi
		@bmi = (@kg/(1.8*1.8)).round(2)
	end

	def convert
		lbs
		stone
		bmi
		{:kg => @kg, :lbs => @lbs, :stone => @stone, :bmi => @bmi}
	end

end