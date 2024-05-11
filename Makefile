ifndef SIZE
	override SIZE = 9
endif

ifndef LINE_DISTANCE
	override LINE_DISTANCE = 16
endif

ifndef STONE_THICKNESS
	override STONE_THICKNESS = 4
endif

.PHONY: stl
stl: clean
	mkdir -p stl
	openscad \
		-D stone_thickness=$(STONE_THICKNESS) -D size=$(SIZE) -D line_distance=$(LINE_DISTANCE) \
		--enable manifold \
		-q -o stl/goban.stl goban.scad
	echo "Written in stl/"

.PHONY: clean
clean:
	rm -f stl/*
