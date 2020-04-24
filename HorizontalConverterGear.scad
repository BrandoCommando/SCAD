if(!part)
{
  horiz_converter_gear();
}
module horiz_converter_gear(pitch=4.35,bigd=20,teeth=20,theight=2,ty=2) {
  tt=pitch*.2;
  tr=theight;
difference(){
  cylinder(d=bigd+.25, h=6, $fn=40);
  translate([0,0,1]) cylinder(d=15, h=6, $fn=6);
  translate([0,0,-.01]) cylinder(d=8.2, h=1.02, $fn=40);
}
translate([0,0,6])
{
    for(t=[0:teeth-1]) {
      rotate([0,0,t*(360/teeth)]) {
        translate([bigd/2,0]) rotate([0,-90,0])
          linear_extrude(ty) polygon([for(i=[30:5:150]) [tr*(.5+sin(i*-3)/2)*1.1,tt*2*cos(i)]]);        
      }
    }
}
}