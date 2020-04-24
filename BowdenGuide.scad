tw=42;
th=10;
bd=2;
td=10;
bbd=16;
bld=13;
difference(){
  union(){
    cube([tw,th,bd]);
    translate([tw/2,th/2,0]) {
      cylinder(d=bbd,h=td,$fn=40);
      translate([0,0,td]) cylinder(d1=bbd,d2=6,h=bbd-6,$fn=40);
      translate([0,0,td+bbd-6]) cylinder(d=6,h=2,$fn=30);
    }
  }
  translate([tw/2,th/2,-.01]) {
    cylinder(d=bld,h=td+.02,$fn=30);
    translate([0,0,td]) cylinder(d1=bld,d2=4.2,h=bbd-5.98,$fn=30);
    cylinder(d=4.2,h=40,$fn=20);
  }
  translate([tw/2-17.5,th/2,-.01]) cylinder(d=3.5,h=bd+.02,$fn=16);
  translate([tw/2+17.5,th/2,-.01]) cylinder(d=3.5,h=bd+.02,$fn=16);
}