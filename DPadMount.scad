difference(){
  union(){
    translate([3,0]) cube([70.5,32.4,2]);
    translate([0,3]) cube([76.5,26.4,2]);
    for(x=[0,20.5,50,70.5],y=[0,26.4])
      translate([x+3,y+3]) cylinder(d=6,h=4,$fn=30);
  }
  for(x=[0,20.5,50,70.5],y=[0,26.4])
    translate([x+3,y+3,-.01]) cylinder(d=3,h=5,$fn=20);
}