rotate([0,0,90]) rotate([90,0]) difference(){
  translate([-33,0]) {
    cube([156,20,3]);
    cube([3,20,31]);
    translate([153,0]) cube([3,20,31]);
  }
  for(x=[12,78])
    translate([x,10,-.01])
      cylinder(d=8,h=3.02,$fn=40);
}
//difference()
{
  intersection(){
    translate([1,-50]) cube([180,200,20]);
    union(){
      translate([33,45]) linear_extrude(20,convexity=2) outline(3) scale([.5,1]) circle(d=150,$fn=100);
    *translate([31,45]) difference(){
      scale([.5,1,1]) cylinder(d=150,h=20,$fn=200);
      translate([0,0,-.01])
        scale([.5,1,1]) cylinder(d=144,h=20.02,$fn=200);
      }
    }
  }
  intersection() {
    translate([0,-50]) cube([180,200,20]);
    translate([31,45]) for(r=[-90,90]) rotate([0,0,r]) translate([r!=0?75:36,0,5]) rotate([0,90]) {
      scale([2,1]) cylinder(d1=12,d2=8,h=10,$fn=30);
      translate([0,0,6]) scale([1.5,1]) cylinder(d=20,h=5,$fn=50);
    }
  }
}

module outline(t=2)
{
  difference() {
    minkowski() {
      children();
      circle(r=t,$fn=30);
    }
    children();
  }
}