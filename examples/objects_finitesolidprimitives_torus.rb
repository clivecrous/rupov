require '../rupov/povray.rb'
require 'include/genericscene.rb'

puts Scene.new() { |scene|
    scene << Povray::Objects::FiniteSolidPrimitives::Torus.new( 0.65, 0.2 ) { |torus|
        torus << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )
        torus << Povray::Methods::Translate.new( Povray::DataTypes::Vector::XYZ.new( 0, 0.5, 0 ))
    }
}
