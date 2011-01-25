require 'rupov'
require './include/genericscene'

puts Scene.new() { |scene|
    scene << RuPov::Objects::FinitePatchPrimitives::Polygon.new(
            [   RuPov::DataTypes::Vector::XY.new( 0,0 ),
                RuPov::DataTypes::Vector::XY.new( 0,6 ),
                RuPov::DataTypes::Vector::XY.new( 4,6 ),
                RuPov::DataTypes::Vector::XY.new( 4,3 ),
                RuPov::DataTypes::Vector::XY.new( 1,3 ),
                RuPov::DataTypes::Vector::XY.new( 1,0 ),
                RuPov::DataTypes::Vector::XY.new( 0,0 ),
                RuPov::DataTypes::Vector::XY.new( 1,4 ),
                RuPov::DataTypes::Vector::XY.new( 1,5 ),
                RuPov::DataTypes::Vector::XY.new( 3,5 ),
                RuPov::DataTypes::Vector::XY.new( 3,4 ),
                RuPov::DataTypes::Vector::XY.new( 1,4 )
            ] ) { |polygon|
        polygon << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::Colour.new( "Yellow" ) )
        polygon << RuPov::Methods::MultiValue.new( [0.2], "scale" )
        polygon << RuPov::Methods::MultiValue.new( [RuPov::DataTypes::Vector::XYZ.new( 0,225,0 )], "rotate" )
    }
}
