$fn=40;
  difference() { union() {
linear_extrude(5,convexity=3) {
  square([10,50]);
  square([50,10]);
  //translate([5,50]) circle(r=5);
  //translate([50,5]) circle(r=5);
}
linear_extrude(2)
intersection(){
  square([100,100]);
  rotate([0,0,45]) {
    square([100,5]);
    translate([100,2.5]) circle(d=5);
  }
}
linear_extrude(2) hull()
{
   translate([5,45]) circle(r=2.5);
  rotate([0,0,45]) translate([60,2.5]) circle(r=2.5);
}
  }
  translate([5,5,-.01]) cylinder(d=5,h=5.02);
  translate([30,5,-.01]) linear_extrude(6,convexity=3) mirror([0,1]) difference() {
      offset(0.4) text("FINDER",size=5,valign="center",halign="center",font="Open Sans",spacing=1.2);
    translate([-1.5,-.4]) square([2,.8]);
    translate([10.7,.8]) rotate([0,0,90]) square([0.8,2]);
  }
  translate([5,30,-.01]) rotate([0,0,-90]) linear_extrude(6,convexity=3) difference() {
      offset(0.4) mirror([0,1]) text("CENTER",size=5,valign="center",halign="center",font="Open Sans",spacing=1.2);
    translate([10,-1.4]) square([2,0.8]);
  }
  *translate([5,5,2]) for(r=[0,90]) rotate([0,0,r]) hull() {
    cylinder(d=5,h=5);
    translate([40,0]) cylinder(d=5,h=5);
  }
}
