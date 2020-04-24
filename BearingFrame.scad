rotate([90,0]) intersection(){ translate([0,0,2]) cube([42,10,30]);
difference(){
  union(){
    cube([102,10,4]);
    translate([0,0,28]) cube([102,10,2]);
    for(x=[0:10:100]) translate([x,0]) {
    cube([2,10,30]);
    translate([2,5,16]) rotate([0,90]) cylinder(d1=10,d2=7,h=2,$fn=40);
    translate([0,5,16]) rotate([0,-90]) cylinder(d1=10,d2=7,h=2,$fn=40);
    }
  }
  *translate([-.01,5,16]) rotate([0,90]) cylinder(d=8,h=110,$fn=40);
  }
}
*%for(x=[0:10:30]) translate([x,0])
translate([2.5,5,16]) rotate([0,90,0]) difference(){
  cylinder(d=22,h=7,$fn=50);
  translate([0,0,-.01]) cylinder(d=8,h=7.02,$fn=30);
}
