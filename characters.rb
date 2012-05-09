require 'weapons'
require 'armour'
require 'spells'

class Character
	attr_accessor :name, :strength, :endurance, :agility, :intelligence, :life, :magic, :level, :experience, :spells, :armour, :weapon
	
	def initialize(name, strength, endurance, agility, intelligence, level, experience, weapon = '', headgear = None, feet =None, hands = None, shield = None, armour = None)
		@name = name
		@strength = strength
		@endurance = endurance
		@agility = agility
		@intelligence = intelligence
		@level = level
		@experience = experience
		@life = endurance * 10
		@magic = intelligence * 3
		@spells = ['heal']
		@armour = [headgear, feet, hands, shield, armour]
		@weapon = [weapon]
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
			puts attribute.to_s.capitalize + ': ' + value.to_s
		end
	end
	
	def stats
		puts '='*10
		self.attribute
		puts ''
		puts "Level: #{self.level.to_s}"
		puts "Health: #{self.life.to_s} / #{(self.endurance*10).to_s}"
		puts "Magic: #{self.magic.to_s} / #{(self.intelligence*3).to_s}"
		puts "Current experience: #{self.experience.to_s}"
		puts "Exp. until next level: #{((50 *self.level * self.level) - (self.experience)).to_s}"
		puts ''
	end
end

Martin = Character.new('Martin', 6, 10, 7, 5, 3, 449, Club, Hat, Leather, Shield)
require 'northshire'
