require 'rupov'
require "./#{File.dirname(__FILE__)}/include/genericscene"

puts Scene.new() { |scene|
    scene << RuPov::Objects::FiniteSolidPrimitives::SphereSweep.new(
            [   RuPov::DataTypes::Vector::XYZ.new( 0, -0.1, 0), 0.1,
                RuPov::DataTypes::Vector::XYZ.new( 0, 0, 0), 0.1,
                RuPov::DataTypes::Vector::XYZ.new( -0.5, 0.25, 0), 0.075,
                RuPov::DataTypes::Vector::XYZ.new( -0.5, 0.5, 0.5), 0.05,
                RuPov::DataTypes::Vector::XYZ.new( 0.5, 0.75, 0.5), 0.025,
                RuPov::DataTypes::Vector::XYZ.new( 0.5, 1, -0.5), 0.001,
                RuPov::DataTypes::Vector::XYZ.new( 0, 1, 0), 0
            ], 'b_spline' ) { |spheresweep|
        spheresweep << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::Colour.new( "Yellow" ) )
    }
}
