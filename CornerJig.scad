boltd=6.35;
nutc=.5;
part="clamp";
//rotate([0,-90,0])
if(part=="all"||part=="base") {
base();
}
if(part=="all"||part=="clamp") {
clamp();
}
if(part=="all"||part=="ball") {
  clamp_ball(part!="ball");
}
if(part=="all"||part=="rest") {
  clamp_rest();
}
module base() {
difference(){
  cube([110,110,50]);
  translate([10,10,10]) cube([111,101,20]);
  translate([10,10,10]) cube([111,111,50]);
  translate([-.01,-.01,-.01]) cube([50,50,60]);
}
}
module clamp_rest() {
rotate([0,0,-45]) translate([-15,120,10]) {
  difference(){
    cube([30,20,30]);
    *for(x=[5,25],y=[5,15])
      translate([x,y,-.01]) cylinder(d=3.5,h=30.02,$fn=20);
    translate([15,5,-.01]) cylinder(d=3.5,h=10,$fn=20);
    translate([15,5,4]) cylinder(d=7.2,h=30,$fn=30);
    translate([15,-.01,15]) rotate([-90,0]) {
      cylinder(d=boltd,h=30,$fn=40);
      translate([0,0,-.01]) cylinder(d=boltd*2+nutc,h=10,$fn=6);
    }
  }
}
}
module clamp_ball(setup=1) {
  translate(setup?[75,75,25]:[]) rotate(setup?[0,0,-135]:[]) rotate(setup?[0,90]:[]) difference() {
      sphere(10,$fn=50);
      translate([0,0,-10.01]) cylinder(d=22,h=4,$fn=50);
      translate([0,0,-10.01]) cylinder(d=boltd,h=16,$fn=30);
  }
}
module clamp() {
translate([60,60,11]) {
  intersection(){
    cube([50,50,30]);
  difference(){union(){
    cube([50,10,30]);
    cube([10,50,30]);
      rotate([0,0,-45]) translate([-20,10]) cube([40,20,30]);
    }
    translate([15,15,14]) {
      sphere(12,$fn=50);
      cylinder(d1=20,d2=8,h=16.01,$fn=50);
    }
    translate([40,40,15]) rotate([0,0,45+180]) rotate([0,90]) {
     cylinder(d=boltd,h=40,$fn=40);
     //translate([0,0,26]) rotate([0,0,30]) cylinder(d=boltd*2+nutc,h=8,$fn=6); 
    }
  }
}
}
}
if(part=="all")
#translate([10,10,10]) cube([200,25.4*1.75,25.4*3.5]);
