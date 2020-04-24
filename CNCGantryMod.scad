piped=23.5;
for(m=[0,1]) mirror([m,0])
      translate([34.5,52,-20])
        pipe(200);
translate([0,75]) rotate([0,0,-45]) {
rotate([0,0,45]) mirror([0,0,1]) translate([-105,-63.57]) mimport("C-XYZ.STL");
rotate([0,0,45]) translate([-105,-63.57,101]) mimport("C-XYZ.STL");
translate([0,0,66.5]) rotate([180,0,180]) translate([-75.85,34.3,2]) rotate([0,90]) mirror([0,0,0]) gantryxy();
translate([0,0,66.5]) rotate([0,0,90]) translate([-75.85,34.3,-30]) rotate([0,90]) mirror([0,0]) gantryxy();
}

module gantryxy() {
for(deg=[0,120,240],z=[0,76.6]) translate([0,0,(deg==0&&z!=0?2:0)+z]) rotate([0,0,deg]) translate([0,-22.5,9]) rotate([0,90]) translate([0,0,-3.5]) {
      bearing608();
      if(deg!=0)
        translate([0,0,deg==240?-5:7]) cylinder(d=14,h=5,$fn=6);
      translate([0,0,deg==240?0:(deg==120?-20:-18)]) 
      cylinder(d=7.8,h=20,$fn=40);
    }
translate([-118.8,-113.8]) mimport("C-XY.STL");
translate([0,0,-20]) pipe(140);
}

module mimport(file)
{
  import(str("Mostly_Printed_CNC_525_-Updated_5_25_16-/files/",file));
}
module pipe(length=100)
{
  %difference(){
    cylinder(d=piped,h=length,$fn=50);
    translate([0,0,-.01])
      cylinder(d=21.2344,h=length+.02,$fn=40);
  }
}
module bearing625(){ring(16,5,5);}
module bearing608(){ring(22,8,7);}
module ring(od,id,h)
{
  difference(){
    cylinder(d=od,h=h,$fn=od*2);
    translate([0,0,-0.01]) cylinder(d=id,h=h+0.02,$fn=id*4);
  }
}