require '../rupov/povray.rb'
require 'include/genericscene.rb'

$grassColour = Povray::DataTypes::Vector::RGB.new( 0, 0.7, 0)
$grassTexture = Povray::Textures::Texture.new() { |texture|
    texture << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::ColourRGB.new( $grassColour ) )
}

def grassBlade( length, baseRadius, curve, segments)
    Povray::CSG::Union.new() { |blade|

        $grassColour.g = rand()*0.4 + 0.2
        $grassColour.r = rand()*0.2

        degrees = 0
        0.upto(segments) do |segment|
            x1 = Math::sin( degrees )*(segment*length/segments)
            y1 = Math::cos( degrees )*(segment*length/segments)
            degrees += ((curve*(rand()*0.6+0.6))/segments)*Math::PI/180
            x2 = Math::sin( degrees )*((segment+1)*length/segments)
            y2 = Math::cos( degrees )*((segment+1)*length/segments)
            cone = Povray::Objects::FiniteSolidPrimitives::Cone.new(
                    Povray::DataTypes::Vector::XYZ.new(x1,y1,0),
                    (segments-segment)*baseRadius/segments,
                    Povray::DataTypes::Vector::XYZ.new(x2,y2,0),
                    (segments-(segment+1))*baseRadius/segments) { |cone|
                $grassColour.r-=0.025 if $grassColour.r > 0.025
                cone << $grassTexture.to_s # It must be rendered at this point
            }
            blade << cone
        end
    }
end

scene = Scene.new() { |scene|
    (1..2000).each do |num|
        grass = grassBlade( 0.8+rand()*0.4, 0.005, 25+rand()*20, 100)
        grass << Povray::Methods::Rotate.new( Povray::DataTypes::Vector::XYZ.new(0,rand()*90+110,0) )
        grass << Povray::Methods::Translate.new( Povray::DataTypes::Vector::XYZ.new(rand()*1.5-0.75,0,rand()*1.5-0.75) )
        print grass
    end
}

puts scene
