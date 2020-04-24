difference(){
  cube([60,60,4]);
  for(x=[10:10:50],y=[10:10:50])
    if(x!=30||y!=30) translate([x,y,-.01]) cylinder(d=6,h=5.02,$fn=40);
  for(x=[4,56],y=[4,56])
    translate([x,y,-.01]) {
      cylinder(d=3,h=3.02,$fn=20);
      translate([0,0,1]) cylinder(d=7.1,h=3.02,$fn=6);
    }
  translate([30,30,-.01]) {
    cylinder(d=3,h=3.02,$fn=20);
    translate([0,0,1]) cylinder(d=7.1,h=3.02,$fn=6);
  }
}
*for(x=[0,55],y=[0,55])
  translate([x,y]) cube([5,5,30]);
*translate([27.5,27.5]) cube([5,5,25]);
