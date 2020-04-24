difference() {
  square([25.4,50.8]);
  for(s=[1:6])
  {
    translate([s*4,50.8-s]) square([25.4,10]);
    translate([25.4-s,28-(s*4)]) rotate([0,0,-90]) square([25.4,10]);
  }
}
