$fn = 50;

stone_side = 19;
line_distance = 20;
line = 1;

module stone(diameter, thickness, black)
{
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
            cube([diameter, 2, thickness], center=true);
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

module goban(side)
{
    thickness = 4;
    cube([line_distance * (side), line_distance * (side), thickness]);
    for (i = [0 : 1 : side-1])
    {
        echo(i)
        translate([line_distance/2 - line/2, line_distance/2 + i * line_distance - line/2, thickness])
            cube([line_distance*(side-1), line, 2]);

    }
}

goban(5);
