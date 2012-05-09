require 'ridgedale'
require 'denofshadows'
require 'northshire'


class Maps
	attr_accessor :name, :location
	
	def initialize(name, location)
		@name = name
		@location = location
	end
end

Ridgedalemap = Maps.new('ridgedale', Ridgedale)
Northshiremap = Maps.new('northshire', Northshire)
DenofShadowsmap = Maps.new('den of shadows', Den_of_Shadows)
require 'middleton'
Middletonmap = Maps.new('middleton', Middleton)
require 'hamlet'
Hamletmap = Maps.new('deserted hamlet', Hamlet)




Map_id = { 'hamlet' => Hamletmap, 'middleton' => Middletonmap, 'den of shadows' => DenofShadowsmap}