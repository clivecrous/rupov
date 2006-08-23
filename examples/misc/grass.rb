require '../../rupov/povray.rb'
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
$grassColour = Povray::DataTypes::Vector::Colour.new( 0, 1, 0)
$grassTexture << Pigments::SolidColour.new( ColourRGB.new( $grassColour ) )

def grassBlade( length, baseRadius, curve, segments)
    blade = CSG::Union.new()

    $grassColour.g = rand()*0.4 + 0.6
    $grassColour.r = rand()*0.4

    degrees = 0
    0.upto(segments) do |segment|
        x1 = Math::sin( degrees )*(segment*length/segments)
        y1 = Math::cos( degrees )*(segment*length/segments)
        degrees += ((curve*(rand()*0.6+0.6))/segments)*Math::PI/180
        x2 = Math::sin( degrees )*((segment+1)*length/segments)
        y2 = Math::cos( degrees )*((segment+1)*length/segments)
        
        cone = Cone.new(
            Povray::DataTypes::Vector::ThreeD.new(x1,y1,0),
            (segments-segment)*baseRadius/segments,
            Povray::DataTypes::Vector::ThreeD.new(x2,y2,0),
            (segments-(segment+1))*baseRadius/segments)
        cone << $grassTexture
        blade << cone
        $grassColour.r-=0.05 if $grassColour.r > 0
        $grassColour.g-=0.01 if $grassColour.g > 0
    end

    blade
end

scene = Povray::Group.new()

scene << '#include "colors.inc"'

scene << Background.new( Colour.new( "Black" ) )
scene << Camera::Basic.new( Location.new( 35, 20, 50 ), LookAt.new( 25, -15, 15 ) )

scene << PointLight.new( Povray::DataTypes::Vector::ThreeD.new( 20,30,40 ), Colour.new( "White" ) )
scene << PointLight.new( Povray::DataTypes::Vector::ThreeD.new( 0,30,10 ), Colour.new( "White" ) )

ground = Plane.new( Povray::DataTypes::Vector::ThreeD.new(0,1,0), 0 )
ground << Pigments::SolidColour.new( ColourRGB.new( Povray::DataTypes::Vector::ThreeD.new(0.6,0.4,0) ) )

scene << ground

print scene

(0..3500).each do |num|
    grass =grassBlade( 8+rand()*4, 0.1, 25+rand()*20, 20)
    grass << Rotate.new( 0,rand()*90+110,0 )
    grass << Translate.new( rand()*50,0,rand()*50 )
    print grass
end

