require '../rupov/povray.rb'

class Scene < Povray::Group
    include Povray
    include Objects
    include InfiniteSolidPrimitives
    include Textures
    include Pigments
    include Methods

    def initialize
        super()
        self << '#include "colors.inc"'
        self << Camera::Basic.new( Location.new( 2,1.5,2 ), LookAt.new( 0,0,0 ) )
        self << LightSources::PointLight.new( Povray::DataTypes::Vector::ThreeD.new( 2,5,5 ), Colour.new( "White" ) )
        floor = Plane.new( Povray::DataTypes::Vector::ThreeD.new( 0,1,0 ), 0 )
        checker = Texture.new()
        checker << Checker.new( Colour.new( "White" ), Colour.new( "Blue" ) )
        floor << checker
        self << floor
    end
end
