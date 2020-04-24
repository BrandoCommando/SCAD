thick=8;
necklen=30;
hookang=300;
hookr=12;
hsupport=0;

intersection() {
  translate([-30,-60,-2]) cube([110,120,100]);
  union() {
    rotate([0,0,19.5]) {
      rotate_extrude(angle=hookang-20,$fn=50) {
        translate([hookr,0]) profile();
      }
      rotate([0,0,hookang-20]) translate([hookr,0]) difference() {
        sphere(d=thick,$fn=20);
        //translate([-5,-5,-5]) cube([10,10,4]);
      }
      translate([hookr*1.5,0]) rotate_extrude(angle=70,$fn=50) {
        translate([hookr/-2,0]) profile();
      }
    }
    if(hsupport)
    {
      translate([0,0,thick/-2]) linear_extrude(thick-3,convexity=3) {
        hull() {
          translate([hookr+10,0]) circle(d=4,$fn=30);
          translate([necklen+30,-30]) circle(d=4,$fn=30);
        }
        hull() {
          rotate([0,0,30]) translate([hookr,0]) circle(d=4,$fn=30);
          rotate([0,0,0]) translate([hookr+5,0]) circle(d=4,$fn=30);
          translate([necklen+30,0]) circle(d=4);
          translate([necklen+30,30]) circle(d=4,$fn=30);
        }
      }
    }
    translate([hookr*1.4,0]) rotate([90,0,90]) linear_extrude(necklen,convexity=3) profile();
    translate([15+necklen,0]) rotate([-90,0,90]) cylinder(d1=20,d2=6,h=15,$fn=40);
    translate([necklen+17,-30,-2]) difference() {
      intersection() {
        translate([-4,-4]) cube([8,84,20]);
        minkowski() {
          cube([5,60,16]); 
          sphere(d=4,$fn=20);
        }
      }
      for(y=[52,8]) translate([-2.01,y,8]) rotate([0,90,0]) {
        cylinder(d=5,h=10,$fn=30);
        cylinder(d1=9,d2=5,h=2,$fn=30);
        translate([-10,-2.5,0]) cube([10,5,8]);
      }
    }
  }
}
module profile() {
  //difference() {
    circle(d=thick,$fn=20);
    *translate([-5,-5]) square([10,4]);
  //}
}