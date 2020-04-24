part="back";
arduino_holes=[[-27,-7],[-27,20.9],[25.2,26.1],[23.825,-22.25]];
proto_holes=[[27,-10],[-17.9,-10],[26,25.5],[-17.7,25.5]];
holes=[[0,93],[0,54.6]];
right=20;
head_thickness=3;
part_clearance=0.25;
top=20;
brain_type="nano_shield";
brain_screw_size=2.5; // [2:5]
body_width=88; // [67:200]

// Body Depth (Head depth is based off this)
body_depth=80; // [68:200]

// Body Height
body_height=38; // [20:200]
body_thickness=1.75; // [0.25:0.25:8]
brain_screw_thru=1;

if(part=="both")
{
front_plate();
color("blue") translate([35,25,44]) rotate([0,180]) arduino_plate();
} else if(part=="front") {
  front_plate();
} else if(part=="back") {
  back_plate();
}
module back_plate() {
  ardoff=[0,0,4];
  difference() {
    union() {
      intersection() {
        translate([ardoff[0],ardoff[1]])
          //rotate([0,0,180])
          brain();
        translate([-86,-30,.01]) cube([127.8,68,20]);
      }
      translate([-86,-30,.01]) cube([127.8,68,2]);
      *translate([-41.5,-30,.01]) cube([83.5,68,2]);
      translate([40,-30,.01]) cube([2,66,28]);
      translate([-86,-32,.01]) cube([128,2,19.6]);
      translate([-86,36,.01]) cube([128,2,19.6]);
      translate([-88,-32,.01]) cube([2,70,10]);
      for(y=[30])
        translate([-80,y]) cylinder(d=7,h=12,$fn=30);
    }
    for(y=[30])
      translate([-80,y]) cylinder(d=3,h=12.02,$fn=20);
    translate(ardoff)
      //rotate([0,0,180])
      brain_holes();
    for(y=[-1.5,32,57])
      translate([37.02,y-25,24]) rotate([0,90,0]) cylinder(d=3,h=10,$fn=20);
  }
}
 
module front_plate() {
difference() {
  union() {
    translate([-7,-7,.01]) {
      for(y=[2,35,60])
        translate([2.2,y,12]) difference() {
          cube([2,8,12]);
          rotate([0,45,0]) cube(10);
        }
      cube([2.2,70,16]);
      cube([130,70,2.98]);
      cube([130,2,24.5]);
    }
    for(y=[30])
      translate([115,y+25]) difference() {
        cylinder(d=10,h=32.02,$fn=40);
        translate([0,0,4]) cylinder(d=3,h=30,$fn=20);
      }
    translate([-7,61,.01]) cube([130,2,24]);
    translate([121,-7,.01]) cube([2,70,34]);
    *translate([-5,-5,.01]) linear_extrude(3.98) {
      translate([5,0]) square([93,65]);
      translate([0,5]) square([103,55]);
      for(x=holes[0],y=holes[1])
        translate([x+5,y+5]) circle(r=5,$fn=40);
    }
    for(x=holes[0],y=holes[1])
      translate([x,y]) cylinder(d=10,h=10,$fn=40);
  }
  translate([87,27,15])
    rotate([0,0,180]) mirror([1,0]) brain_holes();
  translate([100,-7,24.52]) cube([20,2.2,10]);
  for(y=[-1.5,32,57])
    translate([-7.02,y,20]) rotate([0,90,0]) cylinder(d=3,h=10,$fn=20);
  translate([103,12]) {
    cube([13,15,4]);
    translate([2,18]) cube([9,16,4]);
  }
  translate([-2,7.5]) cube([97,40,4]);
  for(x=holes[0],y=holes[1])
    translate([x,y]) cylinder(d=3,h=40,$fn=20);
}
}

module brain_holes(brain_type=brain_type,
    right=(body_width-(body_thickness+part_clearance)*2)/2,
    top=(body_depth-(body_thickness+part_clearance)*2)/2-20) {
    blo=(brain_type=="uno_shield"||brain_type=="uno"?14:0);
    bto=(brain_type=="uno_shield"?4:(brain_type=="nano_shield"?-.5:0));
  if(brain_type=="nano_proto") {
    translate([right-2.76,-.2,20.5]) rotate([0,90]) rotate([0,0,90]) usb_mini();
  }
  if(brain_type=="nano_shield"||brain_type=="uno_shield"||brain_type=="uno")
  {
    translate([right-31.5-blo,top-12.5-bto,brain_screw_thru?-.01:head_thickness]) for(pos=arduino_holes) translate(pos) cylinder(d=brain_screw_size,h=3+head_thickness+.02,$fn=24);
  }
  if(brain_type=="nano_shield") {
    translate([0,top-12])
    {
      translate([0,0,1]) {
    translate([right+.01,18.163,12.875]) rotate([0,-90]) cylinder(d=8,h=4,$fn=24);
    translate([right-2.76,12.5,4.815]) cube([2.06,10.5,14.2]);
      }
    translate([right-2.76,-2.4,19.5]) rotate([0,90]) rotate([0,0,90]) usb_mini();
    }
  } else if(brain_type=="uno_shield"||brain_type=="uno") {
    translate([right-head_thickness-.01-5,top,7]) {
      cube([head_thickness+2.02,8.9+part_clearance*2,12+part_clearance*2]);
      translate([0,-31.7]) cube([head_thickness+3.02,12+part_clearance*2,12+part_clearance*2]);
    }
  }
} 
module brain(brain_type=brain_type,
  right=(body_width-(body_thickness+part_clearance)*2)/2,
  top=(body_depth-(body_thickness+part_clearance)*2)/2-20)
{
  blo=(brain_type=="uno_shield"||brain_type=="uno"?14:0);
  bto=(brain_type=="uno_shield"?4:(brain_type=="nano_shield"?-.5:0));
  translate([right-31.5-blo,top-12.5-bto]) {
  if(brain_type=="nano_shield"||brain_type=="uno_shield"||brain_type=="uno") {
    translate([-25.4,-25,2]) mirror([0,1]) cube([2,4.9+(top-12),3.9]);
    translate([-27-brain_screw_size/2,-8,2]) mirror([1,0]) cube([3-brain_screw_size/2+(right-34),2,3]);
    translate([-27-brain_screw_size/2,20,2]) mirror([1,0]) cube([3-brain_screw_size/2+(right-34),1.98,3]);
    translate([-25.375,29.075,2]) cube([2,1.5+bto,3.9]);
    translate([23.626,29.075,2]) cube([2,1.5+bto,3.9]);
    translate([27,25,2]) cube([4,2,3]);
    translate([22.877,-24,2]) mirror([0,1]) {
      translate([0,1.125]) cube([2,4.875+(top/2+bto-6),3.9]);
      cube([2,6,3]);
    }
    translate([0,0,1.99]) for(pos=arduino_holes)
      translate(pos) brain_screw();
  } else if(brain_type=="nano_proto") {
    translate([0,2,2]) cube([10,4,3]);
    translate([0,0,2]) for(pos=proto_holes)
       translate(pos) {
         difference() {
           union() {
             brain_screw();
             if(pos[1]>0)
              translate([-1,2]) cube([2,4,3]);
             else if(pos[0]>15)
               translate([0,-1]) cube([4,2,3]);
           }
           translate([0,0,-.01]) cylinder(d=2,h=4.02,$fn=20);
       }
     }
     }
  }
}
module brain_screw(brain_screw_size=brain_screw_size) {
  difference() {
    union(){
      cylinder(d=brain_screw_size+2.3,h=3,$fn=30);
      cylinder(d1=brain_screw_size+4,d2=brain_screw_size+2.3,h=1,$fn=30);
    }
    translate([0,0,-.01]) cylinder(d=brain_screw_size,h=4.02,$fn=20);
  }
}
module usb_mini() {
  translate([-.5,0]) scale(1.1)
  linear_extrude(3,convexity=10) {
    translate([0.6,0]) union() {
      translate([0,0.1]) square([8-1.202,4]);
      for(x=[0.1,6.7]) translate([x,0.1]) circle(r=0.1,$fn=20);
      translate([0.1,0]) square([6.6,4]);
    }
    mirrorx(3.999) translate([0.4,1.81]) difference() {
      square([0.2,0.2]);
      circle(r=0.2,$fn=20);
    }
    translate([0,2.008]) union() {
      translate([0.1,0.2]) square([7.8,1.9]);
      translate([0.2,0]) square([7.6,2.1]);
      translate([0,0.1]) square([8,1.9]);
      for(x=[0.2,7.8])
        translate([x,0.2]) circle(r=0.2,$fn=20);
      for(x=[0.1,7.9])
        translate([x,2]) circle(r=0.1,$fn=20);
    }
  }
}
module mirrory(offset=0)
{
  translate([0,offset,0]) for(m=[0,1]) mirror([0,m,0]) translate([0,offset*-1,0]) children();
}
module mirrorx(offset=0)
{
  translate([offset,0]) for(m=[0,1]) mirror([m,0]) translate([offset*-1,0]) children();
}