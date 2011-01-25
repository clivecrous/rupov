require 'rupov'
require './include/genericscene'

class GrassBlade < RuPov::Objects::FiniteSolidPrimitives::SphereSweep
    @@grassColour = RuPov::DataTypes::Vector::RGB.new( 0, 0.7, 0)
    @@grassTexture = RuPov::Textures::Texture.new do |texture|
        texture << RuPov::Textures::Pigments::SolidColour.new( RuPov::Methods::ColourRGB.new( @@grassColour ) )
    end
    def initialize( length, baseRadius, curve, segments)
        @@grassColour.g = rand*0.4 + 0.2
        @@grassColour.r = rand*0.2
        degrees = 0
        sweep = [ RuPov::DataTypes::Vector::XYZ.new(0,0,0), baseRadius ]
        0.upto(segments) do |segment|
            x = Math::sin( degrees )*(segment*length/segments)
            y = Math::cos( degrees )*(segment*length/segments)
            degrees += ((curve*(rand*0.6+0.6))/segments)*Math::PI/180
            sweep << RuPov::DataTypes::Vector::XYZ.new(x,y,0)
            sweep << (segments-segment)*baseRadius/segments
        end
        super(sweep,'b_spline')
        self << @@grassTexture.to_s # render in place
        yield(self) if block_given? and self.class == GrassBlade
    end
end

puts Scene.new

(1..1000).each do |num|
    GrassBlade.new( 0.8+rand*0.4, 0.005, 25+rand*20, 10) do |blade|
        blade << RuPov::Methods::Rotate.new( RuPov::DataTypes::Vector::XYZ.new(0,rand*90+110,0) )
        blade << RuPov::Methods::Translate.new( RuPov::DataTypes::Vector::XYZ.new(rand*1.5-0.75,0,rand*1.5-0.75) )
        puts blade
    end
end

