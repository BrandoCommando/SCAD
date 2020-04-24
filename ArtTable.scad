ttlw = inches(45);
ttld = inches(22.5);
sideh = inches(6);
tq = inches(3/4);
bsize=inches(1.5);

ttlfl=ttlw*2+(ttld-bsize*2)*4+inches(20)*4+inches(4.5)*4;
echo(str("Total Frame Length: ", ttlfl/25.4/12));

color("white") linear_extrude(tq) square([ttlw,ttld]);
translate([0,0,-inches(4.5)]) {
  translate([-tq,-tq]) mirrory(ttld+tq*2) color("brown") translate([0,y,0]) difference() {
    cube([ttlw+tq*2,tq,sideh]);
    mirrorx(ttlw+tq*2) translate([0,0,-.01]) rotate([0,0,45]) cube([30,20,sideh+.04]);
  }
  mirrorx(ttlw) linear_extrude(sideh) translate([-tq,0]) polygon([[0,-tq],[tq,0],[tq,ttld],[0,ttld+tq]]);
  *translate([-tq,-tq,0])
    cube([tq,ttld+tq*2,sideh]);
  *translate([ttlw,-tq,0]) cube([tq,ttld+tq*2,sideh]);
  *color("brown") for(x=[0,ttlw-inches(12)]) translate([x,-tq,0]) cube([inches(12),tq,sideh]);
  translate([0,0,inches(1)]) framing();
  *translate([0,0]) cube([ttlw,bsize,bsize]);
  legs();
}
  
module legs() {
  for(x=[bsize,ttlw-bsize*2],y=[bsize,ttld-bsize*2]) translate([x,y,-inches(15.5)]) cube([bsize,bsize,inches(20)]);
}
module framing() {
  for(z=[0]) translate([0,0,z]) {
    color("blue")
      for(y=[0,ttld-bsize]) translate([0,y]) cube([ttlw,bsize,inches(3.5)]);
    *color("purple")
      for(x=[0,ttlw-inches(12)+bsize]) translate([x,0]) cube([inches(12)-bsize,bsize,inches(3.5)]);
  }
  color("green") for(x=[0,ttlw-bsize]) translate([x,bsize]) cube([bsize,ttld-bsize*2,inches(3.5)]);
  color("green") for(x=[inches(12)-bsize,ttlw-inches(12)]) translate([x,bsize]) cube([bsize,ttld-bsize*2,inches(3.5)]);
  *for(x=[inches(12),ttlw-inches(12)-bsize],y=[bsize,ttld-bsize*2])
    translate([x,y,0]) cube([bsize,bsize,inches(4.5)]);
}

module mirrorx(off=0) {
  translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([off/-2,0]) children();
}
module mirrory(off=0) {
  translate([0,off/2]) for(m=[0,1]) mirror([0,m]) translate([0,off/-2]) children();
}
function inches(in) = in * 25.4;