item_size=[30,65];
thick=1.61;
sidey=100/2-item_size[1]/2;
difference() {
  translate([0,sidey,0]) minkowski() {
    cube([item_size[0],item_size[1],thick]);
    sphere(r=thick,$fn=30);
  }
  translate([0,sidey+thick/2,thick/2]) minkowski() {
    cube([item_size[0]-thick/2,item_size[1]-thick,thick*2]);
    sphere(r=thick/2,$fn=30);
  }
  translate([-.01,sidey+5,-thick*2]) cube([item_size[0]-5,item_size[1]-10,thick*4+1]);
  translate([-thick-1,0,-thick*2]) cube([thick+1,100,thick*4+1]);
}
translate([0,0,-thick]) linear_extrude(thick*2) difference() {
  mirrory(100) difference() {
      union() {
        translate([thick/2,0]) circle(d=thick,$fn=20);
        translate([0,sidey-5-thick]) square([thick+5,5+thick]);
        square([thick,sidey]);
      }
      translate([5+thick,sidey-5-thick]) circle(r=5,$fn=50);
    }
}
difference() {
  linear_extrude(20,convexity=3) {
    difference() {
      translate([0,sidey]) offset(thick,$fn=20) square(item_size);
      translate([-2.01,sidey+1]) offset(,$fn=20) square([item_size[0]+1,item_size[1]-2]);
      translate([-4,0]) square([4,100]);
    }
    mirrory(100) difference() {
      union() {
        translate([thick/2,0]) circle(d=thick,$fn=20);
        translate([0,sidey-5-thick]) square([thick+5,5]);
        square([thick,sidey-5-thick]);
      }
      translate([5+thick,sidey-5-thick]) circle(r=5,$fn=50);
    }
  }
  mirrory(100) translate([-.01,5,10]) rotate([0,90]) cylinder(d=4,h=4,$fn=30);
}
module mirrory(off=0)
{
  translate([0,off/2]) for(m=[0,1]) mirror([0,m]) translate([0,off/-2]) children();
}