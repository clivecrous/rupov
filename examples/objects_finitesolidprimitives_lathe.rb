require '../rupov/povray.rb'
require 'include/genericscene.rb'

puts Scene.new() { |scene|
    scene << Povray::Objects::FiniteSolidPrimitives::Lathe.new(
            [
                Povray::DataTypes::Vector::XY.new( 0,0 ),
                Povray::DataTypes::Vector::XY.new( 1,1 ),
                Povray::DataTypes::Vector::XY.new( 2,3 ),
                Povray::DataTypes::Vector::XY.new( 2,4 ),
                Povray::DataTypes::Vector::XY.new( 2,5 ),
                Povray::DataTypes::Vector::XY.new( 0,4.75 )
            ] ) { |lathe|
        lathe << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )
        lathe << Povray::Methods::MultiValue.new( [0.2], 'scale' )
    }
}
