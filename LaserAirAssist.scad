//upper ring around the laser lens 
airNozzleLaserMountThickness=7; //[5:8] 
// how big around the laser eye diameter is [13.5 is a k40 on a davinci)
airNozzleLaserMountRadius=13.4; // [13.5:20]
//how long this mount should be to sit flush should be at least double the size of the interior ring
airNozzleLaserMountLength=7.9248;
 //how big around the hole in the middle will be (NO AIR)
airNozzleTipMountRadius=4; // [2:8]
// size of the air tube on the side for mounting the hose
airNozzleAirTubeRadius=4.5; 
// how round the air tube is
airNozzleAirTubeSides=40;  
//the length of the air tube for the hose connection 
airNozzleAirTubeLength=10;  // [10:20] 
//how long the down spout tube is (less = more angled tip)
airNozzleTubeLHeight=30; // [25:50] 
//how thick the down spout is
airNozzleWallThickness=6; // [5:8] 
// how big the interior tubes are, larger = more air flow (you MUST leave more then 1 mm between the size of the walls (airNozzleWallThickness and the size of the tubing (airInteriorTubeRadius) otherwise you will have holes in the walls
airInteriorTubeRadius=1.6; 
airTubeOffset=1.8;
// how big the interior tubes are, larger = more air flow. This is the air inlet and upper air tubes.
airNozzleInteriorTubeRadius=3.175; 
$fn=80;
pointerFocalZ = 50.8+8;
pointerDiameter = 13;
pointerProtrusion=40;
pointerFrontBuffer=6;
pointerHorizontalDistance=20; // [15:40]
airTubeCount=1;

// [Hidden]
air_tube_angles=[180];
pointer_angles=[];
airNozzleOffset=airNozzleWallThickness-airNozzleInteriorTubeRadius;
angle=atan((airNozzleLaserMountRadius-airNozzleTipMountRadius)/airNozzleTubeLHeight);
airNozzleLaserMountLengthAirHalfHeight=airNozzleLaserMountLength/2;

set_screw_angles=[-15,90,195];
pointerOffsetX = airNozzleLaserMountRadius+airNozzleLaserMountThickness-1;
pointerAngle = -atan((pointerHorizontalDistance+pointerOffsetX)/pointerFocalZ);
echo(str("Pointer Angle: ", -pointerAngle));
  rotate([0,0,-45]) translate([0,0,airNozzleTubeLHeight+airNozzleLaserMountLength]) mirror([0,0,1]) intersection() {
      Nozzle();
      cylinder(d=100,h=airNozzleTubeLHeight+airNozzleLaserMountLength);
    }
%translate([0,0,pointerFocalZ]) sphere(d=5,$fn=10);
%color("red") cylinder(d=1,h=pointerFocalZ);
if(len(pointer_angles)>0)
intersection() {
  for(pr=pointer_angles) rotate([0,0,pr])
    pointer_mount();
  translate([-20,-20]) cube([100,100,23]);
}
*translate([40,40]) set_screw_ring();
module set_screw_ring()
{
  difference() {
  union() {
    cylinder(r=pointerOffsetX,h=7);
    for(mr=set_screw_angles) rotate([0,0,mr]) translate([pointerOffsetX-1,-5]) cube([6,10,7]);
    
  }
  translate([0,0,-.02]) cylinder(h = 8.04, r1 = airNozzleLaserMountRadius + airNozzleLaserMountThickness - airNozzleLaserMountThickness, r2 = airNozzleLaserMountRadius + airNozzleLaserMountThickness - airNozzleLaserMountThickness);
    for(mr=set_screw_angles) rotate([0,0,mr]) translate([pointerOffsetX,0,1.1]) {
      translate([6.1,0,3]) rotate([0,-90]) cylinder(d=3,h=20,$fn=20);
    translate([0,-3,-.1]) cube([3,6,6.1]);
    }

}
}
module pointer_mount() {
  wallh=sqrt(pow(pointerProtrusion-30,2)-pow(pointerHorizontalDistance-38,2));
  wallh=(pointerProtrusion-10)*sin(-pointerAngle);
  echo(str("WallH:",wallh));
  translate([pointerOffsetX,-5]) {
    difference() {
      union() {
        cube([pointerHorizontalDistance,10,4]);
        translate([-10,3]) cube([pointerHorizontalDistance,4,wallh]);
        *translate([20,-6]) cube([20,24,20]);
        translate([pointerHorizontalDistance,5]) rotate([0,pointerAngle]) translate([0,0,-14]) difference() {
          union() {
            cylinder(d=pointerDiameter+4,h=pointerProtrusion,$fn=50);
            translate([pointerDiameter/2,-4.11,pointerProtrusion/2-7]) cube([6.22,8.22,11]);
          }
          
          translate([pointerDiameter/2+2,-4.11,pointerProtrusion/2-7]) {
            translate([0,-.01]) rotate([0,45]) cube(10);
            translate([0,1.22,4]) cube([3,6,8]);
          }
          translate([0,0,pointerProtrusion/2]) rotate([0,90]) cylinder(d=3,h=20,$fn=20);
        }
      }
      translate([0,-15]) mirror([0,0,1]) cube([80,40,30]);
      translate([-pointerOffsetX,5,-.1]) {
        cylinder(r=airNozzleLaserMountRadius + airNozzleLaserMountThickness-.2,h=airNozzleLaserMountLength);
        
        translate([0,0,airNozzleLaserMountLength-.01])
          cylinder(h=airNozzleTubeLHeight, r2 = airNozzleTipMountRadius + airNozzleWallThickness - airNozzleWallThickness, r1 = airNozzleLaserMountRadius + airNozzleWallThickness - airNozzleWallThickness);
      }
      translate([pointerHorizontalDistance,5,-.01]) rotate([0,pointerAngle]) {
        translate([0,0,-14]) cylinder(d=pointerDiameter,h=pointerProtrusion-pointerFrontBuffer,$fn=40);
        cylinder(d=6,h=100,$fn=30);
        %color("red") cylinder(d=1,h=100,$fn=4);
      }
    }
  }
}

module Nozzle(){
    
    echo("angle=", angle);    
    union(){
            
        difference(){ // air nozzle
            rotate([-90, 0,0])
            translate([0, -airNozzleTubeLHeight - (airNozzleLaserMountLength /2),(airNozzleAirTubeLength /2 ) + airNozzleLaserMountRadius + airNozzleLaserMountThickness - 1]) {
            cylinder(h = airNozzleAirTubeLength , r1 = airNozzleAirTubeRadius, r2 = airNozzleAirTubeRadius, center = true, $fn = airNozzleAirTubeSides);
              mirror([1,0]) translate([0,0,airNozzleAirTubeLength/2]) translate([-10,0]) rotate([90,0]) rotate_extrude(angle=140) {
                translate([10,0]) difference() { union() {
                circle(r=airNozzleAirTubeRadius,$fn=airNozzleAirTubeSides); 
                translate([0,airNozzleAirTubeRadius/2]) square([airNozzleAirTubeRadius*2,airNozzleAirTubeRadius],center=true);
                  }
                
                circle(r=airNozzleInteriorTubeRadius,$fn=airNozzleAirTubeSides);
                }
              }
              translate([0,airNozzleAirTubeRadius/-2]) cube([airNozzleAirTubeRadius*2,airNozzleAirTubeRadius,airNozzleAirTubeLength],center=true);
          }
            
            rotate([-90, 0,0]) // outer tube airhole
            translate([0, -airNozzleTubeLHeight - (airNozzleLaserMountLength /2),(airNozzleAirTubeLength /2 ) + airNozzleLaserMountRadius + airNozzleLaserMountThickness - 1]) 
          {
            cylinder(h=airNozzleAirTubeLength,r=airNozzleInteriorTubeRadius-0.8,center=true,$fn=airNozzleAirTubeSides);
            translate([0,0,2]) cylinder(h = airNozzleAirTubeLength  + 0.02, r1 = airNozzleInteriorTubeRadius, r2 = airNozzleInteriorTubeRadius, center = true, $fn = airNozzleAirTubeSides);
            };   
          }

        difference(){  // laser mount 
            
            translate([0, 0,airNozzleTubeLHeight + (airNozzleLaserMountLength /2)])         
            cylinder(h = airNozzleLaserMountLength, r1 = airNozzleLaserMountRadius + airNozzleLaserMountThickness, r2 = airNozzleLaserMountRadius + airNozzleLaserMountThickness, center = true);
          
          for(ssa=set_screw_angles)
            rotate([0,0,ssa+45]) translate([airNozzleLaserMountRadius + 1.6,-3,airNozzleTubeLHeight + airNozzleLaserMountLength - 6.5]) {
              cube([3,6,10]);
              translate([-3,3,3]) rotate([0,90]) cylinder(d=3,h=20,$fn=20);
            }
            
            
            translate([0, 0,airNozzleTubeLHeight+ (airNozzleLaserMountLength /2)])         
            cylinder(h = airNozzleLaserMountLength + 0.02, r1 = airNozzleLaserMountRadius + airNozzleLaserMountThickness - airNozzleLaserMountThickness, r2 = airNozzleLaserMountRadius + airNozzleLaserMountThickness - airNozzleLaserMountThickness, center = true);
            
            
            
            rotate([-90, 0,0]) // create air hole 
            translate([0, -airNozzleTubeLHeight - (airNozzleLaserMountLength /2),airNozzleLaserMountRadius + airNozzleLaserMountThickness+ (airNozzleAirTubeLength /2 )])
            cylinder(h = airNozzleAirTubeLength  + 0.02, r1 = airInteriorTubeRadius, r2 = airInteriorTubeRadius, center = true, $fn = airNozzleAirTubeSides);
                    
            
            difference(){ // inner air tube ring
              
               rotate([0,0,180+air_tube_angles[0]]) union(){
              rotate_extrude(angle=air_tube_angles[len(air_tube_angles)-1]-air_tube_angles[0]+1) {
                translate([airNozzleLaserMountRadius + (airNozzleLaserMountThickness * 0.48),airNozzleTubeLHeight + 2]) circle(r=airNozzleInteriorTubeRadius*.6,$fn=20);
                 translate([0,airNozzleTubeLHeight + airNozzleLaserMountLength/2-2]) square([airNozzleLaserMountRadius + (airNozzleLaserMountThickness *.8),4.7]);
              }
                *translate([0, 0, airNozzleTubeLHeight + (airNozzleLaserMountLength /2) + .5]) cylinder(h = airNozzleInteriorTubeRadius * 1.8 -1, r1 = airNozzleLaserMountRadius + ( airNozzleLaserMountThickness  * .80 ) , r2 = airNozzleLaserMountRadius + (airNozzleLaserMountThickness * .80 ), center = true);
            }
                
                translate([0, 0, airNozzleTubeLHeight + (airNozzleLaserMountLength /2) ]) cylinder(h = (airNozzleInteriorTubeRadius  * 1.8 )+ 0.02, r1 = airNozzleLaserMountRadius + ( airNozzleLaserMountThickness  * .20 ) , r2 = airNozzleLaserMountRadius + ( airNozzleLaserMountThickness  * .20 ), center = true);
        
                
                };
                for(atr=air_tube_angles) rotate([0,0,180+atr])
                    translate([0, airNozzleLaserMountRadius + airTubeOffset + airInteriorTubeRadius ,airNozzleTubeLHeight])
                    cylinder(h = airNozzleLaserMountLength, r1 = airInteriorTubeRadius, r2 = airInteriorTubeRadius, center = true, $fn = airNozzleAirTubeSides);
                
                rotate([-90, 0,0]) // outer tube airhole to inner connection
            translate([0, -airNozzleTubeLHeight - (airNozzleLaserMountLength /2),(airNozzleAirTubeLength /2 ) + airNozzleLaserMountRadius + airNozzleLaserMountThickness - 4])   
            cylinder(h = airNozzleAirTubeLength, r1 = airNozzleInteriorTubeRadius, r2 = airNozzleInteriorTubeRadius, center = true, $fn = airNozzleAirTubeSides);

               
           };
           
    
           difference(){        // down spout air hole
   
              union() {
               *translate([0, 0, airNozzleTubeLHeight/2 ])
               cylinder(h = airNozzleTubeLHeight, r = airNozzleTipMountRadius + 2, r2 = airNozzleLaserMountRadius + 2, center = true);
               *translate([0, 0, airNozzleTubeLHeight - 10 ])
               cylinder(h = 10, r1 = airNozzleTipMountRadius + 2, r2 = airNozzleLaserMountRadius + airNozzleLaserMountThickness);
                for(atr=air_tube_angles) rotate([0,0,atr])
            difference(){ //tubes inside the down spout
            // lower inner air tube 1 back side
            rotate([angle, 0,0])
            translate([0, -airNozzleTipMountRadius - airTubeOffset/2 - airInteriorTubeRadius, 2])
            cylinder(h = airNozzleTubeLHeight * 1.185, r = airInteriorTubeRadius + airNozzleWallThickness/4, $fn = airNozzleAirTubeSides);
              translate([0,0,-.01]) mirror([0,0,1]) cylinder(d=30,h=5);
            }
              }
              translate([0,0,airNozzleTubeLHeight]) cylinder(h=airNozzleLaserMountLength+.02,r=airNozzleLaserMountRadius);
               
               *translate([0, 0,airNozzleTubeLHeight/2])
               cylinder(h = airNozzleTubeLHeight + 0.06, r1 = airNozzleTipMountRadius + airNozzleWallThickness - airNozzleWallThickness, r2 = airNozzleLaserMountRadius + airNozzleWallThickness - airNozzleWallThickness, center = true);
           
            for(atr=air_tube_angles) rotate([0,0,atr])
            difference(){ //tubes inside the down spout
            // lower inner air tube 1 back side
            rotate([angle, 0,0])
            translate([0, -airNozzleTipMountRadius - airTubeOffset/2 - airInteriorTubeRadius])
            translate([0,0,2]) {
              rotate([-160,0]) cylinder(h=6,r=airInteriorTubeRadius,$fn=airNozzleAirTubeSides);
              sphere(r=airInteriorTubeRadius,$fn=airNozzleAirTubeSides);
              cylinder(h = airNozzleTubeLHeight * 2  + 0.02, r1 = airInteriorTubeRadius, r2 = airInteriorTubeRadius, $fn = airNozzleAirTubeSides);
            }
            };   
            

    };

};
};

