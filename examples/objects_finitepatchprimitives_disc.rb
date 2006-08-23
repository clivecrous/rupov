require '../rupov/povray.rb'
require 'include/genericscene.rb'

puts Scene.new() { |scene|
    scene << Povray::Objects::FinitePatchPrimitives::Disc.new(
        Povray::DataTypes::Vector::XYZ.new( 0,0.5,0),
        Povray::DataTypes::Vector::XYZ.new(0,1,0),
        0.7,
        0.2) { |disc|
            disc << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )
        }
    }
