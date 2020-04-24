translate([0,0,0]) cylinder(d=25,h=1,$fn=50);
intersection(){
  translate([0,0,1]) cylinder(d=25,h=8,$fn=50);
difference(){
  union(){
    cylinder(d=22,h=4,$fn=46);
      translate([0,0,3.6]) rotate_extrude($fn=80){
        translate([10.5,0]) circle(d=1.5,$fn=50);
      }
  }
  for(r=[0:30:360]) rotate([0,0,r]) translate([0,-1]) cube([30,2,5]);
  translate([0,0,1.01]) cylinder(d=20,h=4.01,$fn=40);
}
}