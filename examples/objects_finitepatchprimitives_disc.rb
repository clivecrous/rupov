require '../rupov/povray.rb'
require 'include/genericscene.rb'

scene = Scene.new()

disc =
    Povray::Objects::FinitePatchPrimitives::Disc.new(
        Povray::DataTypes::Vector::XYZ.new( 0,0.5,0),
        Povray::DataTypes::Vector::XYZ.new(0,1,0),
        0.7,
        0.2)

disc << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )

scene << disc

puts scene
