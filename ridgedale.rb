require 'monsters'

class Ridge_dale
	attr_accessor :name, :locations, :visit, :fightchance, :monsters
	
	def initialize(name = 'Ridgedale', locations = {}, visit = 0, fight_chance = 8, monsters = 1)
		@name = name
		@locations = locations
		@visit = visit
		@fightchance = fight_chance
		@monsters = monsters
	end
	
	def introduction
	end
	
	def look
	end
	
	def monster
		return Human.new('Mugger')
	end
end

class RidgedaleWeapons
end

class RidgedaleArmour
end

class RidgedaleItems
end

class RidgedaleInn
end

class GrandChurch
end

class RidgedaleTavern
end

Ridgedale = Ridge_dale.new