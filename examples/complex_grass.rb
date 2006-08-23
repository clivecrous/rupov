require '../rupov/povray.rb'
require 'include/genericscene.rb'

class GrassBlade < Povray::Objects::FiniteSolidPrimitives::SphereSweep
    @@grassColour = Povray::DataTypes::Vector::RGB.new( 0, 0.7, 0)
    @@grassTexture = Povray::Textures::Texture.new() { |texture|
        texture << Povray::Textures::Pigments::SolidColour.new( Povray::Methods::ColourRGB.new( @@grassColour ) )
    }
    def initialize( length, baseRadius, curve, segments)
        @@grassColour.g = rand()*0.4 + 0.2
        @@grassColour.r = rand()*0.2
        degrees = 0
        sweep = [ Povray::DataTypes::Vector::XYZ.new(0,0,0), baseRadius ]
        0.upto(segments) do |segment|
            x = Math::sin( degrees )*(segment*length/segments)
            y = Math::cos( degrees )*(segment*length/segments)
            degrees += ((curve*(rand()*0.6+0.6))/segments)*Math::PI/180
            sweep << Povray::DataTypes::Vector::XYZ.new(x,y,0)
            sweep << (segments-segment)*baseRadius/segments
        end
        super(sweep,'b_spline')
        self << @@grassTexture.to_s # render in place
        yield(self) if block_given? and self.class == GrassBlade
    end
end

puts Scene.new()

(1..1000).each do |num|
    puts GrassBlade.new( 0.8+rand()*0.4, 0.005, 25+rand()*20, 10) { |blade|
        blade << Povray::Methods::Rotate.new( Povray::DataTypes::Vector::XYZ.new(0,rand()*90+110,0) )
        blade << Povray::Methods::Translate.new( Povray::DataTypes::Vector::XYZ.new(rand()*1.5-0.75,0,rand()*1.5-0.75) )
    }
end

