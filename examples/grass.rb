require '../rupov/povray.rb'
include Povray

include Objects
include FiniteSolidPrimitives
include InfiniteSolidPrimitives
include FinitePatchPrimitives

include Atmosphere
include Methods
include LightSources
include Textures

$grassTexture = Texture.new()
$grassTexture << Pigments::SolidColour.new( Colour.new( "Green" ) )

def grassBlade( length, baseRadius, curve, segments)
    blade = CSG::Union.new()

    0.upto(segments) do |segment|
        degrees = (segment*curve/segments)*Math::PI/180
        x1 = Math::sin( degrees )*(segment*length/segments)
        y1 = Math::cos( degrees )*(segment*length/segments)
        degrees = ((segment+1)*curve/segments)*Math::PI/180
        x2 = Math::sin( degrees )*((segment+1)*length/segments)
        y2 = Math::cos( degrees )*((segment+1)*length/segments)
        
        cone = Cone.new(
            VectorRadius.new(
                Povray::DataTypes::Vector::ThreeD.new(x1,y1,0) ,
                (segments-segment)*baseRadius/segments),
            VectorRadius.new(
                Povray::DataTypes::Vector::ThreeD.new(x2,y2,0) ,
                (segments-(segment+1))*baseRadius/segments))
        cone << $grassTexture
        blade << cone
    end

    blade
end

scene = Povray::Group.new()

scene << '#include "colors.inc"'

scene << Background.new( Colour.new( "Black" ) )
scene << Camera::Basic.new( Location.new( 35, 20, 50 ), LookAt.new( 25, 0, 15 ) )

scene << PointLight.new( Povray::DataTypes::Vector::ThreeD.new( 10,30,10 ), Colour.new( "White" ) )
scene << PointLight.new( Povray::DataTypes::Vector::ThreeD.new( 0,30,10 ), Colour.new( "White" ) )

ground = Plane.new( Povray::DataTypes::Vector::ThreeD.new(0,1,0), 0 )
ground << Pigments::SolidColour.new( ColourRGB.new( Povray::DataTypes::Vector::ThreeD.new(0.6,0.4,0) ) )

scene << ground

print scene

(0..1500).each do |num|
    grass =grassBlade( 8+rand()*4, 0.1, 25+rand()*20, 10)
    grass << Rotate.new( 0,rand()*360,0 )
    grass << Translate.new( rand()*50,0,rand()*50 )
    print grass
end

