require 'items'
class DenoShadow
	attr_accessor :name, :locations, :visit, :fightchance, :monsters
	
	def initialize (name = 'Den of Shadows', locations={'east' => DenEast, 'west' => DenWest, 'northeast' => DenNortheast, 'north' => DenNorth}, visit = 0, fightchance = 3, monsters = 0)
		@name = name
		@locations = locations
		@visit = visit
		@fightchance = fightchance
		@monsters = monsters
	end
	
	def introduction
		if self.visit == 0
			puts 'You find yourself at the mouth of a large cave. The wind is'
			puts 'blowing in such a manner that a low, howling noise can be heard.'
			puts 'You notice fresh foot prints on the ground and expect this might'
			puts 'be more difficult than you had anticipated. However, having come'
			puts 'this far, you see no point in turning back and decided to head'
			puts 'into the cave.'
			$player.visited << Den_of_Shadowsloc
		end
		
		unless self.visit == 0
			puts 'You find yourself at the mouth of a large cave. The wind is'
			puts 'blowing in such a manner that a low, howling noise can be heard.'
		end
	end

	def look
		puts 'You find yourself in a large cavern, dome-shaped cavern. the ceiling'
		puts 'is high and you notice that it is not a natural formation. Small,'
		puts 'discreet designs can be seen repeating across it. There are four'
		puts 'corridors branching from this cavern. You see a light flickering from'
		puts 'the northern most pathway. (north, east, west, northeast)'
	end
	
	
end

class Den_north
	attr_accessor :name, :commands, :inventory, :visit
	
	def initialize (name = 'northern cavern', commands = ['leave', 'take', 'look'], inventory = ['book of mysteries', 'book of heal', Purse.new(150)])
		@name = name
		@commands = commands
		@inventory = inventory
		@visit = visit
	end
	
	def introduction
		if self.inventory.include?('book of mysteries')
			puts 'As you walk into the cavern, you see a what looks to be a thin man'
			puts 'huddled in the corner. He is skinny to the point of starvation.'
			puts 'As you look, you begin to notice that certain characteristics are'
			puts 'distinctly non-human - his spine protudes much more than a mans'
			puts 'should, even at the point of starvation, and comes to a sharp point'
			puts 'near the neck. His feet are long and boney and his toe-nails are'
			puts 'rounded like those of a hawk. You begin to reconsider finish this'
			puts 'as you are no longer sure what you have gotten into, but before you'
			puts 'are able to turn and leave, the stands, turns to you, lunges at you.'
			puts 'He stops short and looks as though he recognizes you. In a shrill,'
			puts "raspy voice, he claims to know you. He demands that you tell him"
			puts 'what you are doing there, but without pausing for you to reply says'
			puts 'that you should not be there. Inspite of the differences in'
			puts 'appearance, his facial characteristics are close enough to human for'
			puts 'you to recognize fear and worry in his expression. You ask him how'
			puts 'he knows you, but his expression lightens and he then begins to'
			puts "laugh. He stands up straight and begins to speak. 'You have yet to"
			puts "remember, but I shall see to it that you do not have get the chance"
			puts "to.' His smile turns to a scowl and he attacks."
			fight(Demon.new('Belial', 150, 5, 40))
			puts ''
			puts 'The creatures body drops to the floor. He now lay in a pool of his own'
			puts 'blood. You stare at his face, attempting to recall any memory of having'
			puts 'met him before. However, you cannot. In the corner you see you see a'
			puts 'book. You pick it up, noticing the obvious age by the worn out binding.'
			puts 'You turn it over and feel your heart rate jump as you look at the symbol'
			puts 'inscribed on the cover. It is the same symbol as the one on the back of'
			puts 'your hand. You almost drop the book as your hand starts to burn with an'
			puts 'intensity that you have not before felt. You flip through the book but'
			puts 'soon realize that it is written in a language you have never before seen,'
			puts 'but notice that the characters are very similar to what has been carved into'
			puts 'circle on the back of your hand. You decide that the man in the church'
			puts 'may know more about your situation than you thought. You put the book into'
			puts 'your pack and prepare to journey back.'
			$player.inventory << 'book of mysteries'
			self.inventory.delete_at(self.inventory.index('book of mysteries').to_i)
		end
		
		unless self.inventory.include? Book_of_mysteries
			puts 'You step over the body of the creature you have slain. Its unusual featurs'
			puts 'still unsettle you.'
		end
	end
	
	def look
		coin = 0
		self.inventory.each do |item|
			coin += 1 if item.class == Purse
		end
		puts "There is a purse full of coins lying on the floor. (purse)" unless coin == 0
		puts "You see a book laying near the wall with the word 'heal' printed on it.(book of heal)" if self.inventory.include? 'book of heal'
		puts 'The den is cold and dark. There is nothing of interest here.' if self.inventory.length == 0
	end
	
	def leave
		$player.position.delete_at (0)
	end
end

class Den_northeast
	attr_accessor :name, :commands
	
	def initialize (name = 'northeastern cavern', commands = ['sleep', 'look', 'leave'])
		@name = name
		@commands = commands
	end
	
	def introduction
		puts 'You walk into the cavern. It is cold and smells of mildew'
	end
	
	def look
		puts 'You see a crudely made burlap sleeping area. (sleep)'
	end
	
	def leave
		$player.position.delete_at (0)
	end	
	
end

class Den_east
	attr_accessor :name, :commands, :inventory
	
	def initialize(name = 'eastern cavern', commands = ['look', 'take', 'leave'], inventory = ['club', 'wicker shield'])
		@name = name
		@commands = commands
		@inventory = inventory
	end
	
	def introduction
		puts 'You walk into the small cavern.'
	end
	
	
	def look
		puts 'On the floor before you lies a poorly made wicker shield.' if self.inventory.include? 'wicker shield'
		puts 'Leaning against the far wall is a crude looking club.' if self.inventory.include? 'club'
		puts 'The room is small and damp. There is nothing here of any interest.' if self.inventory.length == 0
	end
	
	def leave
		$player.position.delete_at (0)
	end	
end

class Den_west
	attr_accessor :name, :commands, :inventory
	
	def initialize (name = 'western cavern', commands = ['look', 'take', 'leave'], inventory = ['potion', 'potion'])
		@name = name
		@commands = commands
		@inventory = inventory
	end
	
	def introduction
		puts 'Light from your torch glistens on the wet walls of the cavern.'
	end
	
	def look
		repeats = Hash.new(0)
		self.inventory.each do |item|
			repeats[item] += 1
		end
		
		puts 'You see some potions lying on the floor against the wall.' if self.inventory.include? 'potion'
		repeats.each {|item, number| puts "(#{item} x #{number})"} if self.inventory.include? 'potion'
		puts 'There is nothing else that you find interesting here.' if self.inventory.length == 0
	end
	
	def leave
		$player.position.delete_at (0)
	end
	
end

DenNorth = Den_north.new
DenNortheast = Den_northeast.new
DenWest = Den_west.new
DenEast = Den_east.new
Den_of_Shadowsloc = [DenNorth, DenNortheast, DenWest, DenEast]
Den_of_Shadows = DenoShadow.new



