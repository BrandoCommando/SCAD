holesize=[inches(7),inches(2)];
screwpos=[inches(7.5),inches(2+(5/16))];
thi=50;
*!difference(){
  cube([inches(8.125),inches(3),2]);
}
reducer_2d();
!difference() {
  tw=inches(9.25);
  square([tw,tw]);
  translate([tw/2,tw/2]) {
    circle(d=inches(6),$fn=80);
    for(r=[0:60:360]) rotate([0,0,r]) translate([inches(6.5)/2,0]) circle(d=4,h=10,$fn=24);
  }
  for(x=[inches(.25),inches(9)],y=[inches(.25),inches(9)])
    translate([x,y]) circle(d=4,$fn=24);
}
module 6in_reducer() {
  difference() {
    union() {
      cylinder(d=inches(7),h=2,$fn=100);
      cylinder(d=inches(6),h=32,$fn=80);
      cylinder(d=inches(4),h=64,$fn=60);
    }
    rotate_extrude($fn=100) {
      translate([inches(6)/2,32]) circle(d=inches(2),$fn=50);
    }
    translate([0,0,-.1]) {
      cylinder(d=inches(4)-4,h=83,$fn=80);
      cylinder(d1=inches(5),d2=inches(4)-4,h=20,$fn=80);
      for(r=[0:60:360]) rotate([0,0,r]) translate([inches(6.5)/2,0]) cylinder(d=4,h=10,$fn=24);
    }
  }
}
module reducer_2d() {
  difference() {
    circle(d=inches(7),h=2,$fn=100);
    translate([0,0]) {
      *circle(d=inches(4)-4,h=83,$fn=80);
      circle(d=inches(6),d2=inches(4)-4,h=20,$fn=80);
      for(r=[0:60:360]) rotate([0,0,r]) translate([inches(6.5)/2,0]) circle(d=4,h=10,$fn=24);
    }
  }
}
module main_adapter() {
rotate([0,0,90])
difference() {
  union() {
    linear_extrude(6) {
      difference() {
        square([inches(8),inches(4)],center=true);
        intersection() {
          *circle(d=inches(7),$fn=100);
          square([inches(7),inches(2)],center=true);
        }
      }
    }
    difference() {
      hull(){
        csize=[inches(8),inches(4),4];
        translate([csize[0]*-.5,csize[1]*-.5,6])
          cube(csize);
        translate([0,0,thi]) cylinder(d=inches(4),h=20,$fn=50);
      }
      hull() {
        translate([holesize[0]*-.5,holesize[1]*-.5,5.99]) cube([holesize[0],holesize[1],4.02]);
        translate([0,0,thi-.01]) cylinder(d=inches(4)-4,h=20.03,$fn=50);
      }
    }
    translate([0,0,thi+20]) linear_extrude(30) difference() {
      circle(d=inches(4),$fn=100);
      circle(d=inches(4)-4,$fn=50);
    }
  }
  
  for(m=[0,1]) {
    mirror([m,0]) translate([screwpos[0]/2,0,-.01]) bolt_hole();
    mirror([0,m]) translate([0,screwpos[1]/2,-.01]) bolt_hole();
  }
}
}
module bolt_hole()
{
  cylinder(d=4,h=20,$fn=30);
  translate([0,0,6]) cylinder(d=12,h=20,$fn=40);
}
function inches(in) = in * 25.4;