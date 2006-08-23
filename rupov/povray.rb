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
                def initialize( leftCentre, leftRadius, rightCentre, rightRadius, open = false )
                    super( 'cone' )
                    self << Methods::VectorRadius.new( leftCentre, leftRadius)
                    self << Methods::VectorRadius.new( rightCentre, rightRadius)
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
                    self << Methods::MultiValue.new( [points.length]+points, splineType )
                    @sturm = sturm
                end
                def to_s
                    self << "sturm" if @sturm
                    result = super()
                    self.pop() if @sturm
                    result
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
                    self << Methods::MultiValue.new([majorRadius,minorRadius])
                    @sturm = sturm
                end
                def to_s
                    self << "sturm" if @sturm
                    result = super()
                    self.pop() if @sturm
                    result
                end
            end
        end

        module FinitePatchPrimitives
            class Disc < Base
                def initialize( centre, normal, radius, holeRadius=0.0 )
                    super( 'disc' )
                    multivalue = [centre,normal,radius]
                    multivalue << holeRadius if holeRadius != 0.0
                    self << Methods::MultiValue.new( multivalue )
                end
            end

            class Polygon < Base
                def initialize( points )
                    super( 'polygon' )
                    self << Methods::MultiValue.new( [points.length]+points )
                end
            end

            class Triangle < Base
                def initialize( corner1, corner2, corner3 )
                    super( 'triangle' )
                    self << Methods::MultiValue.new( [ corner1, corner2, corner3 ] )
                end
            end

            class SmoothTriangle < Base
                def initialize( corner1, normal1, corner2, normal2, corner3, normal3 )
                    super( 'smooth_triangle' )
                    self << Methods::MultiValue.new(
                        [   corner1, normal1,
                            corner2, normal2,
                            corner3, normal3 ] )
                end
            end
        end
        
        module InfiniteSolidPrimitives
            class Plane < Base
                def initialize( normal, distance )
                    super( 'plane' )
                    self << Methods::MultiValue.new([normal,distance])
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
                    self << Methods::MultiValue.new(list,type)
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
                module X
                    def x
                        @items[0]
                    end
                    def x=(x)
                        @items[0]=x
                    end
                end
                module Y
                    def y
                        @items[1]
                    end
                    def y=(y)
                        @items[1]=y
                    end
                end
                module Z
                    def z
                        @items[2]
                    end
                    def z=(z)
                        @items[2]=z
                    end
                end
                module R
                    def r
                        @items[0]
                    end
                    def r=(r)
                        @items[0]=r
                    end
                end
                module G
                    def g
                        @items[1]
                    end
                    def g=(g)
                        @items[1]=g
                    end
                end
                module B
                    def b
                        @items[2]
                    end
                    def b=(b)
                        @items[2]=z
                    end
                end
                module F
                    def f
                        @items[3]
                    end
                    def f=(f)
                        @items[3]=f
                    end
                end
                module XY
                    include X
                    include Y
                end
                module XYZ
                    include XY
                    include Z
                end
                module RGB
                    include R
                    include G
                    include B
                end
                module RGBF
                    include RGB
                    include F
                end
                module RGBT
                    include RGB
                    def t
                        @items[3]
                    end
                    def t=(t)
                        @items[3]=t
                    end
                end
                module RGBFT
                    include RGBF
                    def t
                        @items[4]
                    end
                    def t=(t)
                        @items[4]=t
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
            class XY < Generic
                def initialize( x, y)
                    super( [x,y])
                end
                include Common::XY
            end
            class XYZ < Generic
                def initialize( x, y, z)
                    super( [x,y,z])
                end
                include Common::XYZ
            end
            class RGB < Generic
                def initialize( r, g, b)
                    super( [r,g,b])
                end
                include Common::RGB
            end
            class RGBF < Generic
                def initialize( r, g, b, f)
                    super( [r,g,b,f])
                end
                include Common::RGBF
            end
            class RGBT < Generic
                def initialize( r, g, b, t)
                    super( [r,g,b,t])
                end
                include Common::RGBT
            end
            class RGBFT < Generic
                def initialize( r, g, b, f, t)
                    super( [r,g,b,f,t])
                end
                include Common::RGBFT
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

        class Include < MultiValue
            def initialize( filename )
                super( ["\"#{filename}\""], '#include' )
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

        class Location < MultiValue
            def initialize( location )
                super( [location], 'location' )
            end
        end

        class Rotate < MultiValue
            def initialize( rotate )
                super( [rotate], 'rotate' )
            end
        end

        class Scale < MultiValue
            def initialize( scale )
                super( [scale], 'scale' )
            end
        end

        class Translate < MultiValue
            def initialize( translate )
                super( [translate], 'translate' )
            end
        end

        class LookAt < MultiValue
            def initialize( lookAt )
                super( [lookAt], 'look_at' )
            end
        end

        class Direction < MultiValue
            def initialize( direction )
                super( [direction], 'direction' )
            end
        end

        class Colour < MultiValue
            def initialize( colour )
                super( [colour], 'colour' )
            end
        end

        class ColourRGB < MultiValue
            def initialize( colour )
                super( [colour], 'rgb' )
            end
        end

        class ColourRGBF < MultiValue
            def initialize( colour )
                super( [colour], 'rgbf' )
            end
        end

        class ColourRGBT < MultiValue
            def initialize( colour )
                super( [colour], 'rgbt' )
            end
        end

        class ColourRGBFT < MultiValue
            def initialize( colour )
                super( [colour], 'rgbft' )
            end
        end

        class Reflection < MultiValue
            def initialize( colour )
                super( [colour], 'reflection' )
            end
        end

    end
end
