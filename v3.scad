$fn = 50;

size = 9;
line_distance = 16;
stone_thickness = 4;

echo("size", size*line_distance);

hole_radius = (line_distance - 1) / 2;
stone_radius = hole_radius - 0.4;
board_thickness = stone_thickness + 1.5;

hoshi19 = [
    [3, 3], [3, 9], [3, 15],
    [9, 3], [9, 9], [9, 15],
    [15, 3], [15, 9], [15, 15],
];
hoshi13 = [
    [3, 3], [3, 9],
    [6, 6],
    [9, 3], [9, 9],
];
hoshi9 = [
    [2, 2], [2, 6],
    [6, 2], [6, 6],
];
hoshi3 = [ // For testing
    [0, 0]
];

hoshi = size == 19 ? hoshi19 : size == 13 ? hoshi13 : size == 9 ? hoshi9 : size == 3 || size == 2 || size == 1 ? hoshi3 : size == 2 ? hoshi3 : [];

module stone(black) {
    translate([0, 0, stone_thickness])
    union()
    {
        cylinder(stone_thickness * .1, stone_radius, stone_radius * .8);
        if (black)
        {
            minkowski()
            {
               h = .3;
               cylinder(h, 1, 1);
               sphere(1);
            }
        } 
    }
    cylinder(stone_thickness, stone_radius, stone_radius);
}

module goban() {
    for(v=[0:len(hoshi)-1]) {
        hoshi(hoshi[v][0], hoshi[v][1]);
    }
    difference()
    {
        hull()
        {
            cylinder(board_thickness, 2+line_distance / 2, 2+line_distance / 2);
            translate([(size - 1) * line_distance, 0, 0])
                    cylinder(board_thickness, 2+line_distance / 2, 2+line_distance / 2);
            translate([(size-1) * line_distance, (size-1) * line_distance, 0])
                    cylinder(board_thickness, 2+line_distance / 2, 2+line_distance / 2);
            translate([0, (size-1) * line_distance, 0])
                    cylinder(board_thickness, 2+line_distance / 2, 2+line_distance / 2);
        }
        for (i = [0 : 1 : size-1])
        {
            for (j = [0 : 1 : size-1])
            {
                translate([line_distance * i, line_distance * j, 1.51])
                {
                    cylinder(stone_thickness, hole_radius, hole_radius);
                }
            }
        }
    }
    for (i = [0 : 1 : size-1])
    {
        for (j = [0 : 1 : size-1])
        {
            translate([line_distance * i, line_distance * j, 1.51])
            {
                cylinder(0.5, hole_radius-2.5, hole_radius-2.5);
            }
        }
    }
}

module grid() {
    width = 1;
    for (i = [0 : 1 : size-1])
    {
        translate([i*line_distance-width/2, -width/2, 0])
            cube([width, line_distance * (size-1) + width, width]);
        translate([-width/2, i*line_distance-width/2, 0])
            cube([line_distance *   (size-1), width, width]);
    }
}

module hoshi(col, row) {
    r = 1.5;
    d = .5+r+stone_radius;
    translate([line_distance * col, line_distance * row, board_thickness])
        union() {
            translate([d/sqrt(2), d/sqrt(2), 0])
                cylinder(.5, r, r);
            translate([-d/sqrt(2), d/sqrt(2), 0])
                cylinder(.5, r, r);
            translate([-d/sqrt(2), -d/sqrt(2), 0])
                cylinder(.5, r, r);
            translate([d/sqrt(2), -d/sqrt(2), 0])
                cylinder(.5, r, r);
        }
    /*
        difference()
        {
            difference()
            {
                cylinder(h, hole_radius+1, hole_radius+1);
                translate([0, 0, -.5])
                    cylinder(h*3, hole_radius, hole_radius);
            }
            union()
            {
                rotate([0, 0, 0])
                    translate([-stone_radius/2, -1.5*stone_radius, 0])
                        cube([stone_radius/1, 3*stone_radius, h]);
                rotate([0, 0, 90])
                    translate([-stone_radius/2, -1.5*stone_radius, 0])
                        cube([stone_radius/1, 3*stone_radius, h]);
            }
        }
    */
}