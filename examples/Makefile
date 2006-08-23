.PHONY: all clean

default: all

all: test1.png

test1.png: test1.pov
	povray test1.pov

test1.pov: test1.rb
	ruby test1.rb >$@

clean:
	rm -f *.pov *.png
