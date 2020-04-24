difference(){
cube([46,8,2]);
color("red") translate([0,4,-.5]) cylinder(r=8,h=3,$fn=20);
color("red") translate([46,4,-.5]) cylinder(r=8,h=3,$fn=20);
}
translate([8,0,2]) {
  for(x=[2:4:26]){
    translate([x,3.5]) cube([2,0.5,0.4]);
  }
}
translate([7,0,2]) rail();
translate([7,8,2]) mirror([0,1,0]) rail();
module rail(){
  difference(){
    union(){
      translate([0.5,0,0]) cube([31,0.4,2]);
      translate([0.5,0,1]) cube([31,0.8,1]);
    }
    for(x=[1.5:5:30])
      translate([x,-.1]) cube([4,1,1]);
  }
}