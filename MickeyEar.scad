headsize=125;
earsize=86;//headsize*(3/5)+10;
earoff=headsize/2+earsize*(1/5)+18;
ithick=2.3;
othick=2.3;
channel=5;
hthick=3;
h=18;
$fn=128;
echo(str("Head:",headsize," Ear:",earsize," Off:",earoff));


*!cap();
*!mirror([1,0]) mirror([0,0,1]) lid();
!mirror([1,0]) ear();
*ears();
*mirror([1,0]) mirror([0,0,1]) color("brown") headband();


module ears() {
  batt=0;
  for(e=[0,1])
earspots(e) {
   ear(e);
  lid();
  cap(e);
}

}
module cap(batt=1) {
  
  difference() {
    scale([1.05,1]) difference() {
      translate([0,0,h]) linear_extrude2(2) circle(r=earsize/2+ithick/2-.4);linear_extrude(h+2.02) translate([0,-earoff]) scale([1/1.05,1]) circle(d=headsize);
    }
    translate([0,0,h-.01]) earholes() cylinder(d=3,h=2.02,$fn=20);
    if(batt)
    translate([-32,-20]) {
      cube([64,37,16]);
      translate([2,6,h-.01]) cube([7,12,4]);
    }
  }
}
module lid() {
  scale([1.05,1]) difference() {
    union() {
      translate([0,0,2]) rotate([0,0,-60]) rotate_extrude(angle=300) translate([earsize/2+ithick+channel,0]) square([othick,h]);
      translate([0,0,h]) linear_extrude2(2) circle(r=earsize/2+channel+othick+ithick);
    }
    translate([0,0,h-.01]) linear_extrude2(2.02) circle(r=earsize/2+ithick/2);
    translate([0,0,-.01]) {
      linear_extrude2(h+3) translate([0,-earoff]) scale([1/1.05,1]) circle(d=headsize,$fn=128);
      translate([0,-earoff,2]) scale([1/1.05,1]) rotate([0,0,80]) rotate_extrude(angle=70,convexity=3) square([headsize/2+hthick+5,h-2]);
      linear_extrude(h) translate([0,-earoff]) scale([1/1.05,1]) circle(d=headsize+hthick);
    }
  }
}
module ear(batt=1) {
  $fn=128;
  if(batt)
  translate([-32,-20]) difference() {
    translate([-ithick,-ithick,2]) cube([64+ithick*2,37+ithick*2,10]);
    cube([64,37,16]);
    translate([-ithick-.01,30,5]) cube([ithick+.02,5,16]);
  }
  scale([1.05,1]) difference() {
    union() {
      linear_extrude2(h) difference() {
        circle(r=earsize/2+channel+othick+ithick);
    //    circle(d=earsize);
        circle(d=earsize);
        translate([0,-earoff]) scale([1/1.05,1]) circle(d=headsize,$fn=128);
      }
      linear_extrude2(2) circle(d=earsize);
      earholes() cylinder(d=6,h=2,$fn=36);
    }
    translate([0,0,-.01]) earholes() cylinder(d=3,h=h,$fn=36);
    translate([0,-earoff,2]) scale([1/1.05,1]) linear_extrude(h) circle(d=headsize+hthick*2+.02,$fn=128);
    translate([0,-earoff]) scale([1/1.05,1]) rotate([0,0,100]) rotate_extrude(angle=50,$fn=128) translate([headsize/2+hthick-.02,2]) square([channel+.04,h]);
    translate([0,0,-.01]) linear_extrude2(h) translate([0,-earoff]) scale([1/1.05,1]) circle(d=headsize,$fn=128);
    difference() {
      translate([0,0,2]) rotate([0,0,-60]) rotate_extrude(angle=300,convexity=3) translate([earsize/2+ithick,0]) {
        difference() {
          square([channel+othick+.02,h]);
          translate([channel-ithick,0]) square([ithick,2]);
        }
      }
      translate([0,0,-.01]) linear_extrude2(h+3) translate([0,-earoff]) scale([1/1.05,1]) circle(d=headsize+hthick*2,$fn=128);
      
    }
    
    *translate([0,0,2]) linear_extrude2(h-4) difference() {
      circle(r=earsize/2+channel+ithick);
      circle(r=earsize/2+ithick);
    }
  }
  *intersection() {
    scale([1.05,1]) linear_extrude2(h) circle(d=earsize,h=6);
    translate([0,-earoff]) linear_extrude2(h) difference() {
      circle(d=headsize+hthick*2,h=6,$fn=128);
      circle(d=headsize,h=6.02,$fn=128);
    }
  }
}
module headband(sub=1) {
  difference() {
    linear_extrude(h,convexity=3) difference() {
      union() {
        circle(d=headsize+hthick*2,$fn=128);
        earspots() earholes() {
          circle(d=11,$fn=36);
          translate([-5.5,-5.5]) square([11,5.5]);
        }
      }
      earspots() earholes()
          circle(d=3,$fn=20);
      circle(d=headsize,$fn=128);
      translate([-headsize/2-hthick-.01,-headsize/2-hthick-.01]) square([headsize+hthick*2+.02,headsize/2+hthick+.02]);
    }
    for(m=[0,1]) mirror([m,0])
rotate([0,0,40]) translate([earoff,0,-.01]) rotate([0,0,-90]) scale([1.05,1]) linear_extrude2(2) circle(r=earsize/2+channel+othick+ithick+1);
  }
  intersection() {
    translate([-headsize/2-hthick-.01,-headsize]) cube([headsize+hthick*2+.02,headsize+.02,h]);
    union() {
      scale([1,1.45]) for(m=[0,1]) mirror([m,0]) {
        rotate([0,0,-50]) {
          rotate_extrude($fn=128,angle=50) translate([headsize/2,0]) square([hthick,h]);
          translate([headsize/2+hthick/2,0]) cylinder(d=hthick,h=h,$fn=24);
        }
      }
    }
  }
}
module earspots(mi=-1) {
  if(mi==-1)
  for(m=[0,1]) mirror([m,0])
    rotate([0,0,40]) translate([earoff,0]) rotate([0,0,-90])
      children();
  else
    mirror([mi,0])
      rotate([0,0,40]) translate([earoff,0]) rotate([0,0,-90])
        children();
}
module earholes() {
  translate([0,-earoff])
  for(r=[-15,10]) rotate([0,0,r])
  translate([0,earoff])
  translate([0,earsize*-.5*1.05+14]) children();
}

module linear_extrude2(h)
{
  linear_extrude(h,convexity=3)
  children();
}
*#circle(d=headsize,$fn=128);