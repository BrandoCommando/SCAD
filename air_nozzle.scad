//upper ring around the laser lens 
airNozzleLaserMountThickness=6; //[5:8] 
// how big around the laser eye diameter is [13.5 is a k40 on a davinci)
airNozzleLaserMountRadius=13.5; // [13.5:20]
//how long this mount should be to sit flush should be at least double the size of the interior ring
airNozzleLaserMountLength=7.9248;
 //how big around the hole in the middle will be (NO AIR)
airNozzleTipMountRadius=2; // [2:8]
// size of the air tube on the side for mounting the hose
airNozzleAirTubeRadius=3.9624; 
// how round the air tube is
airNozzleAirTubeSides=20;  
//the length of the air tube for the hose connection 
airNozzleAirTubeLength=10;  // [10:20] 
//how long the down spout tube is (less = more angled tip)
airNozzleTubeLHeight=20; // [25:50] 
//how thick the down spout is
airNozzleWallThickness=6; // [5:8] 
// how big the interior tubes are, larger = more air flow (you MUST leave more then 1 mm between the size of the walls (airNozzleWallThickness and the size of the tubing (airInteriorTubeRadius) otherwise you will have holes in the walls
airInteriorTubeRadius=1.8; 
// how big the interior tubes are, larger = more air flow. This is the air inlet and upper air tubes.
airNozzleInteriorTubeRadius=3.175; 
set_screws=0;
pointerFocalZ = 54.8;
pointerDiameter = 18;
pointerProtrusion=41;
pointerFrontBuffer=6;
pointerHorizontalDistance=38;

airNozzleOffset=airNozzleWallThickness-airNozzleInteriorTubeRadius;
angle=atan((airNozzleLaserMountRadius-airNozzleTipMountRadius)/airNozzleTubeLHeight);
airNozzleLaserMountLengthAirHalfHeight=airNozzleLaserMountLength/2;

set_screw_angles=[-75:120:300];
pointerOffsetX = airNozzleLaserMountRadius+airNozzleLaserMountThickness-1;
pointerAngle = -atan((pointerHorizontalDistance+pointerOffsetX)/pointerFocalZ);
echo(str("Pointer Angle: ", -pointerAngle));
  rotate([0,0,-45]) translate([0,0,airNozzleTubeLHeight+airNozzleLaserMountLength]) mirror([0,0,1]) Nozzle();
%translate([0,0,pointerFocalZ]) sphere(d=5,$fn=10);
%color("red") cylinder(d=1,h=pointerFocalZ+20);
for(pr=[0,90]) rotate([0,0,pr])
  pointer_mount();
translate([40,40]) set_screw_ring();
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
  wallh=(pointerProtrusion-25)*sin(-pointerAngle);
  echo(str("WallH:",wallh));
  translate([pointerOffsetX,-5]) {
    difference() {
      union() {
        cube([pointerHorizontalDistance-10,10,4]);
        translate([-10,3]) cube([pointerHorizontalDistance-6,4,wallh]);
        *translate([20,-6]) cube([20,24,20]);
        translate([pointerHorizontalDistance,5]) rotate([0,pointerAngle]) translate([0,0,-14]) cylinder(d=pointerDiameter+4,h=pointerProtrusion,$fn=50);
      }
      translate([0,-15]) mirror([0,0,1]) cube([80,40,30]);
      translate([-pointerOffsetX,5,-.1]) {
        cylinder(r=airNozzleLaserMountRadius + airNozzleLaserMountThickness-.2,h=airNozzleLaserMountLength);
        translate([0,0,airNozzleLaserMountLength-.01])
          cylinder(h=airNozzleTubeLHeight, r2 = airNozzleTipMountRadius + airNozzleWallThickness-.2, r1 = airNozzleLaserMountRadius + airNozzleWallThickness-.2);
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
            translate([0, -airNozzleTubeLHeight - (airNozzleLaserMountLength /2),(airNozzleAirTubeLength /2 ) + airNozzleLaserMountRadius + airNozzleLaserMountThickness - 1])         
            cylinder(h = airNozzleAirTubeLength , r1 = airNozzleAirTubeRadius, r2 = airNozzleAirTubeRadius, center = true, $fn = airNozzleAirTubeSides);
            
            rotate([-90, 0,0]) // outer tube airhole
            translate([0, -airNozzleTubeLHeight - (airNozzleLaserMountLength /2),(airNozzleAirTubeLength /2 ) + airNozzleLaserMountRadius + airNozzleLaserMountThickness - 1]) 
            cylinder(h = airNozzleAirTubeLength  + 0.02, r1 = airNozzleInteriorTubeRadius, r2 = airNozzleInteriorTubeRadius, center = true, $fn = airNozzleAirTubeSides);
            };   

        difference(){  // laser mount 
            
            translate([0, 0,airNozzleTubeLHeight + (airNozzleLaserMountLength /2)])         
            cylinder(h = airNozzleLaserMountLength, r1 = airNozzleLaserMountRadius + airNozzleLaserMountThickness, r2 = airNozzleLaserMountRadius + airNozzleLaserMountThickness, center = true);
            
            
            translate([0, 0,airNozzleTubeLHeight+ (airNozzleLaserMountLength /2)])         
            cylinder(h = airNozzleLaserMountLength + 0.02, r1 = airNozzleLaserMountRadius + airNozzleLaserMountThickness - airNozzleLaserMountThickness, r2 = airNozzleLaserMountRadius + airNozzleLaserMountThickness - airNozzleLaserMountThickness, center = true);
            
            
            
            rotate([-90, 0,0]) // create air hole 
            translate([0, -airNozzleTubeLHeight - (airNozzleLaserMountLength /2),airNozzleLaserMountRadius + airNozzleLaserMountThickness+ (airNozzleAirTubeLength /2 )])
            cylinder(h = airNozzleAirTubeLength  + 0.02, r1 = airInteriorTubeRadius, r2 = airInteriorTubeRadius, center = true, $fn = airNozzleAirTubeSides);
                    
            
            difference(){ // inner air tube ring
                
                translate([0, 0, airNozzleTubeLHeight + (airNozzleLaserMountLength /2) ]) cylinder(h = airNozzleInteriorTubeRadius * 1.8, r1 = airNozzleLaserMountRadius + ( airNozzleLaserMountThickness  * .80 ) , r2 = airNozzleLaserMountRadius + (airNozzleLaserMountThickness * .80 ), center = true);
                
                
                translate([0, 0, airNozzleTubeLHeight + (airNozzleLaserMountLength /2) ]) cylinder(h = (airNozzleInteriorTubeRadius  * 1.8 )+ 0.02, r1 = airNozzleLaserMountRadius + ( airNozzleLaserMountThickness  * .20 ) , r2 = airNozzleLaserMountRadius + ( airNozzleLaserMountThickness  * .20 ), center = true);
        
                
                };
                // upper air tube 1
                    translate([0, airNozzleLaserMountRadius + (airNozzleLaserMountThickness * 0.50) ,airNozzleTubeLHeight])
                    cylinder(h = airNozzleLaserMountLength, r1 = airInteriorTubeRadius, r2 = airInteriorTubeRadius, center = true, $fn = airNozzleAirTubeSides);
            
             // upper air tube 2
                translate([0, -airNozzleLaserMountRadius- (airNozzleLaserMountThickness * 0.50),airNozzleTubeLHeight])
                cylinder(h = airNozzleLaserMountLength, r1 = airInteriorTubeRadius, r2 = airInteriorTubeRadius, center = true, $fn = airNozzleAirTubeSides);
            
            // inner air tube 3
                translate([-airNozzleLaserMountRadius -  (airNozzleLaserMountThickness * 0.50), 0,airNozzleTubeLHeight])
                cylinder(h = airNozzleLaserMountLength, r1 = airInteriorTubeRadius, r2 = airInteriorTubeRadius, center = true, $fn = airNozzleAirTubeSides);
                        // upper air tube 4
                translate([airNozzleLaserMountRadius  + (airNozzleLaserMountThickness * 0.50) , 0, airNozzleTubeLHeight   ])
                cylinder(h = airNozzleLaserMountLength , r1 = airInteriorTubeRadius, r2 = airInteriorTubeRadius, center = true, $fn = airNozzleAirTubeSides);

                
                rotate([-90, 0,0]) // outer tube airhole to inner connection
            translate([0, -airNozzleTubeLHeight - (airNozzleLaserMountLength /2),(airNozzleAirTubeLength /2 ) + airNozzleLaserMountRadius + airNozzleLaserMountThickness - 4])   
            cylinder(h = airNozzleAirTubeLength, r1 = airNozzleInteriorTubeRadius, r2 = airNozzleInteriorTubeRadius, center = true, $fn = airNozzleAirTubeSides);

               
           };
           
    
           difference(){        // down spout air hole
   
        
               translate([0, 0, airNozzleTubeLHeight/2 ])
               cylinder(h = airNozzleTubeLHeight, r1 = airNozzleTipMountRadius + airNozzleWallThickness, r2 = airNozzleLaserMountRadius + airNozzleWallThickness, center = true);
               
               translate([0, 0,airNozzleTubeLHeight/2])
               cylinder(h = airNozzleTubeLHeight + 0.02, r1 = airNozzleTipMountRadius + airNozzleWallThickness - airNozzleWallThickness, r2 = airNozzleLaserMountRadius + airNozzleWallThickness - airNozzleWallThickness, center = true);
           
            difference(){ //tubes inside the down spout
                // lower air tube 1 back side
            //rotate([angle, 0,0])
            //translate([0, -airNozzleWallThickness,airNozzleTubeLHeight])         
            //cylinder(h = airNozzleAirTubeLength * 2, r1 = airNozzleAirTubeRadius, r2 = airNozzleAirTubeRadius, center = true, $fn = airNozzleAirTubeSides);
            
            // lower inner air tube 1 back side
            rotate([angle, 0,0])
            translate([0, -airNozzleTipMountRadius - (airNozzleWallThickness * 0.45),airNozzleTubeLHeight])
            cylinder(h = airNozzleTubeLHeight * 2  + 0.02, r1 = airInteriorTubeRadius, r2 = airInteriorTubeRadius, center = true, $fn = airNozzleAirTubeSides);
            };   
            
            difference(){ // lower air tube 2 left side
                //rotate([0, angle,0])
                //translate([airNozzleWallThickness, 0,airNozzleTubeLHeight])
            //cylinder(h = airNozzleAirTubeLength * 2 , r1 = airNozzleAirTubeRadius, r2 = airNozzleAirTubeRadius, center = true, $fn = airNozzleAirTubeSides);
            
            // lower inner air tube 2 left side
                rotate([0, angle,0])
                translate([airNozzleTipMountRadius + (airNozzleWallThickness * 0.45), 0,airNozzleTubeLHeight])
            cylinder(h = airNozzleTubeLHeight * 2  + 0.02, r1 = airInteriorTubeRadius, r2 = airInteriorTubeRadius, center = true, $fn = airNozzleAirTubeSides);
            }; 
            
            difference(){ // lower air tube 3 right side
                //rotate([0, -angle,0])
            //translate([-airNozzleWallThickness, 0,airNozzleTubeLHeight])         
            //cylinder(h = airNozzleAirTubeLength * 2 , r1 = airNozzleAirTubeRadius, r2 = airNozzleAirTubeRadius, center = true, $fn = airNozzleAirTubeSides);
            
            // lower inner air tube 3 right side
                rotate([0, -angle,0])
            translate([-airNozzleTipMountRadius - (airNozzleWallThickness * 0.45), 0,airNozzleTubeLHeight])
            cylinder(h = airNozzleTubeLHeight * 2  + 0.02, r1 = airInteriorTubeRadius, r2 = airInteriorTubeRadius, center = true, $fn = airNozzleAirTubeSides);
            }; 
            
            difference(){ // lower air tube 4  front side
                //rotate([-angle, 0,0])
                //translate([0, airNozzleWallThickness,airNozzleTubeLHeight]) 
                   
            //cylinder(h = airNozzleAirTubeLength * 2 , r1 = airNozzleAirTubeRadius, r2 = airNozzleAirTubeRadius, center = true, $fn = airNozzleAirTubeSides);
                        // lower air tube 4 front side
                rotate([-angle, 0,0])
                translate([0, airNozzleTipMountRadius + (airNozzleWallThickness * 0.45),airNozzleTubeLHeight]) 
            //translate([airNozzleTubeLHeight + (airNozzleLaserMountLength /2), 0,airNozzleTubeLHeight/2])
            cylinder(h = airNozzleTubeLHeight * 2  + 0.02, r1 = airInteriorTubeRadius, r2 = airInteriorTubeRadius, center = true, $fn = airNozzleAirTubeSides);

            };     

    
    
    };

};
};

