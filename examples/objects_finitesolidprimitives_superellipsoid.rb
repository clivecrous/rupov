require '../rupov/povray.rb'
require 'include/genericscene.rb'

puts Scene.new() { |scene|
    scene << Povray::Objects::FiniteSolidPrimitives::SuperEllipsoid.new(
            Povray::DataTypes::Vector::XY.new( 0.5, 0.75) ) { |ellipsoid|
        ellipsoid << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )
        ellipsoid << Povray::Methods::Scale.new( 0.5 )
        ellipsoid << Povray::Methods::Translate.new( Povray::DataTypes::Vector::XYZ.new(0,0.5,0) )
    }
}
