require 'commands'
require 'timer'
require 'monsters'

def rand_monster
	roll = (rand($player.level * 2) + 1)
	return Ghoul.new if roll <= 2
	return Spector.new if roll > 2 && roll <= 4
	return Imp.new if roll > 4 && roll <= 6
	return Orc.new if roll > 6 && roll <= 8
	return Troll.new if roll > 8 && roll <= 10
	return Siren.new if roll > 10 && roll <= 12
	return Undead.new if roll > 12
end


def fight(monster = rand_monster, player = $player)
	@monster = monster
	action = ''
	puts''
	puts @monster.name.to_s + ' Approaches'
	puts ''
	
	puts @monster.name.to_s + "'s life is " + @monster.life.to_s
	puts 'Your life is ' + player.life.to_s
	puts 'You have ' + player.magic.to_s + ' magic'
	puts''
	until @monster.life <= 0
		break if player.life <= 0
		puts''
		timer
		action = ''
		while true
			puts 'What would you like to do?'
			action = gets.chomp
			if Commands_fight.include? action
				send(action)
				break unless action == 'inventory'
			else puts 'please enter a recognized command'
			end
		end
		break if @monster.life <= 0
		timer
		if player.party.length > 0
			player.party.each do |char|
				if (char.life != 0) && (char.life < (char.endurance*2)) && (char.magic >= char.intelligence)
					puts "#{char.name} casts heal."
					heal(char)
					puts ''
				elsif char.life == 0
					break
				else
					hit(char, @monster)
				end
			end
		end
		break if @monster.life <= 0
		puts''
		timer
		hit_chance = rand(player.party.length + 1)
		if hit_chance == 0
			puts @monster.name.to_s + ' lunges at you!'
			if player.agility * (rand(6) + 1) <= player.agility * 4
				damage = (@monster.strength * (rand(6)+1) - player.armour_rating)
				unless damage < 0
					puts 'and hits you!'
					player.life -= damage 
				end
				puts 'Your armour absorbs the blow' if damage <= 0
			else
				puts 'but the swing misses'
			end
		else
			defender = player.party[hit_chance - 1]
			puts @monster.name.to_s + " lunges at #{defender.name}!"
			if defender.agility * (rand(6) + 1) <= defender.agility * 4
				damage = (@monster.strength * (rand(6)+1) - defender.armour_rating)
				unless damage < 0
					puts "and hits #{defender.name}!"
					defender.life -= damage 
				end
				puts "#{defender.name}'s armour absorbs the blow" if damage <= 0
			else
				puts 'but the swing misses'
			end
		end
		timer
		puts''	
		puts @monster.name.to_s.capitalize + "'s life is " + @monster.life.to_s
		puts ''
		player.party.each do |char|
			puts "#{char.name}'s life is #{char.life}"
		end
		puts 'Your life is ' + player.life.to_s
		puts "You have #{player.magic} magic left"
		break if player.life <=0
	end
	timer
	if @monster.life <= 0
		puts ''
		puts @monster.name.to_s + "'s lifeless body hits the ground with a thud" unless @monster.class == Spector
		puts 'The Spectral form disipates' if @monster.class == Spector
		player.experience += @monster.experience
		puts 'total experience is ' + player.experience.to_s
		puts 'current level is ' + player.level.to_s
		loot
		gold = (rand(4) * (@monster.experience / 3))
		player.gold += gold
		puts 'gained ' + gold.to_s + ' gold'
		puts 'total gold is ' + player.gold.to_s
		level_up?(player)
		player.party.each do |char|
			char.experience += @monster.experience if char.life > 0
			level_up?(char)
		end
		timer
	end
	puts ''
	puts ''
end