WallThickness = 3;
Airgap = .5;
Mount = 3;
TotalHeight = 11; 		//this includes the ball
MountScrewRad = 1.5;  	//3mm screw
BallProtrude = .30; 	//percentage of ball radius sticking out 
ScrewSpacing = 25;		//spaceing of the mountholes center to center
MountMiddle = false; 	//mount in the center
MountBase = false;		//use mount base 2 holes

module caster (BallSize=10) {

  cylrad = (BallSize/2) + WallThickness + Airgap;
                             
   difference()
   {
     union ()
          {
           ball_mount (cylrad, BallSize);
           if(MountBase)
           { 
             base(cylrad);
             }
           }

    if(MountMiddle)
    {
     cylinder(r1 = MountScrewRad, r2 = MountScrewRad, h= TotalHeight,center=true, $fn=30);
     translate([0,0,(TotalHeight-BallSize)/2]) 
     {
      cylinder(r1 = MountScrewRad*2, r2 = MountScrewRad*2, h= TotalHeight, $fn=30);
      }
     }
    }
 }

module ball_mount (cylrad, BallSize)
{
	difference () 
	{
		cylinder(r1 = cylrad , r2 = cylrad,  TotalHeight - (BallSize*BallProtrude));
	
		translate([0,0,TotalHeight - BallSize/2]) 
		{
			cube(size = [cylrad*2+5, cylrad/2, BallSize*1.25], center = true );
			rotate([0,0,90]) cube(size = [cylrad*2+5, cylrad/2, BallSize*1.25], center = true );
		}
	
		translate([0,0,TotalHeight - (BallSize/2)]) 
		{
			%sphere (BallSize/2+Airgap, $fa=5, $fs=0.1);
		}
	}
}
module base(cylrad)
{
	difference (){
		linear_extrude(height=Mount)
		hull() {
			translate([ScrewSpacing/2,0,0]) {
				circle(  MountScrewRad*3);
			}
			translate([0-ScrewSpacing/2,0,0]) {
				circle( MountScrewRad*3);
			}
			circle( cylrad);
		}
	
		translate([ScrewSpacing/2,0,-1]) {
			#cylinder(r1 = MountScrewRad, r2 = MountScrewRad, h= Mount+2,$fn=30);
		}
		translate([0-ScrewSpacing/2,0,-1]) {
			#cylinder(r1 = MountScrewRad, r2 = MountScrewRad, h= Mount+2,$fn=30);
			
		}
	}
}
