require 'modules'
require 'monsters'
require 'characters'

class Northshre
	attr_accessor :name, :locations, :visit, :fightchance, :monsters
	
	def initialize(name = 'Northshire', locations = {'inn' => NorthshireInn, 'shop' => NorthshireShop, 'tavern' => NorthshireTavern, 'house' => NorthshireHouse}, visit = 0, fight_chance = 12, monsters = 1)
		@name = name
		@locations = locations
		@visit = visit
		@fightchance = fight_chance
		@monsters = monsters
	end
	
	def introduction
		puts "You come upon a small town. The buildings here, though seemingly in full"
		puts "operation, have not been maintained well. You suspect this town doesnt get much"
		puts "trade or travellers. The people of this town seem to move slugishly, as if it"
		puts "were with great reluctance that they arive to wherever they are heading. The"
		puts "town itself had a depressed air about it and you find yourself experiencing an"
		puts "intense meloncholy merely by being there. You hope your time in this town will"
		puts "be short as you set off to discover what the town holds"
	end
	
	def look
		puts "The lack of care and maintanance of the buildings immediatly stand out to you,"
		puts "but, inspite of this, their functions are easily recognizable. Along the"
		puts "gravelled road is a row of buildings. Of those buildings you notice a shop and"
		puts "a tavern right next to it. Further down the road is you notice an inn."
		puts "(shop, tavern, inn)"
	end
	
	def monster
		return Human.new("Mugger")
	end
end

class Northshire_inn
		attr_accessor :name, :commands
	
	include Inn
	
	def initialize(name = 'Northshire Inn', commands = ['leave', 'look', 'rest'])
		@name = name
		@commands = commands
	end
	
	def leave
		$player.position.delete_at (0)
	end
	
	def introduction
		puts 'You walk into the inn. The interior is just as bleak as the rest of the town.'
		puts "You see the innkeeper - a sad looking man - who asks if you would like a room."
		puts "(rest)"
	end
	
	def look
		puts 'You see the innkeeper behind a wooden counter. Their is little light here, but'
		puts 'enough to see that the walls are bare. There is nothing of any interest here.'
	end
end

class Northshire_shop
	attr_accessor :name, :commands ,:items, :weapons, :spells, :armour
	
	include Shop
	
	def initialize(name = 'Northshire Shop', commands = ['buy', 'sell','leave'], items = ['potion', 'mana'], weapons = ['club'], spells = ['holy', 'heal'], armour = ['hat', 'wicker shield', 'leather gloves', 'chain helmet'])
		@name = name
		@items = items
		@weapons = weapons
		@spells = spells
		@armour = armour
		@commands = commands
	end
	
	def introduction
		puts 'A man sits behind the counter. He offers no welcome or assitance, but just'
		puts 'looks as you stand there.'
	end
	
	def look
		puts 'The shops interior matches the depressing nature of the whole town. There are'
		puts 'not many items that you can see, and what you can see is not very impressive.'
		puts '(buy or sell)'
	end
	
	def leave
		$player.position.delete_at (0)
	end
end

class Northshire_tavern
	attr_accessor :name, :commands, :inventory
	
	def initialize(name = 'Northshire Tavern', commands = ['leave', 'talk'], inventory = [Martin])
		@name = name
		@commands = commands
		@inventory = inventory
	end
	
	def introduction
		puts 'You walk into the tavern, noticing that there are very few patrons. The bar,'
		puts 'behind which you see a rough looking man with sunken eyes, is splintered and'
		puts 'faded. One man, off in the corner, stares at you.'
		unless self.inventory.length == 0
			puts self.inventory[0].name
		end
	end
	
	
	def leave
		$player.position.delete_at (0)
	end
	
	def talk
		if self.inventory.include? (Martin)
			$player.party << Martin
			self.inventory.delete_at(self.inventory.index(Martin))
			puts ''
			puts 'Martin joins your party.'
		else
			puts 'There is no one here worth talking to'
		end
	end
	
end

class Northshire_house
	attr_accessor :name, :commands, :visit
	
	def initialize (name = 'Northshire House', commands = ['leave'], visit = 0)
		@name = name
		@commands = commands
		@visit = visit
	end
	
	def introduction
		unless ($player.party.include? Martin) || (self.visit != 0)
			puts self.visit
			self.leave
			puts 'You cannot enter'
		else
			self.visit += 1 if self.visit == 0
			puts 'you are here'
		end
	end
	
	def leave
		$player.position.delete_at (0)
	end
end

NorthshireHouse = Northshire_house.new
NorthshireTavern = Northshire_tavern.new
NorthshireShop = Northshire_shop.new
NorthshireInn = Northshire_inn.new
Northshire = Northshre.new
