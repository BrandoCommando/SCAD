difference() {
  cylinder(d=196,h=50,$fn=200); //1508592.4784
  translate([0,0,-.1]) cylinder(d=76 ,h=50.2,$fn=100);
  translate([0,0,1]) rotate_extrude($fn=200) union() {
    translate([39.5,4]) square([57,50.2]);
    translate([43.5,4]) circle(r=4,$fn=30);
    translate([43.5,0]) square([51,50.2]);
    translate([94.5,2]) circle(r=2,$fn=20);
    translate([94.5,2]) square([2,2]);
  }
  for(x=[65,-65],y=[-25.4,25.4]) translate([x,y,-.1]) cylinder(d=6,h=5,$fn=40);
}