// nice (and horribly long) variable names for Thingiverse Customizer

// Height of the coupler, half for the motor shaft and half for the rod
couplerHeight = 40;
// External diameter of the coupler
couplerExternalDiameter = 22;
couplerSmallDiameter = 18;
// Diameter of the motor shaft
motorShaftDiameter = 5;
// Diameter of the rod
threadedRodDiameter = 7.9;
// Diameter of the screw thread
screwDiameter = 3.2;
screwHeadDiameter = 6;
screwThreadLength = 8;
// Width across flats of the nut (wrench size)
nutType = 2;
nutWidth = 5.8;
nutThickness = 3;
// Gap between the two halves
halvesDistance = 1;
shaftNotch=1;

/* [Hidden] */
// end of Customizer variables
// Portion of the shaft inside the coupler
shaftLen = couplerHeight/2-4;
// Portion of the rod inside the coupler
rodLen = couplerHeight/2-4;
shaftScrewsDistance = motorShaftDiameter+screwDiameter+4;
rodScrewsDistance = threadedRodDiameter+screwDiameter+2;
shaftScrewsDistance = couplerExternalDiameter/2+2;
rodScrewsDistance = couplerExternalDiameter/2+2.5;

$fa = 0.02;
$fs = 0.25;
little = 0.01; // just a little number
big = 100; // just a big number

!coupler();
intersection() {
  coupler();
  translate([couplerExternalDiameter*-.5,couplerExternalDiameter*-.5]) cube([couplerExternalDiameter*.5,couplerExternalDiameter,50]);
}
translate([1,0]) intersection() {
  coupler();
  mirror([1,0]) translate([couplerExternalDiameter*-.5,couplerExternalDiameter*-.5]) cube([couplerExternalDiameter*.5,couplerExternalDiameter,50]);
}

module coupler()
{
    mid=couplerHeight/2;
    rad=couplerExternalDiameter/2;
    difference()
    {
        // main body
        mirrorz(couplerHeight) {
          cylinder(d1=couplerSmallDiameter,d2=couplerExternalDiameter,h=4);
          translate([0,0,4]) cylinder(d=couplerExternalDiameter, h=mid-12);
          translate([0,0,mid-8]) cylinder(d1=couplerExternalDiameter,d2=couplerSmallDiameter,h=4);
          translate([0,0,mid-4]) cylinder(d=couplerSmallDiameter,h=4);
        }
        // flex
        for(i=[-14:.1:14])
          rotate([0,0,(i*25)+45]) translate([0,0,mid+(i/4)-.31]) linear_extrude(.61,convexity=3) polygon([[0,0],[rad,-2],[rad+2,0],[rad,2]]);
        // shaft
        translate([0,0,mid-4.01]) cylinder(d=4,h=8.03);
        translate([0,0,-little])
          difference() {
            cylinder(d=motorShaftDiameter, h=shaftLen+2*little);
            if(shaftNotch)
              translate([motorShaftDiameter*-.5,motorShaftDiameter*-.5]) cube([0.5,motorShaftDiameter,shaftLen+2*little]);
          }
        // rod
        translate([0,0,couplerHeight+little]) mirror([0,0,1])
            cylinder(d=threadedRodDiameter, h=rodLen);
        // screws
        translate([0,shaftScrewsDistance/2,min(8,shaftLen/2)])
            rotate([90,0,90])
                screw();
        translate([0,-shaftScrewsDistance/2,min(8,shaftLen/2)])
            rotate([90,0,270])
                screw();
        rotate([0,0,90])
        translate([0,rodScrewsDistance/2,couplerHeight-min(8,rodLen/2)])
            rotate([90,0,90])
                screw();
        rotate([0,0,90])
        translate([0,-rodScrewsDistance/2,couplerHeight-min(8,rodLen/2)])
            rotate([90,0,270])
                screw();
        // cut between the two halves
        for(z=[-.01,couplerHeight/2+5.01]) rotate([0,0,z>0?90:0]) translate([halvesDistance*-.5,big*-.5,z]) cube([halvesDistance,big,couplerHeight/2-5]);
    }
    
}

module screw()
{
    // thread
    cylinder(d=screwDiameter, h=big, center=true);
    // head
    translate([0,0,(screwThreadLength-nutThickness)/2])
        cylinder(d=screwHeadDiameter, h=big);
    // nut
    translate([0,0,-(screwThreadLength-nutThickness)/2])
        rotate([180,0,30])
            if(nutType==1)
              cylinder(d=nutWidth*2*tan(30), h=big, $fn=6);
            else
              rotate([0,0,30]) translate([-3,-3]) cube([16,6,2.6]);
}


module mirrorz(off) {
  translate([0,0,off*.5]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,off*-.5]) children();
}