sw=25.4*6;
st=25.4*3;
difference() {
  linear_extrude(3) {
    scraper();
    handle();
  }
  translate([-.01,0,.5]) rotate([20,0]) cube([sw+.02,20,20]);
}
linear_extrude(5) {
 difference() {
   union() {
   offset(0) handle();
   }
   offset(delta=-3) handle();
   square([sw,st]);
 } 
}
module scraper() {
  translate([0,5]) square([sw,st-5]);
  hull() {
    for(x=[5,sw-5],y=[5])
      translate([x,y]) circle(r=5);
  }
}
module handle() {
  hull() {
    translate([20,st])
      circle(r=20);
    translate([sw-20,st])
      circle(r=20);
    translate([sw/2,st+20])
      circle(r=20);
  }
  translate([sw/2,st+10])
    difference() {
      hull() {
        circle(r=18);
        translate([0,25.4*3]) circle(r=22);
      }
      translate([0,25.4*3]) circle(r=12);
    }
}