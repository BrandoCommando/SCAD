base();

module base() {
  intersection(){
    *translate([-20,-20,4]) cube([40,40,2]);
    difference() {
      translate([-20,-20]) cube([40,40,6]);
      translate([0,0,2]) cylinder(d=33,h=6,$fn=50);
      translate([0,-10,-.01]) cylinder(d=4.5,h=6.02,$fn=30);
      rotate([0,0,-45]) translate([0,12.5,-.01]) cylinder(d=3.2,h=6.02,$fn=20);
      for(x=[-11.5,11.5],y=[-4,4])
        translate([x,y,-.01]) cylinder(d=3.2,h=6.02,$fn=20);
      for(x=[-16,16],y=[-16,16])
        translate([x,y,-.01]) cylinder(d=3,h=6.02,$fn=20);
    }
  }
}
module needle() {
difference(){
  union(){
    linear_extrude(3) {
      polygon([[-2,0],[-.5,20],[.5,20],[2,0]]);
      translate([0,20]) circle(d=1,$fn=20);
    }
    cylinder(d=6,h=5,$fn=30);
    cylinder(d1=6,d2=8,h=3,$fn=30);
  }
  translate([0,0,1]) cylinder(d=1.5,h=5,$fn=10);
}
}