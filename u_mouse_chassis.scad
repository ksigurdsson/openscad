include <u_mouse_defs.scad>
use     <u_mouse_caster.scad>

module chassis_base_plate ()
  {
   cylinder(h=chassis_thickness,r1=chassis_radius,r2=chassis_radius,$fn=1000);
   }

module drivetrain_holes (r) 
  {
   translate([-25, 0, 0]) cylinder(h=chassis_thickness, r1=r, r2=r);
   translate([+25, 0, 0]) cylinder(h=chassis_thickness, r1=r, r2=r);
   }

module wheel_cutouts ()
  {
   translate([+40, -30, 0]) cube(size= [20, 60, chassis_thickness]);
   translate([-60, -30, 0]) cube(size= [20, 60, chassis_thickness]);
   }

module chassis_base ()
  {
   difference()
   {
    chassis_base_plate();
    translate([0, -7, 0]) drivetrain_holes(1.5);
    wheel_cutouts();
    }
   }

module chassis ()
  {
   union ()
    {
     chassis_base();
     translate([0,-50,0]) mirror([0,0,1]) caster(10);
     translate([0,50,0]) mirror([0,0,1]) caster(10);
    }
   }
    chassis();
