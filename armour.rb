class Armour
	attr_accessor :name, :rating, :type
	
	def initialize(name, rating, type)
		@name = name
		@rating = rating
		@type = type
	end
end

None = Armour.new('', 0, '')
Hat = Armour.new('hat' , 1, 'head gear')
Leather = Armour.new('leather vest' , 3, 'body gear')
Shield = Armour.new('wicker shield' , 2, 'shield')
Shoes = Armour.new('leather shoes' , 1, 'foot gear')
Gloves = Armour.new('leather gloves', 1, 'gloves')
Chain_Helm = Armour.new('chain helmet', 5, 'head gear')
Chain_Mail= Armour.new('chain mail', 10, 'body gear')
Steel_Buckler = Armour.new('steel buckler', 7, 'shield')
Boots = Armour.new('heavy boots', 5, 'foot gear')
Chain_Gloves = Armour.new('chain gauntlets', 5, 'gloves')
Plate_Helm = Armour.new('plated helmet', 13, 'head gear')
Plate_Mail = Armour.new('plate mail', 17, 'body gear')
Tower_Shield = Armour.new('tower shield', 15, 'shield')
Plate_Boots = Armour.new('plated boots', 13, 'foot gear')
Plate_Gloves = Armour.new('plated gauntlets', 13, 'gloves')


Armour_id = {Hat.name => Hat, Leather.name => Leather, Shield.name => Shield, Shoes.name => Shoes, Gloves.name => Gloves,
Chain_Helm.name => Chain_Helm, Chain_Mail.name => Chain_Mail, Steel_Buckler.name => Steel_Buckler, Boots.name => Boots, Chain_Gloves.name => Chain_Gloves,
Plate_Helm.name => Plate_Helm, Plate_Mail.name => Plate_Mail, Tower_Shield.name => Tower_Shield, Plate_Boots.name => Plate_Boots, Plate_Gloves.name => Plate_Gloves}
Armour_price = {'hat' => 15, 'leather vest' => 45, 'leather gloves'  => 15, 'wicker shield' => 30, 'leather shoes' => 15,
'chain helmet' => 125, 'chain mail' => 250, 'steel buckler' => 200, 'heavy boots' => 125, 'chain gauntlets' => 125, 'plated helmet' => 300,
'plate mail' => 500, 'tower shield' => 375, 'plated boots' => 300, 'plated gauntlets' => 300}