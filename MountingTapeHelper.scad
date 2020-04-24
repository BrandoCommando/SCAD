iw=26;
ih=20;
difference() {
  translate([2,2]) hull() {
    *linear_extrude(2.4,convexity=3) offset(5,$fn=40) square([iw-4,ih-4]);
    for(x=[-2,iw-2],y=[-2,ih-2]) translate([x,y]) {
      cylinder(d1=3,d2=5,h=1,$fn=30);
      translate([0,0,1]) cylinder(d=5,h=1.4,$fn=30);
    }
  }
  translate([0,0,1.2]) linear_extrude(2,convexity=3) offset(.8,$fn=20) square([iw,ih]);
  for(x=[iw*3/8,iw*5/8]) translate([x,ih/2,-.01]) cylinder(d=3,h=3.02,$fn=20);
  *translate([-10,ih/2,2.4]) rotate([0,90]) cylinder(d=2,h=10,$fn=20);
}