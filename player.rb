require 'shop'

class Player
	attr_accessor :name, :strength, :endurance, :agility, :intelligence, :life, :magic, :level, :experience, :inventory, :spells, :armour, :weapon, :gold, :area, :position, :maps, :party, :visited

	def initialize (name, strength, endurance, agility, intelligence, level = 1, experience = 0, gold = 0)
		@name = name
		@strength = strength
		@endurance = endurance
		@agility = agility
		@intelligence = intelligence
		@life = endurance * 10
		@magic = intelligence * 3
		@experience = experience
		@level = level
		@inventory = ['potion']
		@spells = ['fire']
		@weapon = []
		@armour = []
		@gold = gold
		@area = []
		@position = []
		@maps = []
		@party = []
		@visited = []
	end	
	
	def armour_rating
		initial_rating = 0
		self.armour.each do |armour|
			initial_rating += (armour.rating)
		end
		return initial_rating
	end
	
	def attribute
		{:strength => strength, :endurance => endurance, :agility => agility, :intelligence => intelligence}.each do |attribute, value|
			puts 'Your ' + attribute.to_s.capitalize + ' is ' + value.to_s
		end
	end
end



def experience(player, exp)
	player.exp += exp
end

def level_up?(player)
	if player.experience >= 50 *player.level * player.level
		player.level += 1
		player.strength += 1
		player.endurance += 1
		player.agility += 1
		player.intelligence += 1
		puts ''
		puts "#{player.name} LEVEL UP!"
		puts''
		if player == $player
			player.attribute
			player.life = player.endurance * 10
			player.magic = player.intelligence * 3
		end
	end		
end