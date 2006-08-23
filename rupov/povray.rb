module Povray

    class Base
        attr_reader :name
        def initialize( name='' )
            @name = name
            @children = []
        end
        def to_s
            children = ''
            @children.each { |child| child.to_s.each { |line| children += " "*4+line.rstrip+"\n" } }
            "#{name}#{name.length>0?' ':''}{\n#{children}}"
        end
        def <<( child )
            @children << child
        end
    end

    class Group < Base
        def initialize
            super( '' )
        end
        def to_s
            children = ''
            @children.each { |child| child.to_s.each { |line| children += line.rstrip+"\n" } }
            "#{children}"
        end
    end

    module Objects

        module FiniteSolidPrimitives

            class Box < Base
                def initialize( lowerLeftCorner, upperRightCorner )
                    super( 'box' )
                    self << lowerLeftCorner
                    self << upperRightCorner
                end
            end

            class Cone < Base
                def initialize( leftCentreRadius, rightCentreRadius, open = false )
                    super( 'cone' )
                    self << leftCentreRadius
                    self << rightCentreRadius
                    self << "open" if open
                end
            end

            class Cylinder < Base
                def initialize( leftCentre, rightCentre, radius, open = false )
                    super( 'cylinder' )
                    self << Methods::MultiValue.new([leftCentre,rightCentre,radius])
                    @open = open
                end
                def to_s
                    self << "open" if @open
                    result = super()
                    self.pop() if @open
                    result
                end
            end

            class Lathe < Base
                def initialize( points, splineType = "linear_spline", sturm = false )
                    super( 'lathe' )
                    self << "#{splineType} #{points.length}, #{points.join(', ')}"
                    self << "sturm" if sturm
                end
            end
            
            class Sphere < Base
                def initialize( centre, radius )
                    super( 'sphere' )
                    self << Methods::VectorRadius.new( centre, radius)
                end
            end

            class Torus < Base
                def initialize( majorRadius, minorRadius, sturm = false )
                    super( 'torus')
                    self << "#{majorRadius}, #{minorRadius}"
                    self << "sturm" if sturm
                end
            end
        end

        module FinitePatchPrimitives
            class Disc < Base
                def initialize( centre, normal, radius, holeRadius=0.0 )
                    super( 'disc' )
                    initline = "#{centre}, #{normal}, #{radius}"
                    initline += ", #{holeRadius}" if holeRadius != 0.0
                    self << initline
                end
            end

            class Polygon < Base
                def initialize( points )
                    super( 'polygon' )
                    self << "#{points.length}, #{points.join(', ')}"
                end
            end

            class Triangle < Base
                def initialize( corner1, corner2, corner3 )
                    super( 'triangle' )
                    self << "#{corner1}, #{corner2}, #{corner3}"
                end
            end

            class SmoothTriangle < Base
                def initialize( corner1, normal1, corner2, normal2, corner3, normal3 )
                    super( 'smooth_triangle' )
                    self << "#{corner1}, #{normal1}, #{corner2}, #{normal2}, #{corner3}, #{normal3}"
                end
            end
        end
        
        module InfiniteSolidPrimitives
            class Plane < Base
                def initialize( normal, distance )
                    super( 'plane' )
                    self << "#{normal}, #{distance}"
                end
            end
        end
    end

    module LightSources

        class LightSource < Base
            def initialize
                super( 'light_source' )
            end
        end

        class LightGroup < Base
            def initialize
                super( 'light_group' )
            end
        end
        
        class PointLight < LightSource
            def initialize( location, colour )
                super()
                self << Methods::MultiValue.new( [location,colour] )
            end
        end

    end

    module Atmosphere
        class Background < Base
            def initialize( colour )
                super( 'background' )
                self << colour
            end
        end
    end

    module Camera
        class Camera < Base
            def initialize
                super( 'camera' )
            end
        end

        class Basic < Camera
            def initialize( location, direction )
                # direct could be Methods::LookAt or Methods::Direction
                super()
                self << location
                self << direction
            end
        end
    end
    
    module Textures

        class Texture < Base
            def initialize
                super( 'texture' )
            end
        end

        module Pigments
            class Pigment < Base
                def initialize
                    super( 'pigment' )
                end
            end

            class SolidColour < Pigment
                def initialize( colour )
                    super()
                    self << colour
                end
            end

            class ColourList < Pigment
                def initialize( type, list )
                    super()
                    self << "#{type} #{list.join(',')}"
                end
            end

            class Brick < ColourList
                def initialize( colour1, colour2 )
                    super( "brick", [colour1,colour2] )
                end
            end

            class Checker < ColourList
                def initialize( colour1, colour2 )
                    super( "checker", [colour1,colour2] )
                end
            end

            class Hexagon < ColourList
                def initialize( colour1, colour2, colour3 )
                    super( "hexagon", [colour1,colour2,colour3] )
                end
            end
        end

        class Normal < Base
            def initialize
                super( 'normal')
            end
        end

        class Finish < Base
            def initialize
                super( 'finish' )
            end
        end

    end
    
    module CSG

        class Difference < Base
            def initialize
                super( 'difference' )
            end
        end
        
        class Union < Base
            def initialize
                super( 'union' )
            end
        end

        class Merge < Base
            def initialize
                super( 'merge' )
            end
        end

        class Intersection < Base
            def initialize
                super( 'intersection' )
            end
        end
        
    end

    module DataTypes
        module Vector
            module Common
                module TwoD
                    def x
                        @items[0]
                    end
                    def x=(x)
                        @items[0]=x
                    end

                    def y
                        @items[1]
                    end
                    def y=(y)
                        @items[1]=y
                    end
                end
            end
            class Generic
                def initialize( items )
                    @items = []
                    self.set( items )
                end
                def set( items )
                    @items.clear
                    @items.concat items
                end
                def to_s
                    "<#{@items.join(',')}>"
                end
            end
            class TwoD < Generic
                def initialize( x, y)
                    super( [x,y])
                end
                include Common::TwoD
            end
            class ThreeD < Generic
                def initialize( x, y, z)
                    super( [x,y,z])
                end
                include Common::TwoD
                def z
                    @items[2]
                end
                def z=(z)
                    @items[2]=z
                end
            end
        end
    end
    
    module Methods

        class MultiValue
            attr_reader :name
            def initialize( items, name='' )
                @name = name
                @items = []
                self.set( items )
            end
            def set( items )
                @items.clear
                @items.concat items
            end
            def to_s
                "#{name}#{name.length>0?' ':''}#{@items.join(',')}"
            end
        end

        class Vector < MultiValue
            def initialize( vector, name='' )
                super( [vector], '' )
            end
        end

        class VectorRadius < MultiValue
            def initialize( vector, radius, name='' )
                super( [vector,radius] )
            end
        end

        class Location < DataTypes::Vector::ThreeD
            def to_s
                "location #{super}"
            end
        end

        class Rotate < DataTypes::Vector::ThreeD
            def to_s
                "rotate #{super}"
            end
        end

        class Scale < DataTypes::Vector::ThreeD
            def to_s
                "scale #{super}"
            end
        end

        class Translate < DataTypes::Vector::ThreeD
            def to_s
                "translate #{super}"
            end
        end

        class LookAt < DataTypes::Vector::ThreeD
            def to_s
                "look_at #{super}"
            end
        end

        class Direction < DataTypes::Vector::ThreeD
            def to_s
                "direction #{super}"
            end
        end

        class Colour
            def initialize( colour )
                @colour = colour
            end
            def to_s
                "colour #{@colour}"
            end
        end

        class ColourRGB < Colour
            def to_s
                "rgb #{@colour}"
            end
        end

        class ColourRGBF < Colour
            def to_s
                "rgbf #{@colour}"
            end
        end

        class ColourRGBT < Colour
            def to_s
                "rgbt #{@colour}"
            end
        end

        class ColourRGBFT < Colour
            def to_s
                "rgbft #{@colour}"
            end
        end

        class Reflection
            def initialize( colour )
                @colour = colour
            end
            def to_s
                "reflection #{@colour}"
            end
        end

    end
end
