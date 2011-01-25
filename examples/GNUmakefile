WIDTH = 800
HEIGHT = 600
QUALITY = 11

POVRAY = povray -D Antialias=1 Width=$(WIDTH) Height=$(HEIGHT) Quality=$(QUALITY)

PNGFILES = $(subst .rb,.png,$(wildcard *.rb))
POVFILES = $(subst .rb,.pov,$(wildcard *.rb))

.PHONY: all clean

default: all

all: $(PNGFILES)

$(PNGFILES): %.png: %.pov
	$(POVRAY) $<

$(POVFILES): %.pov: %.rb include/genericscene.rb ../lib/rupov.rb
	ruby $< >$@

clean:
	rm -f *.pov *.png
