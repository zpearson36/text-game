def shop
	puts ''
	puts '=' * 50
	puts 'SHOP'.center(50)
	puts '='*50
	puts 'Welcome Adventurer!'
	timer
	
	@items = {'potion' => 50, 'mana' => 70, 'rejuvinate' => 350, 'xpotion' => 150}
	@weapons = {'club' => 50, 'sword' => 150, 'axe' => 400, 'claymore' => 800}
	@spells = {'heal' => 100 , 'holy' => 200, 'flame' => 500}
	@armour = {Hat.name => 200, Leather.name => 500, Gloves.name  => 175, Shield.name => 375, Shoes.name => 225}
	def buy
		inventory = [self.weapons, self.items, self.spells, self.armour]
		puts 'What would you like to purchase?'
		puts ''
		puts '-'*10
		puts 'items'.center(10)
		puts '-'*10
		@items.each_key do |key|
			puts key.to_s + ' - ' + @items[key].to_s + ' gold'
		end
		puts '-'*10
		puts 'spells'.center(10)
		puts '-'*10
		@spells.each_key do |key|
			puts key.to_s + ' - ' + @spells[key].to_s + ' gold'
		end
		puts '-'*10
		puts 'weapons'.center(10)
		puts '-'*10
		@weapons.each_key do |key|
			puts "#{key.to_s.upcase} - #{@weapons[key].to_s} gold"
			puts "Damage rating: #{Weapon_id[key].damage.to_s}"
		end
		puts '-'*10
		puts 'armour'
		puts '-'*10
		@armour.each_key do |key|
			puts "#{key.to_s.upcase} - #{@armour[key].to_s} gold"
			puts "Defense rating: #{Armour_id[key].rating.to_s}"
			puts "Armour type: #{Armour_id[key].type.to_s}"
		end
		puts ''
		purchase = ''
		while true
			purchase = gets.chomp
			break if purchase == 'back'
			if(@items.include? purchase) || (@weapons.include? purchase) || (@spells.include? purchase) || (@armour.include? purchase)
				inventory.each do |invtry|
					if (invtry.each_key.include? purchase) && (Player1.gold >= invtry[purchase])
						Player1.inventory << purchase if @items.include? purchase
						Player1.inventory << Weapon_id[purchase] if @weapons.include? purchase
						Player1.inventory << Armour_id[purchase] if @armour.include? purchase
						Player1.spells << purchase if @spells.include? purchase
						Player1.gold -= invtry[purchase]
					elsif (invtry.each_key.include? purchase) && (Player1.gold < invtry[purchase])
						puts 'You do not have enough gold'
					end
				end
				puts ''
				puts 'you have ' + Player1.gold.to_s + ' left.'
				puts ''
				puts 'Would you like anything else?'
				puts ''
			else
				puts 'No such item in inventory'
			end
		end
	end
	
	def sell
		sell = ''
		while true
			puts 'what would you like to sell?'
			invtry = []
			Player1.inventory.each do |item|
				unless (item.class == Weapon) || (item.class == Armour)
					invtry << item
					puts item.to_s + ' - ' + (@items[item]/2).to_s
				else (item.class == Weapon) || (item.class == Armour)
					invtry << item.name 
					puts item.name.to_s + ' - ' + (@weapons[item.name]/2).to_s if item.class == Weapon
					puts item.name.to_s + ' - ' + (@armour[item.name]/2).to_s if item.class == Armour					
				end
			end
			puts ''
			sell = gets.chomp
			puts ''
			break if sell == 'back'
			if (invtry.include? sell) && (@items.has_key? sell)
				Player1.inventory.delete_at(Player1.inventory.index(sell))
				Player1.gold += (@items[sell] / 2)
			elsif (invtry.include? sell) && (@weapons.has_key? sell)
				Player1.inventory.delete_at(Player1.inventory.index(Weapon_id[sell]))
				temp = []
				Player1.inventory.each do |item|
					(temp << item) if (item == Weapon_id[sell])
				end
				Player1.weapon.delete_at 0 if temp.length == 0
				Player1.gold += (@weapons[sell] / 2)
			elsif (invtry.include? sell) && (@armour.has_key? sell)
				Player1.inventory.delete_at(Player1.inventory.index(Armour_id[sell]))
				temp = []
				Player1.inventory.each do |item|
					(temp << item) if (item == Armour_id[sell])
				end
				Player1.armour.delete_at(Player1.armour.index(sell).to_i) if temp.length == 0
				Player1.gold += (@armour[sell] / 2)
			else
				puts 'No such item in your inventory'
				puts ''
			end
			puts ''
			puts 'You now have ' + Player1.gold.to_s + ' gold.'
		end
	end	
	
	shop_options = ['buy', 'sell']
	response = ''
	while true
		puts 'What would you like to do? (buy or sell)'
		puts ''
		inventory
		puts 'your spells: ' +Player1.spells.to_s
		puts 'your weapon: ' + Player1.weapon[0].name.to_s unless Player1.weapon.length == 0
		puts 'your weapon: ' + Player1.weapon.to_s if Player1.weapon.length == 0
		puts ''
		puts 'Your gold: ' + Player1.gold.to_s
		puts ''
		response = gets.chomp
		puts ''
		break if response == 'leave'
		if shop_options.include? response
			send(response)
		else
			puts 'Please enter a valid option'
		end
		
	end
	puts '='*50
	puts ''
	puts '='*50
end