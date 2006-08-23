require '../rupov/povray.rb'
require 'include/genericscene.rb'

scene = Scene.new() { |scene|

    scene << Povray::Objects::FinitePatchPrimitives::Polygon.new(
            [   Povray::DataTypes::Vector::XY.new( 0,0 ),
                Povray::DataTypes::Vector::XY.new( 0,6 ),
                Povray::DataTypes::Vector::XY.new( 4,6 ),
                Povray::DataTypes::Vector::XY.new( 4,3 ),
                Povray::DataTypes::Vector::XY.new( 1,3 ),
                Povray::DataTypes::Vector::XY.new( 1,0 ),
                Povray::DataTypes::Vector::XY.new( 0,0 ),
                Povray::DataTypes::Vector::XY.new( 1,4 ),
                Povray::DataTypes::Vector::XY.new( 1,5 ),
                Povray::DataTypes::Vector::XY.new( 3,5 ),
                Povray::DataTypes::Vector::XY.new( 3,4 ),
                Povray::DataTypes::Vector::XY.new( 1,4 )
            ] ) { |polygon|
                polygon << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::Colour.new( "Yellow" ) )
                polygon << Povray::Methods::MultiValue.new( [0.2], "scale" )
                polygon << Povray::Methods::MultiValue.new( [Povray::DataTypes::Vector::XYZ.new( 0,225,0 )], "rotate" )
            }
}

puts scene
