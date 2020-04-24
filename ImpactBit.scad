mirror([0,0,1]){
  difference(){
cylinder(d=7.1,h=24,$fn=6);
translate([0,0,9]) rotate_extrude()
{
  translate([8,0]) circle(d=11.6,$fn=50);
}

  translate([0,0,-.01]) difference(){
    cylinder(d=10,h=2,$fn=50);
    translate([0,0,-.01]) cylinder(d1=6,d2=8,h=2.02,$fn=50);
  }
}
translate([0,0,20])
  cylinder(d1=6,d2=11.15,h=8,$fn=50);
translate([0,0,28])
  difference() {
    cylinder(d=11.15,h=10.6,$fn=50);
    translate([0,0,-.01]) cylinder(d=7.6,h=10.8,$fn=6);
  }
}