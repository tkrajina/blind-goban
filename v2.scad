$fn = 50;

stone_side = 20;

line_distance = 20;
line = 0.7;

thickness = 3;

module goban_base(side)
{
    difference()
    {
        cube([side * stone_side, side * stone_side, 3]);
        for (i = [0 : 1 : side-1])
        {
            for (j = [0 : 1 : side-1])
            {
                translate([stone_side * i + stone_side/2, stone_side * j + stone_side/2, 0])
                    stone_hole(stone_side / 2 - 1);
            }
        }
    }
}

module stone_hole(radius)
{
    translate([0, 0, 1])
        cylinder(5, radius, radius);
}

module stone(black)
{
    translate([0, 0, 2.75])
    {
        minkowski()
        {
            cylinder(0.5, stone_side / 2 - 1.5, stone_side / 2 - 1.5);
            sphere(1);
        }
    }
    cylinder(2, stone_side / 2 - 1.6, stone_side / 2 - 1.5);
   if (black)
   {
       minkowski() {
           translate([0, 0, 2.5])
               cylinder(thickness/2 + 0.5, 2, 2, center=false);
           sphere(0.5);
       }
   } 

}

translate([-stone_side, -stone_side, 0])
    stone();
translate([-stone_side, stone_side, 0])
    stone(true);
//stone_hole();
goban_base(2);

