blades=6;
od=130;
shaftd=5;
blade_thick=1.9;
th=10;
zoff=50;
extra_yrot=0;

translate([0,0,th+2]) mount();
%blades();


module mount(od=od+1.2) {
  intersection() {
    cylinder(d=od, h=th, $fn=50);
    union() {
      translate([-6,od*-.25,0]) cube([12,od/2,th]);
      for(m=[0,1]) mirror([0,m,0]) linear_extrude(th) {
        hull() {
          translate([0,od*-.5]) circle(d=20,$fn=20);
          translate([0,od*-.25]) circle(d=12,$fn=20);
        }
      }
    }
    difference() {
      cylinder(d=od, h=th, $fn=80);
      translate([0,0,2]) difference() {
        cylinder(d1=od-blade_thick*2-20,d2=od-blade_thick*2, h=th, $fn=80);
        translate([-2,od*-.5,0]) cube([4,od,5]);
      }
      translate([0,0,2]) cylinder(d=16.2,h=5.2,$fn=36);
      translate([0,0,-.01]) cylinder(d=shaftd+1,h=2.02,$fn=30);
    }
  }
  difference() {
    cylinder(d=20,h=7,$fn=40);
    translate([0,0,-.01]) cylinder(d=shaftd+1,h=2.02,$fn=30);
    translate([0,0,2]) cylinder(d=16.2,h=5.02,$fn=36);
  }
}
module blades() {
  intersection () {
    cylinder(d=od, h=th, $fn=50);
    union() {
      difference() {
        union() {
          cylinder(d=30,h=th, $fn=40);
      
           for(r=[0:360/blades:360]) rotate([0,0,r]) rotate([0,extra_yrot]) translate([od/-2+2+zoff/2,od/4,zoff]) intersection() {
            difference() {
              sphere(d=od,$fn=80);
              sphere(d=od-blade_thick*2,$fn=80);
            }
            translate([od/4-3,od/-4,-zoff-5]) rotate([0,-extra_yrot]) cube([od/2,od/2,th+10]);

          }
        }
        translate([0,0,-.01]) {
          cylinder(d=shaftd+.2,h=th+.02,$fn=30);
          cylinder(d=hex_head_diameter(shaftd),h=4,$fn=6);
          translate([0,0,3.99]) cylinder(d1=hex_head_diameter(shaftd),d2=shaftd,h=2,$fn=6);
        }
      }
    }
  }
}

function hex_head_diameter(bolt_diameter) = (bolt_diameter==5?9.1:((bolt_diameter*(bolt_diameter<inches(5/16)?1.75:(bolt_diameter<inches(3/8)?1.6:1.5)))/cos(30)));