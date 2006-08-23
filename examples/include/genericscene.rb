class Scene < Povray::Group
    class Wall < Povray::Group
        include Povray
        include Objects
        include InfiniteSolidPrimitives
        include Textures
        include Pigments
        include Methods
        def initialize( normal, offset)
            super()
            wall = Plane.new( normal, offset)
            texture = Texture.new()
            texture << SolidColour.new( Colour.new( DataTypes::Vector::RGB.new(1,0.95,0.9) ) )
            normalCrackle = Normal.new()
            normalCrackle << MultiValue.new([0.4],'crackle')
            normalCrackle << MultiValue.new([0.05],'scale')
            texture << normalCrackle
            finish = Finish.new()
            finish << MultiValue.new([0.5],'phong')
            finish << MultiValue.new([0.5],'roughness')
            texture << finish
            wall << texture
            self << wall
        end
    end
    
    include Povray
    include Objects
    include InfiniteSolidPrimitives
    include Textures
    include Pigments
    include Methods
    def initialize
        super()
        self << Include.new('colors.inc')
        global_settings = Base.new('global_settings')
        radiosity = Base.new('radiosity')
        global_settings << radiosity
        self << global_settings
        self << Camera::Basic.new(
                    Location.new( Povray::DataTypes::Vector::XYZ.new(2,1.5,2) ),
                    LookAt.new( Povray::DataTypes::Vector::XYZ.new(0,0,0) ) )
        self << LightSources::PointLight.new(
                    Povray::DataTypes::Vector::XYZ.new( 2,5,5 ), Colour.new( "White" ) )

        floor = Plane.new( Povray::DataTypes::Vector::XYZ.new( 0,1,0 ), 0)
        checker = Texture.new()
        checker << Checker.new( Colour.new( "White" ), Colour.new( "Blue" ) )
        checker << Scale.new( 0.3 )
        floor << checker
        finish = Finish.new()
        finish << Reflection.new( 0.5 )
        floor << finish

        self << floor 
        self << Wall.new( Povray::DataTypes::Vector::XYZ.new( 0,0,-1), 2)
        self << Wall.new( Povray::DataTypes::Vector::XYZ.new( -1,0,0), 2)
    end
end
