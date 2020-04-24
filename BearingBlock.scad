tw=inches(2.5);
th=40;
td=inches(3);

*difference() {
  union() {
  cylinder(d=inches(3/4),h=2,$fn=80);
    *cylinder(d=inches(1.125),h=1,$fn=100);
  }
  translate([0,0,-.01]) cylinder(d=inches(1/2)+.6,h=2.02,$fn=80);
}
*difference() {
  cylinder(d=inches(1.5),h=8,$fn=80);
  translate([0,0,-.01]) cylinder(d=inches(1/2)+.4,h=10.02,$fn=50);
  translate([0,0,5]) cylinder(d=inches(3/4)/cos(30),h=5.02,$fn=6);
  for(r=[30:60:360]) rotate([0,0,r]) translate([14,0,-.01]) {
    cylinder(d=3,h=10.02,$fn=20);
    rotate([0,0,45]) {
      cylinder(d=7.2,h=3,$fn=4);
      translate([0,0,2.99]) cylinder(d1=7.2,d2=3,h=2,$fn=4);
    }
  }
}

*for(x=[-10,10]) translate([0,x,-10]) rotate([0,90]) translate([-10,-10]) cube([20,20,200]);
block();
//translate([0,0,td-inches(1/4)]) rotate([180,0])
translate([0,inches(2.5),0])
  block(td=inches(1.5));
/*/
translate([0,0,td/2]) rotate([0,90]) {
  mirror([0,0,1]) translate([0,0,1]) {
    rotate([0,0,30])
      import("GregLGear45.stl");
    translate([-40,0,16]) {
      rotate([0,0,30]) import("GregSGear9.stl");
      translate([0,0,-24]) {
        cylinder(d=5,h=20,$fn=30);
        mirror([0,0,1]) difference() {
          translate([-21.15,-21.15]) cube([42.3,42.3,40]);
          mirrorx() mirrory() translate([15.5,15.5,-.01]) cylinder(d=3,h=6,$fn=20);
        }
      }
    }
  }
  translate([0,0,-inches(1/2)]) color("silver") bolt(bd=inches(1/2),hd=inches(3/4)/cos(30),h=inches(5));
  color("gray") for(z=[0,tw/2-inches(5/16)/2,tw-inches(5/16)]) translate([0,0,z]) r8();
  color("black") translate([0,0,tw+2]) cylinder(d=41,h=35,$fn=80);
}
/**/
module block(tw=tw,th=th,td=td)
{
  difference() {
    translate([0,th*-.5]) cube([tw,th,td/2]);
    translate([-.01,0,td/2]) rotate([0,90,0]) {
      cylinder(d=inches(.75),h=tw+.02,$fn=50);
      for(z=[0,tw/2-inches(5/16)/2,tw-inches(5/16)]) translate([0,0,z]) {
        cylinder(d=inches(1.125)+.2,h=inches(5/16)+.2,$fn=80);
        mirrorz((inches(5/16)+.2)) translate([0,0,-1.99]) cylinder(d2=inches(1),d1=inches(1),h=2.02,$fn=60);
      }
    }
    if(td>inches(1.5))
      mirrory() mirrorx(tw) translate([inches(5/32)+(tw-inches(5/16))/4,10,-.01]) {
        cylinder(d=3.6,h=td,$fn=30);
        translate([0,0,14]) cylinder(d=7,h=td/2-9.98,$fn=40);
        translate([0,0,td/2-2]) cylinder(d1=7,d2=10,h=2.02,$fn=40);
      }
    for(x=[inches(5/16)+4,tw/2-inches(5/16)/2-4,tw/2+inches(5/16)/2+4,tw-inches(5/16)-4],y=[-15,15]) {
      translate([x,y,-.01]) {
        cylinder(d=3,h=td/2+.02,$fn=20);
        if(td<=inches(1.5)) {
          *cylinder(d=6.5,h=4,$fn=6);
          *translate([0,0,3.99])
            cylinder(d1=6.5,d2=3,h=1.75,$fn=6);
        } else {
          counterh=5+inches(1);
          cylinder(d=7,h=counterh,$fn=30);
          translate([0,0,counterh-.01]) cylinder(d1=7,d2=3,h=1.5,$fn=30);
        }
      }
    }
    //translate([inches(3/4)+5,th*-.5-.01,-.01]) cube([
  }
}

module r8()
{
  difference() {
    cylinder(d=inches(1.125),h=inches(5/16),$fn=50);
    translate([0,0,-.01]) cylinder(d=inches(1/2),h=inches(5/16)+.02,$fn=30);
  }
}
module bolt(bd=8,hd=14.6,h=30)
{
  cylinder(d=hd,h=hd/3,$fn=6);
  translate([0,0,hd/3-.01])
    cylinder(d=bd,h=h,$fn=40);
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
function inches(in) = 25.4*in;