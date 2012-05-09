


class Hamlet1
	attr_accessor :name, :locations, :visit, :fightchance, :monsters
	
	def initialize(name = 'Deserted Hamlet', locations = {'house' => Abnd_house , 'tavern' => Abnd_tavern }, visit = 1, fightchance = 6, monsters = 0)
		@name = name
		@locations = locations
		@visit = visit
		@fightchance = fightchance
		@monsters = monsters
	end
	
	def look
		puts 'You see the remains of several buildings, many of which have collapsed due'
		puts 'from the weight of time and neglect. Only two buildings are left standing'
		puts 'and intact. The closest one looks to have been a tavern of sorts, judging'
		puts 'by the sign that has, surpisingly, survived. The other, you assume, was a'
		puts 'house. (Move: tavern, house)'
		puts ''
	end
	
end


class AbandHouse
	attr_accessor :name, :commands, :inventory
	
	def initialize (name = 'Abandoned House', commands = ['take', 'look', 'leave'], inventory = ['potion'])
		@name = name
		@commands = commands
		@inventory = inventory
	end
	
	def leave
		$player.position.delete_at (0)
	end
	
	def introduction
		puts 'The house looks as if it hasnt been lived in for years. Dust covers'
		puts 'the floor and furniture and cobwebs cover the walls. There is the thick'
		puts 'smell of mildew and rotting wood.'
	end
	
	def look
		puts "There is a table in the center of the room. On it, you see a potion." if self.inventory.include? 'potion'
		puts 'Dust covers everything. There looks to be nothing of value here' if self.inventory.length == 0
	end
	
end

class AbandTavern
	attr_accessor :name, :commands, :inventory, :visit
	
	def initialize (name = 'Abandoned Tavern', commands = ['take', 'look', 'leave'], inventory=[Middletonmap], visit = 0)
		@name = name
		@commands = commands
		@inventory = inventory
		@visit = visit
	end
	
	def leave
		if self.inventory.length == 0 && self.visit == 0
			puts 'As you turn to leave, you see the shadow of a figure on the door.'
			puts 'You briefly look around thinking that perhaps someone was hiding'
			puts 'as you were searching the room but see no one else. The shadow begins'
			puts 'to pull away from the door, leaving the two dimensional plane that'
			puts 'all shadows should be bound. Before you now is a feature-less form'
			puts 'that resembles a man. It begins to speak, though the voice is hollow'
			puts 'and quiet. It warns you of a power that seeks retribution for your'
			puts 'past actions. Before you are able to ask it what it means, it attacks.'
			fight(Ghoul.new('Restless Spirit'))
		end
		
		if self.inventory.length == 0 && $player.life > 0 && self.visit == 0
			puts 'The ethereal substance of the spirit dissolves in a burst of light. You'
			puts 'shield your eyes. When you look back, you see only dust in the air and'
			puts 'your shadow against the wall. You wonder what the spirit had meant and'
			puts 'try to force some form of recollection as to how you came to be in this'
			puts 'deserted hamlet. You take a look at the map fragment and notice the'
			puts 'name of the nearest town is Middleton. Whether there awaits answers for'
			puts 'you there or not, you are certain that Middleton will have more to offer'
			puts 'you than this place. You open the door and leave.'
			puts ''
			self.visit += 1
		end
		$player.position.delete_at (0)
	end
	
	def introduction
		puts 'The taverns floor creeks as you walk across it. You know this place has'
		puts 'seen better days, but looking around you arent sure if you would have'
		puts 'been a patron here even on its best.'
	end
	
	def look
		if self.inventory.include? (Middletonmap)
			puts 'You see a fragment of a map hanging on the wall. You recognize the'
			puts 'area that you are currently in, and a short distance away you see'
			puts 'what appears to be another town. You hope that towns population is'
			puts 'a little larger than this ones'
		end
		puts 'there seems to be nothing of interest here' if self.inventory.length == 0
	end
end

Abnd_tavern = AbandTavern.new
Abnd_house = AbandHouse.new
Hamletloc = [Abnd_tavern, Abnd_house]
Hamlet = Hamlet1.new 
