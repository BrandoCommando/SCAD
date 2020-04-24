part="1";
boltposx=[-34,34];
boltposy=[40,-14];
lyoff=-2;
//rotate([90,0])
mirror([0,0,part=="1"?1:0])
if(part=="4")
  spacer(6);
else if(part=="3")
{
  !mirror([0,0,1]) 
    tripod();
} else {
  %translate([0,0,11]) spacer(8);
  %translate([0,0,8]) tripod();
intersection() {
  if(part=="1")
  {
    translate([-40,-20,7]) cube([80,66,4]);
    latch();
  }
  else if(part=="2")
    translate([-40,-20]) cube([80,66,6.99]);
difference()
{
  translate([-40,-20,.01]) cube([80,66,11]);
  for(x=boltposx,y=boltposy) translate([x,y]) {
    cylinder(d=3,h=20,$fn=20);
    *translate([0,0,5]) cylinder(d1=3,d2=6,h=1.01,$fn=30);
    *translate([0,0,6]) cylinder(d=6,h=4,$fn=30);
  }
  difference() {
    union(){
      cylinder(d=18,h=7,$fn=50);
      linear_extrude(3) hull() {
        circle(d=18,$fn=50);
        translate([-17,25.4]) square([34,1]);
      }
      translate([0,0,2.99]) {
        linear_extrude(4.01) hull() {
          for(m=[0,1]) mirror([m,0]) {
            translate([-12,0]) circle(d=6,$fn=36);
            translate([-21,25.4]) circle(d=5,$fn=25);
          }
        }
      }
      translate([0,0,6.99]) {
        translate([5,-4.5+lyoff]) {
          translate([0,1]) rotate([0,0,-10]) cube([2,20,10]);
          translate([-12,2]) {
            translate([0,0]) mirror([0,1]) cube([14,2,10]);
            *translate([0,0,1]) rotate([0,90]) linear_extrude(12) {
              polygon([[-3,0],[4,0],[4,6]]);
            }
            translate([2,-1]) mirror([1,0]) rotate([0,0,-10]) cube([2,20,10]);
          }
        }
      }
    }
    if(part!="2")
      latch();

  }
  
  translate([-23.5,25.4]) cube([47,31,20]);
}
}
}
module spacer(h=8) {
  difference() {
    translate([-40,-20,.01]) cube([80,66,h]);
    for(x=boltposx,y=boltposy) translate([x,y]) {
      cylinder(d=3,h=30,$fn=20);
    }
    translate([-30,-10]) cube([60,46,h+.02]);
  }
}
module latch() {
  difference() {
      translate([-4,lyoff,7]) rotate([0,90,0]) linear_extrude(8) {
        *circle(d=5,h=8,$fn=25);
        polygon([[0,-2.5],[0,2],[0,3],[3,0],[3,-1.25],[0,-2.5]]);
        *translate([0,-2]) rotate([0,0,0]) square([4,4]);
      }
      *translate([-6,-5.5,7.99]) rotate([0,90]) linear_extrude(12) {
        polygon([[-3,0],[4,0],[4,5]]);
      }
    }
  }
module tripod() {
  difference() {
    translate([-40,-20,11]) cube([80,66,10]);
    for(x=boltposx,y=boltposy) translate([x,y]) {
      cylinder(d=3,h=30,$fn=20);
    }
    translate([0,12,10.99]) {
      cylinder(d=6.5,h=20,$fn=30);
      rotate([0,0,0]) translate([0,0,0]) cylinder(d=13,h=8,$fn=6);
    }
    *translate([-7,-4,10.99]) cube([14,8,3]);
  }
}