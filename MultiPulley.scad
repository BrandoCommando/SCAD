part="big";
include <GT2Pulley.scad>;
total_teeth=150;

if(part=="small")
  gt2_pulley(20,1,1);
else if(part=="big")
  pulley_circuit(72,72);
else if(part=="wall")
  wall(148);
else if(part=="combo")
{
  gt2_pulley(60,1,1);
  translate([0,0,9]) gt2_pulley(20,1,1);
} if(part=="circuit") {
*pulley_circuit(20,80,200);
rotate([0,0,180]) pulley_circuit(60,50);
translate([0,0,9]) pulley_circuit(20,72);
  wall(140);
}
module wall(width) {
  translate([width*-.5,-10,-4.5]) difference() {
    union(){
    translate([0,0]) cube([width,20,4]);
    translate([0,10]) cylinder(d=20,h=4,$fn=40);
      translate([width,10]) cylinder(d=20,h=4,$fn=40);
    }
    translate([0,10,-.01]) cylinder(d=8,h=4.02,$fn=50);
    translate([width,10,-.01]) cylinder(d=8,h=4.02,$fn=50);
    for(x=[10:20:width-10])
      translate([x,10,-.01]) {
        cylinder(d=3,h=4.02,$fn=20);
        translate([0,-1.5]) cube([8,3,4.02]);
        translate([8,0]) cylinder(d=3,h=4.02,$fn=20);
      }
  }
}
module pulley_circuit(teeth1, teeth2, total_teeth=total_teeth)
{
  teeth_left = total_teeth - teeth1/2 - teeth2/2;
  od1=tooth_spacing(2,0.254,teeth=teeth1);
  od2=tooth_spacing(2,0.254,teeth=teeth2);
  small=od1>od2?od2:od1;
  b=abs(od1-od2)/2;
  dist=sqrt(pow(teeth_left,2)-pow(b,2));
  ang=atan(b/dist);
  echo(str("Circuit(",teeth1,",",teeth2,",",total_teeth,"): Teeth Left: ", teeth_left,", distance: ", dist, " b: ", b, " Angle: ", ang));
  gt2_pulley(teeth1,1,1);
  for(m=[0,1]) mirror([0,m]) translate([dist/2,0]) mirror([od1>od2?1:0,0]) translate([-dist/2,0])
  translate([dist,b+small/2,1.5]) rotate([0,0,180+ang]) cube([teeth_left,1,6]);
  translate([dist,0]) gt2_pulley(teeth2,1,1);
}
module gt2_pulley(teeth,idler=0,retainer=0,base=0)
{
  pulley("GT2 2mm", tooth_spacing (2,0.254,teeth=teeth) , 0.764 , 1.494, 12, idler = idler, retainer = retainer, motor_shaft = 3.2, draw_base = base, teeth=teeth );
}