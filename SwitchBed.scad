part="bottom";
//*
//*translate([-5,0]) cube([5,15,105]);
switch_tablet();//*/
//*tablet_case("top");
//*%translate([-15,48,52]) rotate([90,180,0]) joycon_left();
//%translate([-15,11,52]) rotate([90,180,180]) joycon_right();

module joycon_holder() {
  difference() {
    intersection() {
      cube([26,60,102]);
      cube2([26,60,107],5);
    }
    for(y=[5,40]) translate([0,y]) joycon_slider(0.2);
    for(y=[5,40]) translate([26,y]) mirror([1,0]) joycon_slider(0.2);
    for(y=[0,5])
      translate([1.5,25.5+y,80]) cube([23,4,32]);
    for(x=[6,11,16],y=[1.5,35.5])
      translate([x,y,80]) cube([4,23,32]);
  }
    translate([-20,20,-2]) intersection() {
      translate([0,0,2]) cube([66,19,6]);
      cube2([66,19,8],3);
    }
}
module joycon_slider(clearance=0,notch=1) {
  translate([1-clearance,1.25-clearance,10.6-clearance]) cube([2+clearance*2,11+clearance*2,106.5+clearance*2]);
  translate([-.01,3.1-clearance,14.8-clearance]) cube([2+clearance*2,7.2+clearance*2,102.4+clearance*2]);
  if(notch)
    translate([-.01,1.25-clearance,70.5]) cube([2+clearance*2,11+clearance*2,46.5+clearance*2]);
  translate([1.12-clearance,3.1-clearance,10.6-clearance]) cube([1+clearance*2,7.2+clearance*2,106.5+clearance*2]);
}
module tablet_case(part=part) {
rotate([part=="top"?180:0,0,part=="top"?180:0]) difference() {
intersection(){
  if(part!="both")
    translate([-92,-5,part=="bottom"?0:16]) {
      cube([184,113,20]);
      if(part=="bottom")
        translate([3,3,19.99]) linear_extrude(4,convexity=3) difference() {
          square([178,107]);
          *translate([2,2]) square([174,103]);
        }
    }
  difference(){
    translate([-92,-5,4]) cube2([184,113,20],3);
    translate([-87,-1,9]) rotate([90,0,90]) linear_extrude(174,convexity=3) {
      translate([4,0]) square([96,14]);
      translate([2,12]) square([100,2]);
      translate([0,4]) square([104,part=="bottom"?12:8]);
      translate([4,4]) circle(r=4,$fn=30);
      translate([100,4]) circle(r=4,$fn=30);
      translate([2,12]) circle(r=2,$fn=24);
      translate([102,12]) circle(r=2,$fn=24);
    }
  }
}
  if(part=="top") {
    translate([-92+2.5,-5+2.5]) cube([184-5,113-5,20]);
  }
}
}

module switch_full() {
translate([0,0,16]) rotate([-90,0]) {
import("Nintendo_Switch/files/-w-_Tablet_no_LED.stl");
  color("blue") translate([-102,0.7,52]) rotate([270,0,180]) joycon_left();
  color("red") translate([102,0.7,52]) rotate([270,0,180]) joycon_right();
}
}
module switch_tablet() {
  difference() {
    import("Nintendo_Switch/files/-w-_Tablet_no_LED.stl");
    translate([13,0,-1]) linear_extrude(8,convexity=3) hull() { circle(d=4,$fn=24); translate([4.8,0]) circle(d=4,$fn=24); }
  }
}
module joycon_left() {
  import("Nintendo_Switch/files/-z-_Joycon_LF.stl");
  translate([0,.6]) rotate([180,0]) import("Nintendo_Switch/files/-z-_Joycon_LB.stl");
}
module joycon_right() {
  import("Nintendo_Switch/files/-z-_Joycon_RF.stl");
  translate([0,0]) rotate([180,0]) import("Nintendo_Switch/files/-z-_Joycon_RB.stl");
}

module cube2(dims,r=5)
{
  intersection() {
    cube(dims);
    translate([r,r,r]) minkowski() {
      cube([dims[0]-r*2,dims[1]-r*2,dims[2]-r*2]);
      sphere(r=r,$fn=r*7);
    }
  }
}