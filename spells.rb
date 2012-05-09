
def fire(offense = $player, defense = @monster)
	puts 'not enough magic' if offense.magic < 3
	damage = offense.intelligence * (rand(6)+ 1)
	if offense.magic >= 3 && (defense.class != Ghoul && defense.class != Undead)
		defense.life -= damage
		offense.magic -= 3
	end
	if offense.magic >= 3 && (defense.class == Ghoul || defense.class == Undead)
		defense.life -= damage * 2
		offense.magic -= 3
	end	
end

def heal(user = $player)
	puts 'not enough magic' if user.magic < user.intelligence
	if user.magic >= user.intelligence
		user.life += user.intelligence*user.intelligence*2
		user.magic -= user.intelligence
	end
	if user.life > user.endurance * 10
		user.life = user.endurance * 10
	end
end

def holy(offense = $player, defense = @monster)
	puts 'not enough magic' if offense.magic < 15
	if defense.class == Undead && offense.magic >= 20
		defense.life = (defense.life/3)
		offense.magic -= 20
	elsif defense.class == Bal && offense.magic >= 20
		defense. life -= offense.intelligence * (rand(6)+1) * 3
	else
		puts 'The spell has no effect'
	end
end

def flame(offense = $player, defense = @monster)
	puts 'not enough magic' if offense.magic < 20
	damage = offense.intelligence * (rand(6)+1) * 3
	if offense.magic >= 3 && (defense.class != Ghoul && defense.class != Undead)
		defense.life -= damage
		offense.magic -= 3
	end
	if offense.magic >= 3 && (defense.class == Ghoul || defense.class == Undead)
		defense.life -= damage * 2
		offense.magic -= 3
	end	
end

Spells_price = {'heal' => 100 , 'holy' => 200, 'flame' => 500}
		
	