shi=16;
shoesize=[20,20];
tallboy(60);
module tallboy(h=160) {
  linear_extrude(shi,convexity=3) {
    mirror([0,1]) translate([0,-16.5,0]) male();
    translate([-10,0]) square([20,h]);
    translate([0,h]) difference() {
      hull() {
        translate([-50,0]) square([100,6]);
        translate([-5,-30]) square([10,5]);
      }
      translate([0,1.5]) female2();
      for(m=[0,1]) mirror([m,0]) translate([-38,1.5]) female2();
    }
  }
}
module double() {
  difference() {
    linear_extrude(shi,convexity=3) {
      difference(){
        union() {
          translate([0,12]) mirror([0,1]) male();
          hull() {
            rotate([0,0,30]) translate([12,-12]) square([6.5,24]);
            rotate([0,0,150]) translate([12,-12]) square([6.5,24]);
          }
        }
        translate([-7,-2]) square([14,8]);
        rotate([0,0,30]) translate([4,0]) female();
        rotate([0,0,150]) translate([4,0]) female();
      }
    }
    translate([0,30,shi/2]) rotate([90,0]) cylinder(d=25.4/4,h=60,$fn=30);
  }
}
module triple() {
difference() {
  linear_extrude(shi,convexity=3)
  difference() {
    union() {
      intersection() {
        circle(d=40,$fn=36);
        translate([-16,-16]) square([32,32]);
      }
      male();
    }
    for(r=[0,180]) rotate([0,0,r]) translate([1.5,0]) {
      female();
    }
    translate([-9,-12]) square([18,25]);
  }
  translate([0,30,shi/2]) rotate([90,0]) cylinder(d=25.4/4,h=60,$fn=30);
}
}
module male() {
  translate([-5,16]) square([10,2]);
  translate([-8.5,18.8]) hull() {
    circle(d=1.6,$fn=12);
    translate([17,0]) circle(d=1.6,$fn=12);
    *square([18,1.6]);
  }
}
module female2() {
  rotate([0,0,90]) translate([-10,0]) female();
}
module female() {
  difference() {
    translate([10,-6]) square([5.1,12]);
    translate([13.75,-6]) circle(d=1.5,$fn=12);
    translate([13.75,6]) circle(d=1.5,$fn=12);
  }
    hull() {
      translate([11,-8]) intersection() {
        *for(y=[-1,17]) translate([0,y])
          circle(r=1,$fn=20);
        translate([-1,-2]) square([1,20]);
      }
      translate([11,-10]) square([2,20]);
    }
}
/*
difference() {
  cube([200,30,3]);
  for(x=[8,172]) translate([x,-.01,-.01]) cube([shoesize[0]+.01,shoesize[1]+.01,4.02]);
}
translate([200/2-shoesize[0]/2,0,3]) cube([shoesize[0],shoesize[1],4]);
*/