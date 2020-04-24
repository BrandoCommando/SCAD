tw=90;
th=32;
sw=25;
difference(){
  union(){
    cube([tw,th,3]);
    translate([0,th-3,0]) {
      intersection(){
        cube([tw,3,20]);
        minkowski(){
          translate([5,0,0]) cube([tw-10,30,15]);
          sphere(5,$fn=20);
        }
      }
    }
    //translate([0,th-8,3]) cube([tw,5,5]);
    translate([5,th-3,15]) rotate([90,0,0]) cylinder(d=10,h=10,$fn=30);
    translate([tw/2,th-3,15]) rotate([90,0]) cylinder(d=10,h=10,$fn=30);
    translate([tw-5,th-3,15]) rotate([90,0]) cylinder(d=10,h=10,$fn=30);
    translate([0,th-13,3]) cube([10,10,12.5]);
    translate([tw/2-5,th-13,3]) cube([10,10,12.5]);
    translate([tw-10,th-13,3]) cube([10,10,12.5]);
  }
    translate([tw/2,8,-.01]) cylinder(d=8,h=5,$fn=20);
  //translate([-0.01,th-8,8]) rotate([0,90]) cylinder(d=10,h=tw+0.02,$fn=30);
  translate([tw/4,0]) scoop(d=sw,h=5);
  translate([tw*3/4,0]) scoop(d=sw,h=5);
  translate([5,th-13.01,15]) rotate([-90,0])  union(){ cylinder(d1=6,d2=4,h=1,$fn=25);cylinder(d=4,h=13.02,$fn=20);}
  translate([tw/2,th-13.01,15]) rotate([-90,0])  union(){ cylinder(d1=6,d2=4,h=1,$fn=25);cylinder(d=4,h=13.02,$fn=20);}
  translate([tw-5,th-13.01,15]) rotate([-90,0]) union(){ cylinder(d1=6,d2=4,h=1,$fn=25);
    cylinder(d=4,h=13.02,$fn=20);
  }
}
module scoop(d=15,h=3)
{
  translate([0,15,-0.01]) cylinder(d=d,h=h+.02,$fn=20);
  translate([-.5*d,5,-0.01]) cube([d,10,h+.02]);
  translate([0,5,-0.01]) cylinder(d=d,h=h+.02,$fn=20);
}