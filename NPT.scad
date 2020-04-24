bottom_side="18m"; // [14m:1/4" NPT Male,18m:1/8" NPT Male,316b:3/16" Barb,14b:1/4 Barb]
top_side="14f"; // [14m:1/4" NPT Male,18m:1/8" NPT Male,316b:3/16" Barb,14b:1/4 Barb]
nut_size="58"; // [916:9/16",12:1/2",716:7/16"]
hole_size=5;


// [Hidden]
nutsize = nutsize(nut_size == "916" ? 9/16 : (nut_size == "12" ? 1/2 : (nut_size == "716" ? 7/16 : (nut_size == "58" ? 5/8 : 0))));
bottom_height=bottom_side=="14m"?13:(bottom_side=="18m"?10:9);

echo(str("Nut Size: ",nutsize));

include<threads.scad>;
*translate([30,-6,-40]) import("1-4NPT_1-8NPT_m2m.stl");
difference() {
  union() {
    pickpart(bottom_side);
    
    translate([0,0,bottom_height]) cylinder(d1=bottom_side=="18m"?10:nutsize-4,d2=nutsize,h=2.01+(bottom_side=="18m"?2:0),$fn=6);
    translate([0,0,bottom_height+4]) cylinder(d=nutsize,h=3.02,$fn=6);
    /*
    translate([0,0,26]) cylinder(d1=8,d2=4.5,h=10,$fn=30);
    translate([0,0,36]) cylinder(d1=4.5,d2=4,h=10,$fn=30);
    */
    translate([0,0,bottom_height+18]) mirror([1,0]) mirror([0,0,1]) pickpart(top_side);
  }
  translate([0,0,bottom_height+1.99]) cylinder(d1=hole_size,d2=inches(.48),h=5.04,$fn=60);
  translate([0,0,-.01]) cylinder(d=hole_size,h=50,$fn=40);
  //*/
}

module pickpart(what)
{
  if(what=="14m") npt14();
  else if(what=="14f") difference() {
    cylinder(d=nutsize(5/8),h=12.98,$fn=6);
    translate([0,0,-.01]) npt14(0.02);
  }
  else if(what=="18m") npt18();
  else if(what=="316b") {
    translate([0,0,10]) mirror([0,0,1]) {
      cylinder(d1=8,d2=4.5,h=10,$fn=30);
      translate([0,0,10]) cylinder(d1=4.5,d2=4,h=8,$fn=30);
    }
  } else if(what=="14b") {
    cylinder(d2=10,d1=6,h=10,$fn=40);
    translate([0,0,-8]) cylinder(d2=6,d1=6,h=8,$fn=40);
  }
}

module npt14(kerf=-.02){
  //import("NPT_14m.stl");
  translate([0,0,13]) mirror([0,0,1]) mirror([1,0]) metric_thread(inches(0.52+kerf),25.4/18,13,groove=true,taper=1/16);
}
module npt18(kerf=.02){
  //import("NPT_18m.stl");
  translate([0,0,11]) mirror([0,0,1]) mirror([1,0]) metric_thread(inches(0.4+kerf),25.4/27,11,groove=true,taper=1/16);
}
function inches(in) = 25.4 * in;
function nutsize(nutsize_in) = inches(nutsize_in) / cos(30);
