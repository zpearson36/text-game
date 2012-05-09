class Spellbook
	attr_accessor :name, :spell
	
	def initialize (name, spell)
		@name = name
		@spell = spell
	end
end

BookofHeal = Spellbook.new('book of heal', 'heal')
BookofHoly = Spellbook.new('book of holy', 'holy')

Spellbook_id = { 'book of heal' => BookofHeal, 'book of holy' => BookofHoly}
