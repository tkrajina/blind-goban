$fn = 50;

stone_side = 20;

line_distance = 20;
line = 0.7;

module stone(thickness, black)
{
    diameter = stone_side;
    resize([diameter, diameter, thickness])
        sphere(10);
    translate([0, 0, -thickness/2])
        cylinder(thickness/2, diameter/2 - 1, diameter/2);
   if (black)
   {
       minkowski() {
           cylinder(thickness/2 + 0.5, 2, 2, center=false);
           sphere(0.5);
       }
   } 
}

module stone2(thickness, black)
{
    diameter = stone_side;
    difference()
    {
        union()
        {
            resize([diameter, diameter, thickness])
                sphere(10);
            translate([0, 0, -thickness/2])
                cylinder(thickness/2, diameter/2*.9, diameter/2);
        }
        translate([0, 0, -thickness/2])
            cube([2, diameter, thickness], center=true);
        translate([0, 0, -thickness/2])
            cube([diameter, 2.25, thickness], center=true);
   }
   if (black)
   {
       minkowski() {
           translate([0, 0, .5])
               cylinder(thickness/2 + 0.5, 2, 2, center=false);
           sphere(0.5);
       }
   } 
}

module goban_base(side)
{
    hull()
    {
        translate([stone_side/2, stone_side/2, 0])
            cylinder(thickness, stone_side/2, stone_side/2);
        translate([stone_side/2 + line_distance * (side - 1), stone_side/2, 0])
            cylinder(thickness, stone_side/2, stone_side/2);
        translate([stone_side/2 + line_distance * (side - 1), stone_side/2 + line_distance*(side-1), 0])
            cylinder(thickness, stone_side/2, stone_side/2);
        translate([stone_side/2, stone_side/2 + line_distance*(side-1), 0])
            cylinder(thickness, stone_side/2, stone_side/2);
    }
}

module goban(side)
{
    thickness = 4;
    goban_base(side);
    for (i = [0 : 1 : side-1])
    {
        echo(i)
        translate([line_distance/2 - line/2, line_distance/2 + i * line_distance - line/2, thickness])
            cube([line_distance*(side-1) + line, line, 2.5]);
        translate([line_distance/2 + i * line_distance - line/2, line_distance/2 - line/2, thickness])
            cube([line, line_distance*(side-1), 2.5]);
    }
}

//goban_base(5);

//goban(9);

translate([0, -1 * stone_side, 0])
    stone2(6, true);

/*
translate([0, -2.5 * stone_side, 0])
    stone2(6, false);
*/
