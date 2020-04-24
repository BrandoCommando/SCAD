/** [Global] **/
// Part to Print
part="mount"; // [grip:Tool Grip,mount:Tool Mount,clamp:Mount Clamp,all:Preview All Together]
// Quick Slide Type
qs_type=4; // [1:Half Cube,2:Dot,3:Something Else,4:Flat Edge]

/** [Mount Options] **/
// Mount Height
mount_height=118; // [20:150]
// Add Legacy Grip Holes?
mount_holes=1; // [1:Yes,0:No]
// Add Quick Slide Notches? (If not, grips won't work)
mount_quick_slide=0; // [1:Yes,0:No]
z_screw=3; // [3:3mm,4:4mm]
mount_hole_screw=3; // [3:3mm,4:4mm]

/** [Grip Options] **/
// Inner Diameter (if > 80, make sure to set Y-Offset, 19=Bottom of Dremel)
id=64; // [0:.2:100]
// Thickness
grip_thick=4; // [0.5:0.5:10]
// Y Offset
yoff=0; // [0:40]
// Grip Bottom Curve
grip_bottom_curve=4; // [0:10]

/** [Hidden] **/

if(part=="mount")
  mount();
else if(part=="grip")
  router_grip();
else if(part=="clamp")
  mount_clamp();
else if(part=="all")
{
  mount();
  router_grip();
  mount_clamp();
}

module mount_clamp() {
    for(m=part=="all"?[0,1]:[0]) mirror([m,0])
      translate([34.5,52]) {
        if(part=="all") pipe(200);
        rotate([part=="all"?0:-90,0,part=="all"?180+135:0]) difference(){
          intersection(){
            cylinder(d=20.8,h=104,$fn=50);
            translate([-12,-12]) cube([24,12,104]);
          }
          for(z=[22.5,97.5])
          translate([0,0,z]) rotate([-90,0]) {
            translate([0,0,-25]) cylinder(d=3,h=40,$fn=20);
            translate([0,0,-6]) cylinder(d=7.5,h=10,$fn=6);
          }
        }
      }
}
function nut_size(bolt_d) = (bolt_d==3?6.7:(bolt_d==4?7.8:bolt_d*1.5/cos(30)));
module router_grip() {
difference(){
  union(){
    intersection(){
      cylinder(d=74,h=11,$fn=100);
      translate([-33,10]) cube([66,40,11]);
    }
    translate([0,yoff*-1]) cylinder(d=id+grip_thick*2,h=11,$fn=100);
    hrx=(33-(id+grip_thick*2)/2);
    hry=(yoff+10);
    hrd=sqrt(pow(hrx,2)+pow(hry,2));
    hr=atan(hrx/hry);
    for(m=[0,1]) mirror([m,0]) {
      translate([-33,10]) rotate([0,0,hr]) mirror([0,1,0]) translate([0,id>70?-10:0]) cube([10+yoff,hrd+(id>70?10:0),11]);
      //translate([-33,
    }
    for(m=[0:1]) mirror([m,0])
    translate([0,-2]) rotate([0,0,62]) translate([32,-2]) rotate([0,0,-47]) difference() {
      union(){
        translate([0,-10]) cube([15,16.2,11]);
        translate([15,-10]) mirror([1,0]) rotate([0,0,-68]) cube([8,8,11]);
        *translate([8.5,-15]) rotate([0,0,-18]) translate([-.5,-10]) cube([5,17,11]);
        if(qs_type==1)
          translate([5,1,11]) cube([6,5,2.5]);
        else if(qs_type==2)
          union() {
          translate([5.75,1,11]) cube(5);
          translate([8.25,5,13.5]) sphere(d=5,$fn=50);
          }
        else if(qs_type==3)
          union() {
            translate([6,4.2,11]) cube([5,2,5]);
            translate([8.2,4.2,13.5]) rotate([-90,0]) cylinder(d1=4,d2=3,h=5,$fn=20);
          }        
      }
      if(qs_type==1)
      translate([8,0,13.5]) rotate([-90,0]) cylinder(d=3,h=20,$fn=20);
      translate([5.7,8.2,-.01]) mirror([1,0,0]) rotate([0,0,180]) dovetail(10.02,.3);
    }
    if(qs_type==4)
    {
      translate([-30,27]) cube([60,12,11]);
      translate([-30,34,11]) difference() {
        cube([60,5,12]);
        for(x=[6:24:54])
        translate([x,-.01,6]) rotate([-90,0]) {
          cylinder(d1=8,d2=4,h=2,$fn=30);
          cylinder(d=4,h=8,$fn=20);
        }
      }
    }
    translate([0,yoff*-1]) translate([-2-grip_thick,id*-.5-grip_thick-10]) cube([4+grip_thick*2,12,11]);
  }
  translate([0,yoff*-1]) if(grip_bottom_curve) {
    translate([0,0,grip_bottom_curve+1]) minkowski() {
      cylinder(d=id-grip_bottom_curve*2,h=20,$fn=100);
      sphere(d=grip_bottom_curve*2,$fn=30);
    }
    translate([0,0,-.01]) cylinder(d=id-grip_bottom_curve*2,h=20,$fn=100);
  } else
    translate([0,0,-.01]) cylinder(d=id,h=20.02,$fn=100);
  translate([0,yoff*-1]) {
    translate([-2,id*-.5-grip_thick*2-10,-.01]) cube([4,30,20]);
    translate([-2.01-grip_thick,id*-.5-grip_thick/2-6,5.5]) rotate([0,90,0]) cylinder(d=3,h=grip_thick*2+4.02,$fn=20);
  }
}
}

module mount(h=118) {
  //rotate([0,0,180])
  *%translate([0,41]) translate([-105,-87.75,0]) import("Mostly_Printed_CNC_525_-Updated_5_25_16-/files/C-ToolMount.STL");
  difference() {
    union() {
      for(x=[-35,35])
      translate([x,52]) {
          rotate([0,0,x==35?-135:90-135]) translate([.2,-6]) {
            cube([17,12,h]);
        }
      }
      union(){
        intersection()
        {
          difference(){
            translate([0,-52.7]) cylinder(d=200,h=h,$fn=150);
            translate([0,3,-.01]) cylinder(d=70,h=h+.02,$fn=150);
          }
          union(){
          translate([-26,36]) cube([52,10,h]);
          translate([-18.5,32]) cube([37,20,h]);
          }
        }
        for(m=[0,1]) mirror([m,0]) {
          rotate([0,0,130]) translate([35,-4]) rotate([0,0,35]) {
            translate([0,-8.525]) cube([12,5,h]);
            if(mount_quick_slide) {
              for(z=[0:25:h-5])
              translate([2,-5,z]) dovetail(10);
            }
          }
        }

      }
    }
    translate([0,3,-.01]) cylinder(d=70,h=h+.02,$fn=150);
    for(x=[-34.5,34.5],z=[5,30,55,80])
      translate([x,52]) rotate([0,0,x>0?-135:90-135]) {
      translate([0,0,-.01]) cylinder(d=24,h=h+.02,$fn=80);
        translate([-.01,0,z+17.5]) rotate([0,90]) {
          cylinder(d=z_screw+.5,h=30,$fn=20);
          *translate([0,0,23]) cylinder(d1=3,d2=7.2,h=4,$fn=30);
          translate([0,0,22]) cylinder(d=8,h=20,$fn=30);
        }
      }
    if(mount_holes)
    for(z=[5:25:h-10],m=[0,1])
      mirror([m,0])
      rotate([0,0,130]) translate([35,-3,z+3.5]) rotate([0,0,35]) translate([4,0,5]) rotate([90,0]) {
        cylinder(d=mount_hole_screw+.5,h=20,$fn=20);
        rotate([0,0,0]) translate([0,0,12]) cylinder(d=nut_size(mount_hole_screw)+.2,h=10,$fn=6);
      }
    else if(mount_quick_slide)
      for(z=[0:25:h-5],m=[0,1])
        mirror([m,0]) rotate([0,0,130]) translate([35,-4]) rotate([0,0,35])
              translate([2,-5,z+12]) cube([5,8,3]);
  }
}

module dovetail(h,clearance=0)
{
  difference() {
    linear_extrude(h) polygon([[clearance*-1,0],[clearance*-1,6+clearance],[6+clearance,6+clearance],[3.5+clearance,0]]);
    *rotate([60,0]) translate([-5,0,-11]) cube([15,20,10]);
  }
}

module pipe(length=100)
{
  difference(){
    cylinder(d=23.5,h=length,$fn=50);
    translate([0,0,-.01])
      cylinder(d=21.2344,h=length+.02,$fn=40);
  }
}