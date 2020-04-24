od=60;
//intersection(){
//translate([od*-.6,od*-.6,od/2]) cube([od*1.2,od*1.2,od*.7]);
difference(){
  union(){
  translate([0,0,od/2]) sphere(d=od,$fn=od);
  cylinder(d=od,h=od/2,$fn=od);
    translate([0,0,od-2]) cylinder(d=24,h=6);
    translate([od*-.5-1,od*-.5-1]) cube([od+2,od+2,2]);
    translate([0,0,2]) cylinder(d1=od+2,d2=od,h=2,$fn=od);
  }
  translate([0,0,od/2]) sphere(d=od-4,$fn=od-6);
  translate([0,od*-.4,od*.8]) sphere(d=od*.8,$fn=od);
  translate([0,0,.5]) cylinder(d=26,h=10,$fn=40);
  translate([0,0,od-5]) cylinder(d=20,h=10,$fn=30);
  translate([od*-.45,od*-.45,-.01]) cylinder(d=3.5,h=2.02,$fn=20);
  translate([od*.45,od*-.45,-.01]) cylinder(d=3.5,h=2.02,$fn=20);
  translate([od*-.45,od*.45,-.01]) cylinder(d=3.5,h=2.02,$fn=20);
  translate([od*.45,od*.45,-.01]) cylinder(d=3.5,h=2.02,$fn=20);
}
//}