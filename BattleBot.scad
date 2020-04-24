minkowski() {
  translate([5,5,5]) cube([10,10,10]);
    for(m=[0,1]) mirror([0,0,m]) cylinder(r1=5,r2=0,$fn=4,h=5);
}
module drum_spinner() {
cube([200,140,40]);
translate([10,160,20]) rotate([0,90,0]) drum();
}
module drum() {
  cylinder(d=38,h=180,$fn=30);
}