class Scene < Povray::Group
    class Wall < Povray::Group
        include Povray
        include Objects
        include InfiniteSolidPrimitives
        include Textures
        include Pigments
        include Methods
        def initialize( rotate, translate )
            super()
            entireWall = CSG::Union.new()
            wall = Plane.new( DataTypes::Vector::XYZ.new(0,0,-1),0 )
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

            sideboard = CSG::Difference.new()
            sideboard << FiniteSolidPrimitives::Box.new(
                DataTypes::Vector::XYZ.new(-50,0,0),
                DataTypes::Vector::XYZ.new( 50,0.75,0.3) )
            sideboard_miniblock = FiniteSolidPrimitives::Box.new(
                DataTypes::Vector::XYZ.new(-50,0.6,0.15),
                DataTypes::Vector::XYZ.new( 50,0.751,0.31) )
            sideboard_cutout = CSG::Difference.new()
            sideboard_cutoutinner = CSG::Intersection.new()
            sideboard_cutoutinner << sideboard_miniblock
            sideboard_cutoutinner << FiniteSolidPrimitives::Cylinder.new(
                DataTypes::Vector::XYZ.new(-50,0.6,0.15),
                DataTypes::Vector::XYZ.new( 50,0.6,0.15), 0.15 )
            sideboard_cutout << sideboard_miniblock
            sideboard_cutout << sideboard_cutoutinner
            sideboard << sideboard_cutout

            texture = Texture.new()
            pigment = Pigment.new()
            pigment << "P_WoodGrain3A"
            colour_map = Base.new('colour_map')
            colour_map << "M_Teak"
            pigment << colour_map
            pigment << Scale.new( 0.5 )
            pigment << Rotate.new( DataTypes::Vector::XYZ.new(75,60,90) )
            texture << pigment

            sideboard << texture
            sideboard_cutout << texture
            
            entireWall << wall
            entireWall << sideboard
            
            entireWall << Rotate.new( rotate )
            entireWall << Translate.new( translate )

            self << entireWall
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
        self << Include.new('woods.inc')
        self << Include.new('teak.map')
        global_settings = Base.new('global_settings')
        radiosity = Base.new('radiosity')
        global_settings << radiosity
        self << global_settings

        self << Camera::Basic.new(
                    Location.new( Povray::DataTypes::Vector::XYZ.new(1,1.75,2) ),
                    LookAt.new( Povray::DataTypes::Vector::XYZ.new(0,0.75,0) ) )

        self << LightSources::PointLight.new(
                    Povray::DataTypes::Vector::XYZ.new( 5,5,2 ), Colour.new( "White" ) )

        floor = Plane.new( Povray::DataTypes::Vector::XYZ.new( 0,1,0 ), 0)
        checker = Texture.new()
        checker << Checker.new( Colour.new( "White" ), Colour.new( "Blue" ) )
        checker << Scale.new( 1.7 )
        finish = Finish.new()
        finish << "reflection { 0.3 }"
        checker << finish
        floor << checker

        self << floor 

        self << Wall.new(
                    Povray::DataTypes::Vector::XYZ.new( 0,0,0),
                    Povray::DataTypes::Vector::XYZ.new(0,0,-2) )
        self << Wall.new(
                    Povray::DataTypes::Vector::XYZ.new( 0,90,0),
                    Povray::DataTypes::Vector::XYZ.new(-2,0,0) )
    end
end
