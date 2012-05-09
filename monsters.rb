class Ghoul
	attr_accessor :name, :life , :strength , :experience
	
	def initialize(name = self.class, life = 30,strength = 2, experience = 15)
		@name = name
		@life = life
		@strength = strength
		@experience = experience
	end
end

class Human
	attr_accessor :name, :life, :strength, :experience
	
	def initialize(name = self.class, life = 70, strength = 4, experience = 30)
		@name = name
		@life = life
		@strength = strength
		@experience = experience
	end	
end


class Undead
	attr_accessor :name, :life, :strength, :experience
	
	def initialize(name = self.class, life = 250, strength = 12, experience = 350)
		@name = name
		@life = life
		@strength = strength
		@experience = experience
	end
end

class Spector
	attr_accessor :name, :life, :strength, :experience
	
	def initialize(name = self.class, life = 15, strength = 5, experience = 50)
		@name = name
		@life = life
		@strength = strength
		@experience = experience
	end
end

class Imp
	attr_accessor :name, :life, :strength, :experience
	
	def initialize(name = self.class, life = 80, strength = 5, experience = 80)
		@name = name
		@life = life
		@strength = strength
		@experience = experience
	end
end

class Orc
	attr_accessor :name, :life, :strength, :experience
	
	def initialize(name = self.class, life = 80, strength = 6, experience = 100)
		@name = name
		@life = life
		@strength = strength
		@experience = experience
	end
end

class Troll
	attr_accessor :name, :life, :strength, :experience
	
	def initialize(name = self.class, life = 100, strength = 8, experience = 100)
		@name = name
		@life = life
		@strength = strength
		@experience = experience
	end
end

class Siren
	attr_accessor :name, :life, :strength, :experience
	
	def initialize(name = self.class, life = 150, strength = 10, experience = 200)
		@name = name
		@life = life
		@strength = strength
		@experience = experience
	end
end

class Demon
	attr_accessor :name, :life, :strength, :experience
	
	def initialize (name = self.class, life = 200, strength = 12, experience = 300)
		@name = name
		@life = life
		@strength = strength
		@experience = experience
	end
end

#Bosses


RestlessSpirit = Ghoul.new('Restless Spirit', 50, 4, 20)
Bal = Demon.new('Bal', 1500, 250000000000000000000000000000000000000000000000000000000000000000000000, 1000)

