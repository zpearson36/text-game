require 'spells'
require 'items'
require 'armour'
require 'weapons'
require 'modules'
require 'maps'

class Middle_ton
	attr_accessor :name, :locations, :visit, :fightchance, :monsters
	
	def initialize(name = 'Middleton', locations = {'inn' => Mddltn_inn, 'shop' => Mddltn_shop, 'church' => Mddltn_church}, visit = 0, fight_chance = 11, monsters = 0)
		@name = name
		@locations = locations
		@visit = visit
		@fightchance = fight_chance
		@monsters = monsters
	end
	
	def introduction
		if self.visit == 0
			puts 'You come up to the edge of a small farm. You see a farmer on the other side'
			puts 'behind an Ox pulling a plow. You walk past it, smelling the freshly tilled'
			puts 'earth. A short distance passed the farm, you see a few small cottages and'
			puts 'catch a brief smell of someone cooking. Strangely, the smell is familiar'
			puts 'and you feel the sadness of having lost something dear to you. You wonder'
			puts 'if you had once led a life of simple luxury like you imagine the people'
			puts 'in the cottages do, but no memory of any such life comes to mind. The'
			puts 'scar on you hand begins to burn again and you decide to just continue'
			puts 'on to Middleton.'
			puts ''
			puts 'Just passed the cottages you arrive at a town. You see several buildings'
			puts 'and make note of the fact that all of them look nice and well cared for -'
			puts 'a nice contrast from the place you have just come. Knowing that there are'
			puts 'living souls here is reassuring. You see a sign as you pass the first building.'
			puts "It reads 'Middleton'"
			puts''
			$player.visited << Middletonloc			
		end
		
		if ($player.inventory.include? 'book of mysteries') && (visit == 1)
			$player.maps << Northshiremap
			self.visit += 1
			puts "As you walk into town, a stranger approaches you. The mans eyes are dark and"
			puts "sunken and his face is thin. When he speaks, he does so in a raspy whisper. He"
			puts "calls himself your friend and he warns you of the treachery the church is"
			puts "capable of. He hands you a map and tells you to be wary when dealing with the"
			puts "church. Just as quickly as he had approached, he disappears into the crowd at"
			puts "the center of town. You glance down at the map, noting that the towns name  is"
			puts "Northshire, and wonder what could await you there."
			puts ''
			puts "northshire map added"
		end
		
	end
	
	def look
		puts 'You see people walking to and from the various buildings in the town though'
		puts 'none of them seem to be in a particular hurry. You conclude that this must'
		puts 'be a rather comfortable town. You see what looks to be a shop, and across from'
		puts 'that an inn. Down the street from them you see a building with a cross on the'
		puts 'roof - a church. None of the other building seem to be of interest.'
		puts '(move: inn, shop, church)'
		puts ''
	end
	
end

	

class MddltnInn
	attr_accessor :name, :commands
	
	include Inn
	
	def initialize(name = 'Middleton Inn', commands = ['leave', 'look', 'rest'])
		@name = name
		@commands = commands
	end
	
	def leave
		$player.position.delete_at (0)
	end
	
	def introduction
		puts 'You walk into the inn. The Innkeeper looks at you and offers her welcome and'
		'asks if she can offer you a room. (rest)'
	end
	
	def look
		puts 'You see the innkeeper behind a wooden counter. Various paintings of landscapes'
		puts 'Hang from the wall and there is a large vase filled with some colorful flowers'
		puts 'off in the corner. There is nothing of any interest here.'
	end
end

class Middleton_shop
	attr_accessor :name, :commands ,:items, :weapons, :spells, :armour
	
	include Shop
	
	def initialize(name = 'Middleton Shop', commands = ['buy', 'sell','leave'], items = ['potion'], weapons = ['club', 'sword'], spells = ['holy'], armour = ['hat', 'leather vest', 'leather shoes'])
		@name = name
		@items = items
		@weapons = weapons
		@spells = spells
		@armour = armour
		@commands = commands
	end
	
	def introduction
		puts 'You walk into the shop to see an older man sitting behind a wooden counter.'
		puts 'He stands up and welcomes you. After a moment, he asks you if he can help you'
		puts 'with anything. (buy or sell)'
	end
	
	def look
		puts 'You see several types of objects hanging on the wall - tools, you assume, for'
		puts 'the farmers. In a corner behind the desk, you see a few options for things you'
		puts 'might find useful - a club, a few pieces of armour and some potions. A peaceful'
		puts 'town like this obviously doesnt have much need for a large defensive stock.' 
		puts 'These items are apparently being gaurded closely so there is nothing you can'
		puts 'take.'
	end
	
	def leave
		$player.position.delete_at (0)
	end
end

class Middleton_church
	attr_accessor :name, :commands, :inventory, :people, :seen, :spoken
	
	def initialize(name = 'Middleton Church', commands = ['look', 'leave', 'talk'], inventory = [DenofShadowsmap], people = ['priest'], seen = 0, spoken = 0)
		@name = name
		@commands = commands
		@inventory = inventory
		@people = people
		@seen = seen
		@spoken = spoken
	end
	
	def introduction
		puts 'The large doors slam behind you as you walk into the church. The interior is'
		puts 'much larger than you would have expected judging from the outside. As you walk'
		puts 'down the isle, your footsteps echo throughout the room. The silence of this'
		puts 'place is beginning to unsettle you.'
	end
	
	def look
		unless self.seen > 0
			puts 'You look around the church and are immediately taken aback by the luxury of the'
			puts "interior. It's suprising to see such a modest looking town having such a lavish"
			puts 'building. The pillars, wich are lined to make two rows that line the walkway'
			puts 'between the pews, have gold engravings of, whom you assume to be, the idols of'
			puts 'the region. The walkway itself is made of marble and the pews of polished oak.'
			puts 'At the head of the walkway is a podium, behind which is a large golden statue'
			puts 'of a man with his limbs tied and stretched as if he were on a rack. The chest'
			puts 'is opened and his ribs are exposed. The mans face is contorted in agony.'
			puts 'Suddenly being in a town with other people is not so reassuring.'
			puts ''
			self.seen += 1
		end
		unless $player.maps.include? DenofShadowsmap
			puts 'You see a man in front knealing infront of the large statue. He turns to you'
			puts 'and stands. (talk)'
		end
		if $player.maps.include? DenofShadowsmap && ((self.inventory.include? Book_of_mysteries) == false)
			puts 'You see the man waiting, somewhat impatiently, near the entrance of the church.(talk)'
		end
		
		if self.inventory.include? Book_of_mysteries
			puts 'You see the man standing quietly near the large statue.(talk)'
		end
		
	end
	
	def talk
		if self.inventory.include? DenofShadowsmap
			puts 'You walk up to the man. He is small and frail and his face is lined as though'
			puts 'he spends his days in worry. He welcomes you to the church but his expression'
			puts 'is one of great sorrow and trouble. You ask him if he is ok but he only looks'
			puts 'away. He then tells you that a great relic of their champion has been stolen -'
			puts 'a book of great importance to his peoples history. He motions to the statue at'
			puts 'his mention of the champion. He then turns to you and asks you, in a hurried'
			puts 'and panicked voice, if you would be willing to retrieve the book. He has ahold'
			puts 'of your shoulder and begins pleading insisting that it will be made worth your'
			puts 'while. Unsure of how else to leave this situation, you agree to help. His'
			puts 'expression lightens immediatly as he hands you a map of the location of the book'
			$player.maps << DenofShadowsmap
			self.inventory.delete_at(self.inventory.index(DenofShadowsmap))
			puts ''
			puts 'map to den of shadows added'
			puts ''
		end
		
		unless ($player.inventory.include?('book of mysteries')) || (self.inventory.include? ('book of mysteries'))
			puts "The man: 'Please return immediatly once you have obtained the book.'"
		end
		
		
		if $player.inventory.include? 'book of mysteries'
			puts "The man's disposition changes greatly when you present to him the book. He"
			puts "quickly grabs it, taking it from your hands almost violently and hugs it"
			puts "closely to his chest. You ask him about the symbol on the cover of it and it"
			puts "takes a minute before he replies. The man takes a deep breath before asking"
			puts "you of your origins and how you came to be in this town. After telling him of"
			puts "how you awoke in the deserted hamlet, he tells you that the symbol on the book"
			puts "- and the one on your hand - is the sign of their champion and that the script"
			puts "within the circle is the name of their champion. He goes on to say that only a"
			puts "few are allowed to know that name and he is not one of them. He hands you a map"
			puts "of a distant city and a letter. The city, he tells you, is the lands capitol"
			puts "and is home of the central church. There, you must speak with the arch"
			puts "counsiler, who is the head of the church, and give him the letter."
			puts ''
			puts 'Ridgedale map added'
			$player.maps << Ridgedalemap
			self.inventory << 'book of mysteries'
			$player.inventory.delete_at($player.inventory.index('book of mysteries'))
		end
		
		if self.inventory.include? 'book of mysteries'
			puts "The Man: The arch counsiler can offer you more than what I can. I wish you well"
			puts "on your journey."
		end
		
	end
	
	def leave
		$player.position.delete_at (0)
	end
end



Mddltn_church = Middleton_church.new
Mddltn_inn = MddltnInn.new
Mddltn_shop = Middleton_shop.new
Middletonloc = [Middleton_church]
Middleton = Middle_ton.new
