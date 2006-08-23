require 'genericscene.rb'

include Povray::Objects::FiniteSolidPrimitives
include Povray::Textures::Pigments
include Povray::Methods

scene = Scene.new()

box = Box.new( Vector.new( [-0.5,0,-0.5] ) , Vector.new( [0.5,1,0.5] ) )
box << SolidColour.new( Colour.new( "Yellow" ) )
scene << box

puts scene
