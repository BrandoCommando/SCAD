*%translate([-102.5,-101.8]) import("660_Low_Mount_V1.STL");
*translate([0,9.1,-34.5]) mount();

intersection(){
  *translate([-45,1,0]) cube([90,80,40]);
translate([0,0,9.5]) mirror([0,0,1]) difference(){
  bottom_mount();
  clamp_holes();
  mount_holes();
  translate([0,9,-34.5]) mount(mount_holes=0);
  dw660();
}
}
module clamp_holes() {
  mirrorx() translate([-41.5,1]) {
    translate([7.5,-.01,7]) rotate([-90,0]) {
      cylinder(d=3,h=10,$fn=30);
      translate([0,0,5]) rotate([0,0,30]) cylinder(d=6.4,h=4,$fn=6);
    }
    translate([19.5,0]) mirror([1,0]) translate([0,0]) rotate([0,0,45]) mirror([1,0]) translate([-1,-4]) cube(20);
    mirrory(7) translate([0,0]) rotate([0,0,45]) mirror([1,0]) translate([-1,-4]) cube(20);
    mirrorz(14) for(rz=[0,90]) rotate([0,0,rz]) 
    rotate([135,0,0]) translate([-1,-4,-1]) cube([20,5,5]);
  }
}
module mount_holes() {
  mirror([0,0,1])
  mirrorx() translate([5,9.5,-9.5]) rotate([0,0,130-90]) translate([0,35,0]) rotate([0,0,35])
      for(z=[5.4,30.4]) translate([-.01,6.5,z]) rotate([0,90]) {
        cylinder(d=4,h=15,$fn=30);
        translate([0,0,-15]) cylinder(d=8,h=15.01,$fn=40);
      }
}
module bottom_mount() {
  mirrorx() translate([-41.5,1])
    difference() {
      cube([16,7,14]);
      mirrorz(14) translate([0,7]) rotate([-45,0]) translate([0,-1,-2]) cube(20);
    }

  translate([0,0,.04]) mirror([0,0,1])
  {
    difference(){
        translate([-20,32,-14]) union() {
          hull()
          {
            translate([0,-8,.02]) cube([40,19,14]);
            translate([-4,7,14]) cube([48,14,20]);
          }
          translate([0,5,24]) cube([40,14,13.5]);
        }
      
      translate([0,13.1,-.01]) cylinder(d1=38,d2=50,h=14,$fn=80);
      translate([0,13.1,13.98]) cylinder(d=50,h=20,$fn=80);
    }
    mirrorx() translate([5,9.5,-9.5]) rotate([0,0,130-90]) translate([0,35]) rotate([0,0,35])
        translate([0,0,-4.5]) {
          translate([2.5,0,2.5]) cylinder(d=5,h=35,$fn=30);
          translate([2.5,0,37.5]) rotate([-90,0]) {
            sphere(d=5,$fn=30);
            cylinder(d=5,h=10,$fn=30);
          }
          translate([0,0,2.5]) {
            cube([5,10,35]);
            translate([2.5,0]) rotate([-90,0]) cylinder(d=5,h=10,$fn=30);
          }
          translate([2.5,10,2.5]) {
            cylinder(d=5,h=35,$fn=30); 
            sphere(d=5,$fn=30);
            translate([0,0,35]) sphere(d=5,$fn=30);
          }
          linear_extrude(19,convexity=4) polygon([[-3,2],[0,0],[5,4],[2.5,10]]); //cube([3,10,19]);
        }
  }

  translate([0,0,.01]) union() {
    intersection() {
      cylinder(d=65,h=9.48,$fn=100);
      translate([-33,1,0]) cube([66,33,9.48]);
    }
    intersection() {
      difference() {
        cylinder(d=65,h=14,$fn=80);
        translate([0,0,-.01])
          cylinder(d=50,j=14.02,$fn=80);
      }
      translate([-33,1]) cube([66,33,14]);
    }
    intersection() {
      *translate([0,11.5]) cylinder(r=47-11.5,h=14,$fn=100);
      
      translate([-20,18,.01]) cube([40,29,14]);
    }
  }
}
module dw660() {
  union() {
    cylinder(d1=47.2,d2=46,h=1,$fn=100);
    cylinder(d=46,h=9.5,$fn=100);
    translate([0,0,8.99]) cylinder(d1=46,d2=46.6,h=.5,$fn=100);
      mirrorx() rotate([0,0,90]) intersection() {
        translate([8.6,0]) cube([4,30,9.5]);
        cylinder(d=51,h=9.5,$fn=80);
      }
    translate([0,0,9.48]) cylinder(d=50,h=4.55,$fn=50);
    mirror([0,0,1]) {
      cylinder(d1=56.2,d2=65,h=6,$fn=100);
      translate([0,0,5]) hull() {
        mirrorx() {
          translate([-22,22]) sphere(r=5,$fn=10);
          translate([-30,30,15]) sphere(r=5,$fn=20);
        }
      }
    }
  }
}

module mount(h=118,mount_holes=1,mount_quick_slide=0) {
  //rotate([0,0,180])
  *%translate([0,41]) translate([-105,-87.75,0]) import("Mostly_Printed_CNC_525_-Updated_5_25_16-/files/C-ToolMount.STL");
  difference() {
    union() {
      for(x=[-35,35])
      translate([x,52]) {
          rotate([0,0,x==35?-135:90-135]) translate([.2,-6]) {
            cube([17,12,h]);
        }
      }
      union(){
        intersection()
        {
          difference(){
            translate([0,-52.7]) cylinder(d=200,h=h,$fn=150);
            translate([0,3,-.01]) cylinder(d=70,h=h+.02,$fn=150);
          }
          union(){
          translate([-26,36]) cube([52,10,h]);
          translate([-18.5,32]) cube([37,20,h]);
          }
        }
        for(m=[0,1]) mirror([m,0]) {
          rotate([0,0,130]) translate([35,-4]) rotate([0,0,35]) {
            translate([0,-8.525]) cube([12,5,h]);
            if(mount_quick_slide) {
              for(z=[0:25:h-5])
              translate([2,-5,z]) dovetail(10);
            }
          }
        }

      }
    }
    translate([0,3,-.01]) cylinder(d=70,h=h+.02,$fn=150);
    if(mount_holes)
    for(x=[-34.5,34.5],z=[22.5,97.5])
      translate([x,52]) rotate([0,0,x>0?-135:90-135]) {
      translate([0,0,-.01]) cylinder(d=24,h=h+.02,$fn=80);
        translate([-.01,0,z]) rotate([0,90]) {
          cylinder(d=4,h=30,$fn=20);
          *translate([0,0,23]) cylinder(d1=4,d2=8,h=4,$fn=30);
          translate([0,0,22]) cylinder(d=8,h=20,$fn=30);
        }
      }
    if(mount_holes)
    for(z=[5:25:h-10],m=[0,1])
      mirror([m,0])
      rotate([0,0,130]) translate([35,-3,z+3.5]) rotate([0,0,35]) translate([4,0,5]) rotate([90,0]) {
        cylinder(d=5,h=20,$fn=20);
        rotate([0,0,0]) translate([0,0,12]) cylinder(d=7.5,h=10,$fn=6);
      }
    else if(mount_quick_slide)
      for(z=[0:25:h-5],m=[0,1])
        mirror([m,0]) rotate([0,0,130]) translate([35,-4]) rotate([0,0,35])
              translate([2,-5,z+12]) cube([5,8,3]);
  }
}
module mirrorx(off=0)
{
  translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([off/-2,0]) children();
}
module mirrory(off=0)
{
  translate([0,off/2,0]) for(m=[0,1]) mirror([0,m,0]) translate([0,off/-2,0]) children();
}
module mirrorz(off=0)
{
  translate([0,0,off/2]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,off/-2]) children();
}