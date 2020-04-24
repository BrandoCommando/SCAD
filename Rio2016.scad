#translate([-32.5,-110.5,-3]) import("Olympic_Medal_W_Loop.stl");
surface(file="rio-2016-logo.svg");

translate([0,0,-5]) {
  cylinder(d=73,h=2,$fn=70);
  translate([-16.5,30]) cube([4,16,2]);
  translate([12.5,30]) cube([4,16,2]);
  translate([-12.5,42]) cube([25,4,2]);
  translate([0,-2]) linear_extrude(3) text("Rio 2016", 6, halign="center", font="Brush Script MT");
  translate([-6.1,-7.5]) {
    ring(6,4.5,3,$fn=30);
    translate([6.1, 0]) ring(6,4.5,3,$fn=30);
    translate([12.2, 0]) ring(6,4.5,3,$fn=30);
    translate([3.05, -2.6]) ring(6,4.5,3,$fn=30);
    translate([9.1, -2.6]) ring(6,4.5,3,$fn=30);
  }
  translate([35,20]) {
    
  }
}

module ring(od,id,h)
{
  difference(){
    cylinder(d=od,h=h);
    translate([0,0,-.01]) cylinder(d=id,h=h+.02);
  }
}