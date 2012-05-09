Commands_outside = ['use','inventory', 'equip', 'move', 'travel', 'look', 'stats', 'party']
Commands_fight = ['use','cast','hit','inventory']

require 'hamlet'
require 'middleton'
require 'denofshadows'
require 'books'
def inventory(player = $player)
	invtry = []
	maplist = []
	player.maps.each do |map|
		maplist << map.name
	end
	player.inventory.each do |item|
		invtry << item unless (item.class == Weapon) || (item.class == Armour) || (item.class == Keyitem) || (item.class == Spellbook)
		invtry << item.name if (item.class == Weapon) || (item.class == Armour) || (item.class == Keyitem) || (item.class == Spellbook)
	end
	puts '='*10
	puts "Your maps".center(10)
	puts "="*10
	puts maplist
	puts '='*10
	puts 'your inventory'.center(10)
	puts '='*10
	puts invtry.sort!
	puts '='*10
	puts ''
end

def party
	puts '='*10
	puts 'party'.center(10)
	puts '='*10
	puts 'Your party is empty' if $player.party.length == 0
	$player.party.each do |char|
		puts char.name
		puts char.stats
	end
	puts '='*10
end


def stats
	puts ''
	puts '='*10
	puts '='*10
	puts ''
	puts 'Attributes'.center(10)
	puts '='*10
	$player.attribute
	puts ''
	puts "Level: #{$player.level.to_s}"
	puts "Health: #{$player.life.to_s} / #{($player.endurance*10).to_s}"
	puts "Magic: #{$player.magic.to_s} / #{($player.intelligence*3).to_s}"
	puts "Current experience: #{$player.experience.to_s}"
	puts "Exp. until next level: #{((50 *$player.level * $player.level) - ($player.experience)).to_s}"
	puts "Gold: #{$player.gold.to_s}"
	puts ''
	puts 'Spells'.center(10)
	puts '='*10
	puts $player.spells
	puts ''
	puts '='*10
	puts '='*10
	puts ''
end



def equip (player = $player)
	invtry = []
	player.inventory.each do |item|
		invtry << item.name if (item.class == Weapon) || (item.class == Armour)
	end
	puts ''
	puts ''
	puts 'what would you like to equip?'
	puts "('done' to return)"
	puts ''
	puts invtry
	response = ''
	while true
		puts 'Current Equipment:'.center(10)
		puts "="*10
		puts "Weapon: #{player.weapon[0].name.capitalize}" unless player.weapon.length == 0
		puts "Weapon: empty" if player.weapon.length == 0
		player.armour.each do |article|
			puts "#{(article.type).capitalize}: #{article.name.capitalize}"
		end
		puts "="*10
		puts ''
		response = gets.chomp
		break if response == 'done'
		if invtry.include? response
			if Weapon_id.has_key? response
				player.weapon.delete_at 0 unless player.weapon.length == 0
				player.weapon << Weapon_id[response]
			elsif Armour_id.has_key? response
				player.armour.each do |armour|
					player.armour.delete_at (player.armour.index(armour)) if armour.type == Armour_id[response].type
				end
				player.armour << Armour_id[response]
			end
		else
			puts 'You do not have that item'
		end
		puts ''
		puts 'what else would you like to equip?'
	end

end


def use(inventory = $player.inventory)
	puts 'what would you like to use'
	g =gets.chomp
	puts 'no such item in inventory' unless (inventory.include? g)
	if inventory.include? g
		send(g) unless Spellbook_id.has_key? g
		$player.spells << Spellbook_id[g].spell if Spellbook_id.has_key? g
		puts "Learned #{Spellbook_id[g].spell.to_s}" if Spellbook_id.has_key? g
		inventory.delete_at(inventory.index(g))
	end
end

def cast(spell_book = $player.spells)
	puts 'what would you like to cast?'
	spell =gets.chomp
	puts 'You do not know that spell' unless spell_book.include? spell
	if spell_book.include? spell
		send(spell)
	end
end

def hit(offense = $player, defense = @monster)
	if offense.weapon.length == 0
		bonus = 0
	else
		bonus = offense.weapon[0].damage
	end
	roll = offense.agility * (rand (6) + 1)
	defense.life -= (offense.strength * (rand(6) + 1)) + bonus if roll >= 10 && defense.class != Spector
	puts ''
	if roll < 10
		puts 'Your clumsy swing misses!' if offense == $player
		puts "#{offense.name}'s swing misses!" unless offense == $player
	elsif defense.class == Spector
		puts 'The attack has no effect' if offense == $player
		puts "#{offense.name}'s attack has no effect" unless offense == $player
	else 
		puts 'You land a blow square on the monsters head' if offense == $player
		puts "#{offense.name}'s lands a blow square on the monsters head" unless offense == $player
	end
	puts ''
end

def move
	puts 'move where?'
	puts "('done' to return)"
	response = ''
	while true
		response = gets.chomp
		break if response == 'done'
		if $player.area[0].locations.has_key? response
			$player.position << $player.area[0].locations[response]
			roll = (rand(10) + 1)
			if (roll >= $player.area[0].fightchance) && ($player.area[0].monsters == 0)
				fight
			elsif	(roll >= $player.area[0].fightchance) && ($player.area[0].monsters != 0)
				fight($player.area[0].monster)
			end
			break
		end
		puts 'please enter a valid location' unless $player.area[0].locations.has_key? response
	end
	puts "You are in #{$player.position[0].name}" unless $player.position.length == 0
	puts 'You are standing outside' if $player.position.length == 0
	puts ''
	puts $player.position[0].introduction unless $player.position.length == 0
end

def travel
	puts 'Travel where?'
	puts "('done' to return)"
	response = ''
	while true
		response = gets.chomp
		break if response == 'done'
		$player.maps.each do |map|
			if map.name == response
				roll1 = (rand(10) + 1)
				roll2 = (rand(10) + 1)
				roll3 = (rand(10) + 1)
				fight if roll1 > 4
				break if $player.life <= 0
				fight if roll2 > 4
				break if $player.life <= 0
				fight if roll3 > 4
				break if $player.life <= 0
				puts map.location.introduction
				map.location.visit += 1 if map.location.visit == 0
				$player.area.delete_at(0)
				$player.area << map.location
			end
		end
		break
	end
	puts "You are in #{$player.area[0].name}" unless $player.life <= 0
	puts ''
end

def sleep
	puts 'rest well'
	puts ''
	timer
	puts 'zZz'
	timer
	puts 'ZzZ'
	timer
	puts 'zZz'
	timer
	puts ''
	$player.life = ($player.endurance * 10)
	$player.magic = ($player.intelligence * 3)
	$player.party.each do |char|
		char.life = (char.endurance * 10)
		char.magic = (char.intelligence * 3)
	end
	puts 'You are well rested!'
	File.open("games/#{$player.name}/#{$player.name}", "w+") do |file|
		Marshal.dump($player, file)
	end
	
	$player.party.each do |char|
		File.open("games/#{$player.name}/#{char.name}", "w+") do |file|
			Marshal.dump(char, file)
		end
	end	
	
	$player.maps.each do |area|
		File.open("games/#{$player.name}/#{area.name}", "w+") do |file|
			Marshal.dump(area.location, file)
		end
	end
	
	$player.visited.each do |location|
		location.each do |place|
			File.open("games/#{$player.name}/#{place.name}", "w+") do |file|
				Marshal.dump(place, file)
			end
		end
	end

end

def take
	puts 'what would you like to take?'
	response = ''
	while true
		response = gets.chomp
		break if (response == 'done' || response == 'nothing')
		if $player.position[0].inventory.include? response
			$player.inventory << response if Items.include? response
			$player.inventory << Weapon_id[response] if Weapon_id.has_key? response
			$player.inventory << Armour_id[response] if Armour_id.has_key? response
			$player.inventory << Key_Items[response] if Key_Items.has_key? response
			$player.inventory << response if Spellbook_id.has_key? response
			$player.gold += response.amount if response == 'coin purse'
			$player.position[0].inventory.delete_at($player.position[0].inventory.index(response))
			puts "taken #{response}"
			break
		elsif response == 'map'
			map = 0
			$player.position[0].inventory.each do |item|
				if item.class == Maps
					map += 1
					$player.maps << item 
					$player.position[0].inventory.delete_at($player.position[0].inventory.index(item))
					puts "taken #{response}"
				end
			end
			puts 'There are no maps here' if map == 0
			break
		elsif response == 'purse'
			purse = 0
			$player.position[0].inventory.each do |item|
				if item.class == Purse
					purse += 1
					$player.gold += item.amount
					$player.position[0].inventory.delete_at($player.position[0].inventory.index(item))
					puts "taken #{item.amount} gold"
				end
			end
			puts 'There is no coin purse here' if purse == 0
			break
		else
			puts 'there is not an item here by that name'
		end
	end
end

def look
	if $player.position.length == 0
		puts $player.area[0].look
	end
end

def loot
	roll_1 =(1 + rand(6))
	roll_2 =(1 + rand(6))
	if roll_1 + roll_2 >= 8
		roll_3 = rand(3)
		if roll_3 == 0
			item = Items[rand(4)]
			$player.inventory << item
			puts 'recieved ' + item.to_s
		elsif roll_3 == 1
			item = Items[rand(4)]
			$player.inventory << item
			puts 'recieved ' + item.to_s
		elsif roll_3 == 2
			item = Items[rand(4)]
			$player.inventory << item
			puts 'recieved ' + item.to_s
		end
	end
end
