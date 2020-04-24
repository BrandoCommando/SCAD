th=30;
td=4;
tw=80;
main();
module main() {
difference() {
  cube([th,tw,td]);
  translate([0,tw/2]) for(m=[0,1]) mirror([0,m]) translate([0,tw/-2]) {
    for(x=[th/8,th/2,th*7/8])
      translate([x,5,-.1]) cylinder(d=3,h=td+.2,$fn=20);
    translate([-.1,-.1,td/2]) cube([th+.2,10.2-25.4/8,td+.1]);
  }
  translate([th/2,0]) for(m=[0,1]) mirror([m,0]) translate([th/-2,0]) {
  translate([-.1,10,td/2])
    cube([.1+(25.4/4)-2,tw-20,td/2+.1]);
  translate([25.4/4-td/2,10,td]) rotate([-90,0]) {
    cylinder(r=td/2,h=tw-20,$fn=20);
    for(y=[0,tw-20]) translate([0,0,y]) {
    sphere(r=td/2,$fn=20);
    rotate([0,-90]) cylinder(r=td/2,h=25.4/4,$fn=20);
    }
  }
  }
}
}
module side() {
translate([0,0,-2]) rotate([90,0]) difference() {
  translate([0,2]) cube([th,7.8,tw]);
  translate([0,0,tw/2]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,tw/-2]) {
  translate([-.1,10-td/2,0]) cube([th+.2,td/2+.1,td+.2]);
  translate([-.1,-.1,-.1]) cube([th+.2,10,td/2+.2]);
  }
  for(x=[th/8,th/2,th*7/8])
    translate([x,5,-.1]) cylinder(d=3,h=tw+.2,$fn=20);
  translate([th/2,0]) for(m=[0,1]) mirror([m,0]) translate([th/-2,0]) {
  translate([25.4/4-td/2,10,0]) cylinder(r=td/2,h=tw+.2,$fn=20);
  translate([-.1,10-td/2,0]) cube([25.4/4-td/2,td/2,tw+.2]);
  }
}
} 