require '../rupov/povray.rb'
require 'include/genericscene.rb'

include Povray::Objects::FiniteSolidPrimitives
include Povray::Textures::Pigments
include Povray::Methods

scene = Scene.new()

cylinder = Cylinder.new( Povray::DataTypes::Vector::XYZ.new( 0,0,0) , Povray::DataTypes::Vector::XYZ.new(0,1,0), 0.5 )
cylinder << SolidColour.new( Colour.new( "Yellow" ) )
scene << cylinder

puts scene
