require '../rupov/povray.rb'
require 'include/genericscene.rb'

scene = Scene.new()

cone =
    Povray::Objects::FiniteSolidPrimitives::Cone.new(
        Povray::DataTypes::Vector::XYZ.new(0,0,0), 0.6,
        Povray::DataTypes::Vector::XYZ.new(0,1,0), 0.3 )

cone << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )

scene << cone

puts scene
