module Inn
	def rest
		puts "It will be 15 gold to rest here. will you rest? (yes or no)"
		puts "You have #{$player.gold}"
		puts ''
		response = gets.chomp.downcase
		puts''
		if response == 'yes' && $player.gold >= 15
			$player.gold -= 15
			sleep
		elsif response == 'yes' && $player.gold < 15
			puts 'You set your coin purse on the counter but the distinct lack of coins rustling'
			puts 'makes your ears grow red with embarassment. You look at the innkeeper who is'
			puts 'looking back at you with an impatient glare. If only you were better at'
			puts 'managing your money.'
		elsif response == 'no'
			puts 'Have a good day.'
		else 
			puts "'I don't know what you are trying to say'"
		end
	end
end

module Shop
	def buy
		puts inventory
		puts ''
		inventory = [self.weapons, self.items, self.spells, self.armour]
		puts "You have #{$player.gold} gold"
		puts 'What would you like to purchase?'
		puts "('back' to return to shop)"
		puts ''
		puts '-'*10
		puts 'items'.center(10)
		puts '-'*10
		self.items.each do |item|
			puts item.to_s + ' - ' + Items_price[item].to_s + ' gold'
		end
		puts '-'*10
		puts 'spells'.center(10)
		puts '-'*10
		self.spells.each do |spell|
			puts spell.to_s + ' - ' + Spells_price[spell].to_s + ' gold'
		end
		puts '-'*10
		puts 'weapons'.center(10)
		puts '-'*10
		self.weapons.each do |weapon|
			puts "#{weapon.to_s.upcase} - #{Weapons_price[weapon].to_s} gold"
			puts "Damage rating: #{Weapon_id[weapon].damage.to_s}"
		end
		puts '-'*10
		puts 'armour'.center(10)
		puts '-'*10
		self.armour.each do |armour|
			puts "#{armour.to_s.upcase} - #{Armour_price[armour].to_s} gold"
			puts "Defense rating: #{Armour_id[armour].rating.to_s}"
			puts "Armour type: #{Armour_id[armour].type.to_s}"
		end
		puts ''
		purchase = ''
		while true
			purchase = gets.chomp
			break if purchase == 'back'
			if(self.items.include? purchase) || (self.weapons.include? purchase) || (self.spells.include? purchase) || (self.armour.include? purchase)
				if self.items.include? purchase
					if ($player.gold) >= (Items_price[purchase])
						$player.inventory << purchase
						$player.gold -= Items_price[purchase]
					elsif $player.gold < Items_price[purchase]
						puts 'Not enough gold'
					end
				end
				if self.weapons.include? purchase
					if $player.gold >= Weapons_price[purchase]
						$player.inventory << Weapon_id[purchase]
						$player.gold -= Weapons_price[purchase]
					elsif $player.gold < Weapons_price[purchase]
						puts 'Not enough gold'
					end
				end	
				if self.spells.include? purchase
					if $player.gold >= Spells_price[purchase]
						$player.spells << purchase
						$player.gold -= Spells_price[purchase]
					else
						puts 'Not enough gold'
					end
				end
				if self.armour.include? purchase
					if $player.gold >= Armour_price[purchase]
						$player.inventory << Armour_id[purchase]
						$player.gold -= Armour_price[purchase]
					else $player.gold < Armour_price[purchase]
						puts 'Not enough gold'
					end
				end				
				puts ''
				puts 'you have ' + $player.gold.to_s + ' left.'
				puts ''
				puts 'Would you like anything else?'
				puts ''
			else
				puts 'No such item in inventory'
			end
		end
		puts ''
		puts $player.position[0].look
	end
	
	def sell
		puts ''
		puts 'what would you like to sell?'
		puts "('back' to return to shop)"
		puts''
		sell = ''
		while true
			puts inventory
			puts ''
			loop = 0
			sell = gets.chomp
			break if sell == 'back'
			if ($player.inventory.include? sell) && (Spellbook_id.has_key? sell)
				$player.inventory.delete_at($player.inventory.index(sell))
				$player.gold += (Spells_price[Spellbook_id[sell].spell]/2)
			end
			$player.inventory.each do |item|
				if item == sell && ((Key_Items.has_key? sell) == false)
					$player.inventory.delete_at($player.inventory.index(item))
					$player.gold += (Items_price[item]/2)
					puts "Your gold is now #{$player.gold}"
					loop += 1
					break
				elsif (item.class == Weapon) || (item.class == Armour)
					if item.name == sell					
						$player.inventory.delete_at($player.inventory.index(item))
						$player.gold += (Weapons_price[item.name]/2) if item.class == Weapon
						$player.gold += (Armour_price[item.name]/2) if item.class == Armour
						puts "Your gold is now #{$player.gold}"
						if item.class == Weapon
							temp = []
							$player.inventory.each do |item|
								(temp << item) if (item == Weapon_id[sell])
							end
							$player.weapon.delete_at 0 if temp.length == 0
						end
						if item.class == Armour
							temp = []
							$player.inventory.each do |item|
								(temp << item) if (item == Armour_id[sell])
							end
							$player.armour.delete_at $player.armour.index(item).to_i if temp.length == 0
						end
						loop += 1
						break
					end
				elsif item == sell && (Key_Items.has_key? sell)
					puts 'You cannot sell key items'
					loop += 1
				end
			end
			puts 'You do not have an item by that name' if loop == 0
			puts ''
			puts 'Would you like to sell anything else?'
		end
		puts ''
		puts $player.position[0].look
	end
end
