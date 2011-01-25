require 'rupov'
require "./#{File.dirname(__FILE__)}/include/genericscene"

puts Scene.new() { |scene|
    scene << RuPov::Objects::FiniteSolidPrimitives::Prism.new(
            0,1,
            [
                RuPov::DataTypes::Vector::XY.new( 3,5 ),
                RuPov::DataTypes::Vector::XY.new(-3,5 ),
                RuPov::DataTypes::Vector::XY.new(-5,0 ),
                RuPov::DataTypes::Vector::XY.new(-3,-5 ),
                RuPov::DataTypes::Vector::XY.new( 3,-5 ),
                RuPov::DataTypes::Vector::XY.new( 5,0 ),
                RuPov::DataTypes::Vector::XY.new( 3,5 )
            ] ) { |prism|
        prism << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::Colour.new( "Yellow" ) )
        prism << RuPov::Methods::Scale.new( 0.15 )
        prism << RuPov::Methods::Translate.new( RuPov::DataTypes::Vector::XYZ.new(-0.2,0,-0.2) )
    }
}
