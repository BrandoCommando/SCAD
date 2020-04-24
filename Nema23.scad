motor();
module motor(){
  difference(){
    translate([-23,-23]) difference() {
      cube([56,56,53]);
      for(x=[-0.01,48.01],y=[-.01,48.01])
        translate([x,y,-.01]) cube([8,8,48]);
      for(x=[4.5,51.5],y=[4.5,51.5])
        translate([x,y,46.99]) cylinder(d=4,h=6.02,$fn=30);
    }
  }
}
module mount(){
}
module cap() {
difference(){
  union(){
    cylinder(d=14,h=10,$fn=50);
    translate([0,-1]) cube([10,2,10]);
  }
  translate([0,0,-.01]) {
    cylinder(d=8.5,h=10.02,$fn=60);
    for(r=[1:16]) rotate([0,0,r*(360/16)])
      rotate_extrude(angle=360/16/2) translate([4.2,0]) square([.8,10.02]);
  }
}
}