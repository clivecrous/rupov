class Scene < RuPov::Group
    class Wall < RuPov::Group
        include RuPov
        include Objects
        include InfiniteSolidPrimitives
        include Textures
        include Pigments
        include Methods
        def initialize( rotate, translate )
            super()
            entireWall = CSG::Union.new() { |entireWall|
                entireWall << Plane.new( DataTypes::Vector::XYZ.new(0,0,-1),0 ) { |wall|
                    wall << Texture.new() { |texture|
                        texture << SolidColour.new( Colour.new( DataTypes::Vector::RGB.new(1,0.95,0.9) ) )
                        texture << Normal.new() { |normal|
                            normal << MultiValue.new([0.4],'crackle')
                            normal << MultiValue.new([0.05],'scale')
                        }
                        texture << Finish.new() { |finish|
                            finish << MultiValue.new([0.5],'phong')
                            finish << MultiValue.new([0.5],'roughness')
                        }
                    }
                }

                entireWall << CSG::Difference.new() { |sideboard|
                    sideboard_miniblock = FiniteSolidPrimitives::Box.new(
                        DataTypes::Vector::XYZ.new(-50,0.6,0.15),
                        DataTypes::Vector::XYZ.new( 50,0.751,0.31) )

                    sideboard << FiniteSolidPrimitives::Box.new(
                        DataTypes::Vector::XYZ.new(-50,0,0),
                        DataTypes::Vector::XYZ.new( 50,0.75,0.3) )
                    sideboard << CSG::Difference.new() { |sideboard_cutout|
                        sideboard_cutout << sideboard_miniblock
                        sideboard_cutout << CSG::Intersection.new() { |sideboard_cutoutinner|
                            sideboard_cutoutinner << sideboard_miniblock
                            sideboard_cutoutinner << FiniteSolidPrimitives::Cylinder.new(
                                DataTypes::Vector::XYZ.new(-50,0.6,0.15),
                                DataTypes::Vector::XYZ.new( 50,0.6,0.15), 0.15 )
                                }
                    }

                    sideboard << Texture.new() { |texture|
                        texture << Pigment.new() { |pigment|
                            pigment << "P_WoodGrain3A"
                            pigment << Base.new("colour_map") { |colourmap|
                                colourmap << "M_Teak"
                            }
                            pigment << Scale.new( 0.75 )
                            pigment << Rotate.new( DataTypes::Vector::XYZ.new(2,85,5) )
                            pigment << Translate.new( DataTypes::Vector::XYZ.new(100,200,300) )
                        }
                    }
                }
                entireWall << Rotate.new( rotate )
                entireWall << Translate.new( translate )
            }

            self << entireWall
        end
    end
    
    include RuPov
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
        global_settings = Base.new('global_settings') { |this|
            # XXX Uncomment the line below to activate radiosity
            # this << Base.new('radiosity')
        }
        self << global_settings

        self << Camera::Basic.new(
                    Location.new( RuPov::DataTypes::Vector::XYZ.new(1,1.75,2) ),
                    LookAt.new( RuPov::DataTypes::Vector::XYZ.new(0,0.75,0) ) )

        self << LightSources::PointLight.new(
                    RuPov::DataTypes::Vector::XYZ.new( 5,5,2 ), Colour.new( "White" ) )

        floor = Plane.new( RuPov::DataTypes::Vector::XYZ.new( 0,1,0 ), 0) { |this|
            this << Texture.new() { |this|
                this << Checker.new( Colour.new( "White" ), Colour.new( "Blue" ) )
                this << Scale.new( 1.7 )
                this << Finish.new() { |this|
                    this << "reflection { 0.3 }"
                }
            }
        }
        self << floor 

        self << Wall.new(
                    RuPov::DataTypes::Vector::XYZ.new( 0,0,0),
                    RuPov::DataTypes::Vector::XYZ.new(0,0,-2) )
        self << Wall.new(
                    RuPov::DataTypes::Vector::XYZ.new( 0,90,0),
                    RuPov::DataTypes::Vector::XYZ.new(-2,0,0) )

        yield(self) if block_given? and self.class == Scene
    end
end
