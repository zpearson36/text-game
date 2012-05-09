require 'player'
require 'maps'
require 'spells'
require 'items'
require 'armour'
require 'weapons'
require 'characters'
require 'hamlet'
require 'middleton'
require 'denofshadows'
require 'northshire'
require 'ridgedale'
require 'commands'
require 'rand_fight'

require 'books'

o = ''
while true
	puts 'would you like to load?'
	o = gets.chomp
	if o == 'yes'
		puts "Which character would you like to load?"
		puts ''
		Dir.glob("**/") do |dir|
			str = dir
			str = str.sub 'games/', ''
			puts str.sub '/', ''
		end			
		name = gets.chomp
		if File.directory?("games/#{name}")
			File.open("games/#{name}/#{name}") do |file|
				$player = Marshal.load(file)
			end

			$player.party.each do |char|
				File.open("games/#{$player.name}/#{char.name}") do |file|
					char = Marshal.load(file)
				end
			end		

			$player.party.each do |char|
				File.open("games/#{$player.name}/#{char.name}", "w+") do |file|
					Marshal.dump(char, file)
				end
			end	

			$player.maps.each do |area|
				File.open("games/#{$player.name}/#{area.name}") do |file|
					area = Marshal.load(file)
				end
			end
			
			$player.visited.each do |location|
				location.each do |place|
					File.open("games/#{$player.name}/#{place.name}") do |file|
						place = Marshal.load(file)
					end
				end
			end
			puts ''
			if $player.position.length > 0
				puts "#{$player.position[0].name}"
				puts ''
				puts $player.position[0].look
			end
			break
		else
			puts 'Please enter a valid character'
		end
	elsif o == 'no'
		puts ''
		puts 'Please enter a name for your character.'
		name = gets.chomp
		
		def attribute_total(stats)
			stats[:strength] + stats[:endurance] + stats[:agility] + stats[:intelligence]
		end

		player_attribute = {:strength => 0, :endurance => 0, :agility => 0, :intelligence => 0}
		until attribute_total(player_attribute) == 20
			puts ''
			puts 'you have 20 points to distribute between strength, agility, intelligence'
			puts 'and endurance'
			puts ''
			player_attribute.each do |attribute, value|
				while true
					puts ''
					puts 'please enter a value for ' + attribute.to_s
					puts ''
					stat = gets.to_i
					if (stat > 0 && stat <= 17)
						player_attribute[attribute] = stat
						break
					end
					puts 'please enter a number between 1 and 17' if (stat <= 0 || stat > 17)
				end
			end
			puts 'You only have 20 points to distribute!!!' if attribute_total(player_attribute) > 20
			puts 'Please distribute all of the points.' if attribute_total(player_attribute) < 20
		end
		
		$player = Player.new(name,player_attribute[:strength], player_attribute[:endurance], player_attribute[:agility], player_attribute[:intelligence])
		
		$player.maps << Hamletmap
		$player.area << Hamlet
		$player.visited << Hamletloc
		Dir.mkdir("games/#{$player.name}")
		File.open("games/#{$player.name}/#{$player.name}", "w+") do |file|
			Marshal.dump($player, file)
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
		puts ''
		puts ''
		puts ''
		puts 'You awake to find yourself in a deserted hamlet. The buildings here'
		puts 'look as though it has been many years since anyone had lived here.'
		puts 'You wonder how it is you came here and quickly realize that you cannot'
		puts 'recall anything from before this moment. It is as if you have just awaken'
		puts 'from a dreamless sleep that has lasted since your birth. As you try harder'
		puts 'to recall any detail of your life before now, you feel the back of your'
		puts 'right hand begin to burn. You look down at it to see that some sort of'
		puts 'symbol has been carved in it. The circular scar contains within it several'
		puts 'smaller designs that are all aligned. You rub your hand as the questions'
		puts 'begin to pile up in your mind. You decide that standing here is not going'
		puts 'to ease your mind and decide to explore the buildings.'
		puts ''
		puts ''
		puts Hamlet.look
		break
	else
		puts 'i dont know what you are trying to say'
	end
end

k = ''


while true
	while true
		break if $player.life <= 0
		position = $player.position[0]
		puts 'you are standing outside' unless $player.position.length > 0
		puts ''
		k = gets.chomp
		puts''
		break if k == 'exit'
		if ($player.position.length > 0) && (position.commands.include? k)
			$player.position[0].send(k)
		elsif ($player.position.length == 0) && (Commands_outside.include? k)
			send(k)
		else
			puts 'please enter a valid command'
		end
	end
	break if $player.life > 0
	if $player.life <= 0
		puts 'You Are Dead!!!!!!!'
		puts ''
		puts 'would you like to continue?'
		j = ''
		while true
			j = gets.chomp
			if j.downcase == 'yes'
				File.open("games/#{$player.name}/#{$player.name}") do |file|
					$player = Marshal.load(file)
				end

				$player.party.each do |char|
					File.open("games/#{$player.name}/#{char.name}") do |file|
						char = Marshal.load(file)
					end
				end		

				$player.party.each do |char|
					File.open("games/#{$player.name}/#{char.name}", "w+") do |file|
						Marshal.dump(char, file)
					end
				end	

				$player.maps.each do |area|
					File.open("games/#{$player.name}/#{area.name}") do |file|
						area = Marshal.load(file)
					end
				end
				
				$player.visited.each do |location|
					location.each do |place|
						File.open("games/#{$player.name}/#{place.name}") do |file|
							place = Marshal.load(file)
						end
					end
				end
				puts "You awake in the #{$player.position[0].name}" unless $player.position.length == 0
				puts ''
				puts $player.position[0].look unless $player.position.length == 0
				break
				elsif j.downcase == 'no'
					break
				else
				puts 'I do not know that command'
			end
		end
	end
	break if $player.life <= 0
end
puts 'Game Over!!!!'