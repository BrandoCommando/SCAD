inverse=1;
part="mold1";
if(part=="mold0")
{
  spatula_mink(1);
}
if(part=="mold1")
{
  mold_left();
  mold_mid();
  mold_right();
  mold_top();
} else if(part=="mold2") {
  rotate([0,-90]) mold_left();
  translate([10,20]) rotate([-90,0]) translate([-10,-85]) mold_mid();
  translate([62,0]) rotate([0,90]) translate([-62,0]) mold_right();
  rotate([90,0]) mold_top();
}
module mold_top() {
  intersection() {
    spatula_mink(1);
    color("blue") union() {
      translate([0,0,10]) cube([64,86,4]);
      cube([64,6,11]);
    }
  }
}
module mold_left() {
  intersection() {
    spatula_mink(1);
    translate([0,6.01]) cube([10,88,10]);
  }
}
module mold_mid() {
  intersection(){
    spatula_mink(1);
    translate([10,6.01]) cube([42,88,10]);
  }
}
module mold_right() {
  intersection(){
    spatula_mink(1);
    translate([52,6.01]) cube([20,88,10]);
  }
}

*translate([50,0]) spatula_old(inverse);
module spatula_mink(inverse=0) {
  difference() {
    translate([15,6,5])
      mirror([0,0,inverse]) diffif(inverse) {
        translate([-15,-7,-7]) cube([62,86,11]);
        translate([0,0,inverse?-3.01:0]) union() {
          difference() {
          minkowski() {
            linear_extrude(1) scale([0.8,0.8]) spatula_outline();
              intersection() {
            union() {
                //cylinder(d=15,h=1,$fn=25);
                translate([0,0,1]) cylinder(d1=15,d2=14,h=1,$fn=25);
                translate([0,0,2]) cylinder(d1=14,d2=10,h=1,$fn=25);
                translate([0,0,3]) cylinder(d1=10,d2=0,h=1,$fn=25);
                mirror([0,0,1]) cylinder(d1=15,d2=10,h=2,$fn=25);
            }
                translate([-7.5,0,-5]) cube([15,7.5,13]);
              }
          }
        if(!inverse) translate([16,-.01,2]) rotate([-90,0]) cylinder(d=6,h=60,$fn=30);
        }
        if(inverse)
        translate([16,-10,2]) {
          rotate([-90,0]) cylinder(d=6,h=20,$fn=40);
          *translate([-3,3,-14]) cube([6,8,14]);
        }
      }
    }
    if(inverse)
    {
      translate([3,-1,5.5]) rotate([-90,0]) cylinder(d=3,h=30,$fn=20);
      translate([-1,81,5.5]) rotate([0,90,0]) cylinder(d=3,h=24,$fn=20);
      translate([59,-1,5.5]) rotate([-90,0]) cylinder(d=3,h=30,$fn=20);
      translate([63,81,5.5]) rotate([0,-90]) cylinder(d=3,h=24,$fn=20);
      translate([30,81,-.01]) cylinder(d=3,h=20,$fn=20);
    }
  }
}
module spatula_old(inverse=0) {
mirror([0,0,inverse]) diffif(inverse) {
  translate([-5,-3,-3.99]) cube([50,90,9]);
  union(){
  difference() {
    translate([0,0,-4]) linear_extrude(8,convexity=5) spatula_outline();
    if(!inverse) translate([20,-.01]) rotate([-90,0]) cylinder(d=6,h=60,$fn=30);
    translate([0,0,-.5]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,.5]) {
    translate([-6,82]) rotate([-15-(m*30),0]) mirror([0,1,0]) cube([50,50,10]);
    translate([42,-5]) rotate([0,15+(m*30)]) mirror([1,0]) cube([50,90,10]);
    translate([-2,-5]) rotate([0,-15-(m*30)]) cube([50,90,10]);
      translate([0,82]) rotate([0,0,45]) rotate([-11-(m*30),0]) mirror([0,1,0]) translate([-25,0]) cube([50,50,10]);
      translate([40,81]) rotate([0,0,-45]) rotate([-11-(m*30),0]) mirror([0,1,0]) translate([-25,0]) cube([50,50,10]);
    }
  }
  if(inverse)
  translate([20,-10,-1]) {
    rotate([-90,0]) cylinder(d=6,h=20,$fn=40);
    translate([-3,3,-14]) cube([6,8,14]);
  }
}
}
}
module diffif(cond=1)
{
    if(cond>0)
      difference() {
        children(0);
        children(1);
      }
    else
      children(1);
}
module spatula_outline() {
  
      //square([35,75]);
      //*
      //translate([-2,0]) square([2,80]);
      hull() {
      translate([0,80]) circle(d=4,$fn=24);
      translate([27,67]) circle(d=30,$fn=40);
      translate([-2,0]) square([44,1]);
      }
      //translate([35,0]) square([7,72]);
      //translate([0,75]) square([32,7]);
  //*/
}