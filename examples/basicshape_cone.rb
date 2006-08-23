require 'genericscene.rb'

include Povray::Objects::FiniteSolidPrimitives
include Povray::Textures::Pigments
include Povray::Methods

scene = Scene.new()

cone = Cone.new( VectorRadius.new( [0,0,0] ,0.8 ), VectorRadius.new( [0,1,0], 0.3 ))
cone << SolidColour.new( Colour.new( "Yellow" ) )
scene << cone

puts scene
