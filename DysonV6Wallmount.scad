!hand();
wallmount();
translate([0,0,47]) difference() {
  union() {
    translate([0,0,-47]) attach_base();
    cylinder(d1=34,d2=12,h=40,$fn=60);
    linear_extrude(80,convexity=3) hull() {
      translate([0,-10]) circle(d=12,$fn=40);
      translate([0,10]) circle(d=12,$fn=40);
    }
  }
  translate([-10,-20,60]) rotate([32,0]) cube([20,40,20]);
  translate([0,0,-.01]) {
    cylinder(d1=28.5,d2=10,h=40.02,$fn=60);
    linear_extrude(80.02,convexity=3) hull() {
      for(y=[-10,10]) translate([0,y]) circle(d=9,$fn=40);
    }
  }
}
module attach_base() {
  difference(){
    union() {
      translate([0,0,1]) cylinder(d=34,h=46,$fn=60);
      cylinder(d1=32,d2=34,h=1,$fn=60);
      translate([0,0,38]) intersection() {
        union() {
          translate([12,-11,-1]) rotate([0,-30,0]) cube([20,8,10]);
          translate([12,3,-1]) rotate([0,-30,0]) cube([20,8,10]);
          translate([12,-3,-3]) rotate([0,-30,0]) cube([20,6,10]);
        }
        scale([1,.9,1])
        cylinder(d=39,h=10,$fn=80);
        rotate([0,90]) {
          translate([-1,-1]) linear_extrude(20,convexity=3) hull() {
            circle(d=2,$fn=12);
            translate([-4.5,0]) circle(d=2,$fn=12);
          }
          translate([3,0]) scale([.8,1,1])
            translate([0,0,10]) difference() {
              scale([1,.71,1])
              cylinder(d1=36,d2=24,h=10,$fn=60);
              translate([0,0,-.01]) cylinder(d1=15,d2=22,h=10.02,$fn=60);
            }
        }
      }
    }
    translate([0,0,-.01]) cylinder(d=28.5,h=47.02,$fn=60);
    translate([0,0,9.5]) {
      difference() {
        union() {
          cylinder(d=34.02,h=7.1,$fn=60);
        }
        translate([0,0,-.01]) cylinder(d=30.5,h=4.1,$fn=60);
        translate([0,0,4.08]) cylinder(d1=30.5,d2=34.02,h=3.04,$fn=60);
      }
    }
  }
  
}
module hand_attachment() {
difference() {
  hand();
  translate([-50,-12,10])
    cube([25,24,10.02]);
  for(x=[-40,-30])
  translate([x,0,-.01]) cylinder(d=4,h=10.02,$fn=30);
}
}
module wallmount() {
rotate([0,0,-90])
intersection() {
  *translate([-130,-30]) cube([180,60,2]);
difference() {
  union() {
    %hand(25);
    translate([-120,-5]) {
      cube([110,10,10]);
      intersection() {
        translate([0,-4,0]) cube([10,18,112]);
        minkowski(){
          translate([-2,-2]) cube([10,14,110]);
          sphere(r=2,$fn=20);
        }
      }
      intersection() {
        translate([90,0]) rotate([0,-45]) cube([10,10,130]);
        cube([110,10,100]);
      }
    }
    translate([-40,-10]) cube([10,20,25]);
  }
  for(z=[5,20])
  {
    translate([0,0,z]) rotate([0,-90,0]) cylinder(d=3,h=40,$fn=20);
    translate([-36,-3.1,z<10?z-5.01:z-3.99]) cube([3,6.2,9]);
  }
  translate([-30,-10.01,-.01]) cube([20,20.02,30]);
  translate([0,0,-.01])
    cylinder(d=37,h=20.02,$fn=80);
  for(m=[0,1]) mirror([0,m])
  translate([20,0,-.01]) rotate([0,0,60]) translate([-14,-15]) cube([20,20,20.02]);
  for(z=[101])
  translate([-109.99,0,z]) rotate([0,-90,0]) {
    cylinder(d=4,h=10.02,$fn=20);
    cylinder(d1=9,d2=4,h=3,$fn=20);
  }
  translate([-109.99,0,18]) rotate([0,-90,0]) {
    linear_extrude(10.02,convexity=3) hull() {
      circle(d=4,h=10.02,$fn=20);
      translate([10,0]) circle(d=4,$fn=20);
    }
    translate([10,0]) cylinder(d=9,h=10.02,$fn=20);
  }
}
}
}
module hand(t=25.4*3/4+2) {
  difference() {
    linear_extrude(t,convexity=3) difference() {
      union() {
        hull()
        {
          translate([-30,-16]) square([10,32]);
          circle(d=44,h=10,$fn=80);
        }
        translate([-50,-16]) square([20,32]);
      }
      circle(d=37,$fn=80);
      for(m=[0,1]) mirror([0,m])
    translate([20,0,-.01]) rotate([0,0,60]) translate([-14,-15]) square([20,20]);
    }
    for(y=[-7,7])
    translate([-45,y,-.01]) cylinder(d=4,h=2.02,$fn=20);
    translate([-50.01,-12,2]) cube([25,24,30]);
    for(z=[7,t-5])
      translate([-35,20,z]) rotate([90]) {
        cylinder(d=3,h=40,$fn=20);
        *cylinder(d=8,h=23,$fn=40);
      }
  }
}
module rounded_rect(w,h,r) {
  translate([r,r]) circle(d=r*2,$fn=30);
  translate([r,h-r]) circle(d=r*2,$fn=30);
  translate([w-r,h-r]) circle(d=r*2,$fn=30);
  translate([w-r,r]) circle(d=r*2,$fn=30);
  translate([r,0]) square([w-r*2,h]);
  translate([0,r]) square([r,h-r*2]);
  translate([w-r,r]) square([r,h-r*2]);
}
module rounded_cube(dims,rsides=2,rvert=0)
{
  w=dims[0];
  h=dims[1];
  d=dims[2];
  if(rvert==0)
  {
    linear_extrude(d) rounded_rect(w,h,rsides);
  } else {
    translate([rsides,rsides,rvert]) scale([1,1,rvert/rsides]) minkowski() {
      cube([w-rsides*2,h-rsides*2,(d-rvert*2)/(rvert/rsides)]);
      sphere(rsides,$fn=30);
    }
  }
}