.PHONY: stl
stl:
	 #openscad -q -o stone.stl stone.scad
	 #openscad -q -o v2.stl v2.scad
	 openscad --enable manifold -q -o v3.stl v3.scad
