type=2;
toparm=30;
botarm=20;
holesize=5;
hoff=2;
negative=0;
if(type==2)
{
  cylinder(d=20,h=20,$fn=50);
  cylinder(d=holesize,h=25,$fn=20);
} else {
difference() {
  union() {
    if(!negative)
    translate([0,0,5.5]) intersection(){
      translate([-6,0]) cube(20);
      translate([0,13,2]) rotate([0,-90]) cylinder(d=holesize,h=6,$fn=30);
    }
    translate([0,0,0]) linear_extrude(15,convexity=3) polygon([[0,0],[toparm-10,0],[0,10]]);
    *intersection(){
      cube(20);
    translate([2.4,2.4]) cylinder(d1=0,d2=20,h=6,$fn=4);
    }
    linear_extrude(15,convexity=3) {
      difference() {
      square([toparm,20]);
      translate([2.5,2.5]) square([toparm,18]);
      }
      translate([1.25,20]) circle(d=2.5,$fn=12);
      translate([toparm,1.25]) circle(d=2.5,$fn=12);
    }
  }
  if(negative)
  {
      translate([10,13+hoff,7.5]) rotate([0,-90]) cylinder(d=holesize,h=16,$fn=30);
      translate([toparm-7+hoff,13,7.5]) rotate([90,0]) cylinder(d=holesize,h=16,$fn=30);
  }
  *translate([-.01,13,7.5]) rotate([0,90,0]) cylinder(d=5,h=10,$fn=20);
  *translate([13,-.01,7.5]) rotate([-90,0]) cylinder(d=5,h=2.02,$fn=20);
}
}