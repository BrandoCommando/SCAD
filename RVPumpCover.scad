part="bracket"; // [plate,bracket,both,together,bracket_test]
//70x120x22
mw=90;
mh=140;
md=30;
hinge_arm=8;
hinge_offset=4;
hinge_hole=3;
thick=3;

//translate([0,0,-2]) cube([10,20,2]);
//plate();
//translate([0,mh,md]) rotate([0,180,180])
if(part=="both")
{
  translate([mw*2+hinge_arm+hinge_hole,0,md]) rotate([0,180,0]) bracket();
  plate();
}
else if(part=="plate") plate();
else if(part=="bracket") translate([0,mh,md]) rotate([0,180,180]) bracket();
else if(part=="together") { plate(); bracket(); }
else if(part=="bracket_test") { bracket_test(); }

module bracket_test() {
  translate([hinge_arm-hinge_hole,thick*3]) hinge2();
  cube([thick,thick*8,thick*3+hinge_arm]);
}
module bracket(){
  difference(){
    union(){
  translate([-1*(hinge_arm-hinge_hole-thick),mh/2-thick,thick]) mirror([1,0,0]) hinge2();
  translate([0,0,thick])
  {
      cube([mw,thick,md-thick]);
      cube([thick,mh,md-thick]);
    translate([0,mh-thick,0])
      cube([mw,thick,md-thick]);
    translate([mw-thick,0,0])
    {
      cube([thick,mh,md-thick]);
      translate([hinge_arm-thick,mh/4-thick,0])
        hinge2();
        translate([hinge_arm-thick,(mh/4)*3-thick,0]) hinge2();
    }
    translate([0,0,md-thick])
    {
        cube([mw,mh,thick/2]);
    }
  }
  }
  translate([mw/2,thick,thick]) rotate([45,0,0]) cube([mw-thick,thick,thick],center=true);
  translate([thick,mh/2,thick]) rotate([0,45,0]) cube([thick,mh-thick,thick],center=true);
  translate([mw/2,mh-thick,thick]) rotate([45,0,0]) cube([mw-thick,thick,thick],center=true);
  translate([mw-thick,mh/2,thick]) rotate([0,45,0]) cube([thick,mh-thick,thick],center=true);
}
}

module plate() {
  translate([thick*2,thick*2,0]) screw_mount();
  translate([thick*2,mh-thick*4,0]) screw_mount();
  translate([mw-thick*4,mh-thick*4,0]) screw_mount();
  translate([mw-thick*4,thick*2,0]) screw_mount();
  translate([-1*(hinge_arm-hinge_hole-thick),mh/2-thick,thick]) mirror([1,0,0]) hinge();
difference(){
  cube([mw,mh,thick]);
  translate([thick*2,thick*2,-0.01]) cube([mw-thick*4,mh-thick*4,thick+0.02]);
}
translate([thick,thick,thick])
  cube([mw-thick*2,thick,1]);
translate([thick,thick,thick])
  cube([thick,mh-thick*2,1]);
translate([mw-thick*2,thick,thick]) {
  cube([thick,mh-thick*2,1]);
  translate([hinge_arm,mh/4-thick*2,0]) hinge();
  translate([hinge_arm,(mh/4)*3-thick*2,0]) hinge();
}
translate([thick,mh-thick*2,thick])
  cube([mw-thick*2,thick,1]);
}

module screw_mount()
{
  difference(){
    translate([3,3,0]) cylinder(d=8,h=thick,$fn=30);
    translate([3,3,-0.01]) cylinder(d=3,h=thick+0.02,$fn=30);
    translate([3,3,thick/2]) cylinder(d1=3,d2=5,h=thick/2+0.01,$fn=40);
  }
}

module hinge(){
    translate([hinge_arm*-1+0.01,0,thick*-1])
      cube([hinge_arm+thick+hinge_hole-0.01,thick*2,thick]);
    difference(){
      union(){
        cube([thick+hinge_hole,thick*2,hinge_offset]);
        translate([(thick+hinge_hole)/2,thick*2,hinge_offset]) rotate([90,0,0]) cylinder(d=thick+hinge_hole,h=thick*2,$fn=20);
      }
      translate([(thick+hinge_hole)/2,thick*3,hinge_offset]) rotate([90,0,0]) cylinder(d=hinge_hole,h=thick*4,$fn=20);
    }
}

module hinge_ramp() {
    hinge_ramp=hinge_arm+hinge_hole;
  translate([hinge_arm*-1+thick*2+0.01,0,hinge_hole+hinge_offset]) rotate([90,0,0]) linear_extrude(thick) polygon([[0,0],[hinge_ramp,0],[0,hinge_ramp]]);
}
module hinge2(){
  hinge_ramp();
  translate([0,thick*3]) hinge_ramp();
  difference(){
    union(){
      translate([hinge_arm*-1+thick+0.01,thick*-1,0])
        cube([hinge_arm+hinge_hole-0.01,thick*4,hinge_hole+hinge_offset]);
      translate([0,thick*-1,0])
      {
        cube([thick*2+hinge_hole,thick*4,hinge_offset+hinge_hole]);
//        translate([(thick+hinge_hole)/2,thick*4,hinge_offset]) rotate([90,0,0]) cylinder(d=thick+hinge_hole,h=thick*4,$fn=20);
      }
    }
    translate([-1*thick,-0.2,0])
      cube([hinge_arm+thick*2,thick*2+0.4,hinge_offset+thick*2]);
    translate([(thick+hinge_hole)/2,thick*4,hinge_offset]) rotate([90,0,0]) cylinder(d=hinge_hole,h=thick*8,$fn=29);
  }
}


//cube([mw,mh,md]);