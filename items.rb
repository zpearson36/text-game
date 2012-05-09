require 'player'


def potion(user = $player)
	user.life += 25
	if user.life > user.endurance * 10
		user.life = user.endurance * 10
	end
end

def xpotion(user = $player)
	user.life += 75
	if user.life > user.endurance * 10
		user.life = user.endurance * 10
	end
end

def rejuvinate(user = $player)
	user.life = user.endurance * 10
	user.magic = user.intelligence * 3
	if user.life > user.endurance * 10
		user.life = user.endurance * 10
	end
	if user.magic > user.intelligence * 3
		user.magic = user.intelligence * 3
	end
end

def mana(user = $player)
	user.magic += 15
	if user.magic > user.intelligence * 3
		user.magic = user.intelligence * 3
	end
end

class Purse
	attr_accessor :amount
	
	def initialize(amount)
		@amount = amount
	end
end


#key items

class Keyitem
	attr_accessor :name
	
	def initialize(name)
		@name = name
	end
end

Book_of_mysteries = Keyitem.new('book of mysteries')
Key_Items = {'book of mysteries' => Book_of_mysteries}

Items_price = {'potion' => 50, 'mana' => 70, 'rejuvinate' => 350, 'xpotion' => 150}
Items = ['potion', 'mana', 'rejuvinate', 'xpotion']