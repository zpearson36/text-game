
class Weapon
	attr_accessor :name, :damage
	
	def initialize (name, damage)
		@name = name
		@damage = damage
	end
end

Club = Weapon.new('club', 5)
Sword = Weapon.new('sword', 10)
Axe = Weapon.new('axe', 15)
Claymore = Weapon.new('claymore',20)

Weapon_id = {'club' => Club, 'sword' => Sword , 'axe' => Axe , 'claymore' => Claymore }
Weapons_price = {'club' => 50, 'sword' => 500, 'axe' => 1000, 'claymore' => 2000}