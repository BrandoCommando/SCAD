part="guide";
name="MK III";
guidehod=5;
guidedist=25.4;
body_helper=0;

if(part=="all") {
  rocket_base();
  translate(body_helper?[0,0,4]:[])
  {
  translate([0,0,140]) rocket_body();
  translate([0,0,266]) rocket_nose();
  }
} else if(part=="all2")
{
  translate([-60,30]) rocket_body();
  translate([60,30]) rocket_nose();
  translate([0,0,140]) rotate([180,0,60]) rocket_base();
  if(body_helper)
      translate([0,-60]) rocket_body_helper();
} else if(part=="guide") {
  difference() {
    union() {
      translate([0,0,20]) difference() {
        cylinder(d1=31,d2=28,h=6,$fn=50);
        translate([0,0,-.01]) cylinder(d=27,h=6.02,$fn=50);
      }
      linear_extrude(20,convexity=3) difference() {
        union() {
          circle(d=31,$fn=50);
          translate([guidedist,0]) circle(d=guidehod+1.6,$fn=50);
          translate([0,-1.2]) square([guidedist,2.4]);
        }
        circle(d=27,$fn=50);
        translate([guidedist,0]) circle(d=guidehod,$fn=50);
      }
    }
    *for(r=[30:60:360]) rotate([0,0,r]) translate([0,-1.2,-.1]) cube([guidedist,2.4,10]);
  }
} else if(part=="nose")
  rocket_nose();
else if(part=="body")
  rotate([0,0,270]) rocket_body();
else if(part=="base")
  translate([0,0,140]) rotate([180,0,60]) rocket_base();

module rocket_nose() {
  ring2(od1=42,id1=38,h=20);
  translate([0,0,20])
    ring2(od1=42,od2=30,id1=38,id2=26,h=32);
  translate([0,0,52])
    ring2(od1=30,od2=20.2,id1=26,id2=14,h=16);
  translate([0,0,68])
    ring2(od1=20.2,od2=15.6,id1=14,id2=8,h=6);
  translate([0,0,74])
    ring2(od1=15.6,od2=12.5,id1=8,id2=0,h=3);
  translate([0,0,77])
    cylinder(d1=12.5,d2=10.2,h=2);
  translate([0,0,79])
    cylinder(d1=10.2,d2=7,h=2);
  translate([0,0,81])
    cylinder(d1=7,d2=3.8,h=1.3);
  translate([0,0,82.3])
    cylinder(d1=3.8,d2=0,h=.4);
}
module rocket_base() {
 translate([0,0,50]) difference(){
   union() {
    cylinder(d=42,h=90);
  if(guidehod>0)
  {
    translate([0,0,70]) rotate([0,0,150]) linear_extrude(20,convexity=3) {
      translate([0,-1.2]) square([guidedist-guidehod+1.2,2.4]);
      translate([guidedist,0]) difference() { circle(d=guidehod+2.4,$fn=24); circle(d=guidehod,$fn=20); }
    }
  }
   }
    if(body_helper)
    {
      translate([0,0,81.6]) {
        cylinder(d1=28.4,d2=34,h=8.41,$fn=50);
      }
    }
    translate([0,0,-.01]) cylinder(d=26.4,h=90.02);
    translate([0,0,-.01]) cylinder(d=33.4,h=53.4);
   translate([0,0,79.8]) cylinder(d1=33.4,d1=26.4,h=10.5);
  }
  rotate([0,0,-30]) translate([20.6,0]) rocket_fin_welded(text=name);
  rotate([0,0,90]) translate([20.6,0]) rocket_fin_welded(text=name);
  rotate([0,0,210]) translate([20.6,0]) rocket_fin_welded(text=name);
}
module rocket_fin_welded(w=5,text="") {
   difference() {
     rocket_fin();
    translate([30,-2,60]) rotate([90,0]) linear_extrude(1) text(text,halign="center");
  }
    intersection(){
      translate([-1,0,1.1]) rocket_fin(15);
      translate([2,4.2,50]) intersection(){
        translate([-2,-9]) cube([2,9,90]);
        union(){
          translate([-.2,-8.7]) difference() {
            translate([-2,-2]) cube([4,4,90]);
            translate([0,0,-.01]) cylinder(d=4,h=90.02,$fn=20);
          }
          translate([-.2,.2]) difference() {
            translate([-2,-2]) cube([4,4,90]);
            translate([0,0,-.01]) cylinder(d=4,h=90.02,$fn=20);
          }
        }
      }
    }

}
module rocket_fin(w=5) {
  rotate([90,0])
  translate([0,0,w*-.5])
  linear_extrude(w)
    polygon([[0,50],[0,140],[70,58],[70,0],[40,0],[30,30]]);
}
module rocket_body_helper() {
  difference() {
    union() {
      cylinder(d=42,h=9.1,h=4,$fn=50);
      translate([0,0,4]) cylinder(d1=35.6,d2=24,h=9,$fn=50);
      mirror([0,0,1]) cylinder(d1=32.4,d2=28,h=8,$fn=50);
    }
    translate([0,0,-20.1]) cylinder(d=23.5,h=40,$fn=50);
  }
}
module rocket_body() {
  if(body_helper)
  {
    *%translate([0,0,-4]) rocket_body_helper();
    difference() {
      cylinder(d=42,h=9.1,$fn=50);
      translate([0,0,-.1]) cylinder(d1=36,d2=23.5,h=9.3,$fn=50);
    }
  } else
  difference() {
    cylinder(d=25.6,h=9.1,$fn=50);
    translate([0,0,-.01]) cylinder(d=23.5,h=10.02,$fn=50);
  }
  translate([0,0,9.1])
    difference() {
      union(){
        cylinder(d1=42,d2=42,h=10,$fn=50);
        translate([0,0,10]) cylinder(d=42,h=107.5,$fn=50);
        translate([0,0,117.5]) cylinder(d=36.8,h=17.4,$fn=50);
      }
      *translate([19,-5,65]) rotate([0,90,0])
        linear_extrude(4) text(name,halign="center");
      translate([0,0,-.01]) cylinder(d1=23.5,d2=23.5,h=10.03,$fn=50);
      translate([0,0,10.01]) cylinder(d=31.8,h=140,$fn=50);
    }
}

module ring2(od1,od2=false,id1,id2=false,h,$fn=40)
{
   difference(){
     if(od2)
       cylinder(d1=od1,d2=od2,h=h,$fn=$fn);
     else
       cylinder(d=od1,h=h,$fn=$fn);
     translate([0,0,-.01])
     {
       if(od2)
         cylinder(d1=id1,d2=id2,h=h+.02,$fn=$fn);
       else
         cylinder(d=id1,h=h+.02,$fn=$fn);
     }
   }
}