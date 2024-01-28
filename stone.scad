$fn = 50;

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

stone(19.5, 6, true);
