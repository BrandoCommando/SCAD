part="box";
wall=2;
screwd=3;
if(part=="box") box(70,30,50);
else if(part=="box2") box(60,32,20);
else if(part=="box3") box3();
else if(part=="lid") lid(70,30,50);
else if(part=="lid2") lid(60,32,20);
else if(part=="all2") {
  box(60,32,20);
  translate([0,0,20]) color("green") box3();
  translate([0,0,42]) mirror([0,0,1]) lid(60,32,20);
}
else if(part=="both") {
  box();
  %translate([0,0,42]) mirror([0,0,1]) lid();
}

module lid(w=60,h=30,d=40){
  difference(){
    union(){
    cube([w,h,wall]);
        translate([wall+6.5,wall+.5,wall]) cube([w-18,h-5,wall]);
      translate([wall+.5,6+wall+.5]) cube([w-wall*2-1,13,4.02]);
    }
    translate([wall*2,wall*2,-.01]) cylinder(d=screwd,h=wall+.02,$fn=20); 
    translate([wall*2,h-wall*2,-.01]) cylinder(d=screwd,h=wall+.02,$fn=20);
    translate([w-wall*2,wall*2,-.01]) cylinder(d=screwd,h=wall+.02,$fn=20);
    translate([w-wall*2,h-wall*2,-.01]) cylinder(d=screwd,h=wall+.02,$fn=20);
        translate([wall+.49,6+wall+.49,-.01]) cube([14,13.92,5.02]);

  }
}
module box3(w=60,h=32,d=20){
  difference(){
    union(){
      difference(){
        cube([w,h,d]);
        translate([wall,wall,wall])
          cube([w-wall*2,h-wall*2,d]);
      }
      translate([wall,wall]) cube([6,6,d]);
      translate([w-wall-6,wall]) cube([6,6,d]);
      translate([wall,h-wall-6]) cube([6,6,d]);
      translate([w-wall-6,h-wall-6]) cube([6,6,d]);
    }
    translate([wall+2,wall+2,-.01]) cylinder(d=screwd,h=d+.02,$fn=20);
    translate([w-wall-2,wall+2,-.01]) cylinder(d=screwd,h=d+.02,$fn=20);
    translate([wall+2,h-wall-2,-.01]) cylinder(d=screwd,h=d+.02,$fn=20);
    translate([w-wall-2,h-wall-2,-.01]) cylinder(d=screwd,h=d+.02,$fn=20);
    translate([wall,wall+6,-.01]) cube([6,h-wall*2-12,2.02]);
  }
}
module box(w=60,h=30,d=40){
difference(){
  cube([w,h,d]);
  translate([wall,wall,wall])
    cube([w-wall*2,h-wall*2,d]);
}
translate([w-wall,wall,d-4-wall]) rotate([0,0,90]) screw_cliff();
translate([w-wall,h-wall,d-4-wall]) rotate([0,0,180]) screw_cliff();
translate([wall,wall,d-4-wall]) screw_cliff();
translate([wall,h-wall,d-4-wall]) rotate([0,0,-90]) screw_cliff();
translate([-2,0]) difference(){
  union(){
    translate([10,-10]) cylinder(d=16,h=2,$fn=20);
    translate([2,-10]) cube([16,10,2]);
  }
  translate([10,-10,-.01]) cylinder(d=5,h=2.02,$fn=20);
}
translate([w-18,0]) difference(){
  union(){
    translate([10,-10]) cylinder(d=16,h=2,$fn=20);
    translate([2,-10]) cube([16,10,2]);
  }
  translate([10,-10,-.01]) cylinder(d=5,h=2.02,$fn=20);
}
}

module screw_cliff() {
  difference(){
    //translate([3,3]) cylinder(d=8,h=6,$fn=20);
    cube(6);
    translate([2,2,-.01]) cylinder(d=screwd,h=6.02,$fn=20);
    translate([0,0,-1]) rotate([45,45,45]) cube(20);
    translate([-.01,-.01,-4]) cube([6.02,6.02,5]);
  }
}