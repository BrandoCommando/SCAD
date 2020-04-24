t=1.6;
difference() {
  cylinder(d1=150,d2=165,h=180,$fn=200);
  translate([0,0,-.1]) cylinder(d1=150-t*2,d2=165-t*2,h=180.2,$fn=200);
}
cylinder(d=150,h=t*2,$fn=100);