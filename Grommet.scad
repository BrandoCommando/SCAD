th = 23/32*25.4;
echo(str("Total Height: ",th));
difference(){
  union(){
    cylinder(d=60,h=2,$fn=120);
    translate([0,0,2]) cylinder(d=51,h=th-2,$fn=100);
    for(i=[0:8])
    translate([0,0,5+i]) rotate([0,0,i*105]) rotate_extrude(angle=60,$fn=100) translate([25,0]) scale([0.5,0.8]) circle(d=4,$fn=20);
  }
  translate([0,0,2]) cylinder(d1=44,d2=48,h=6,$fn=90);
  translate([0,0,7.99]) cylinder(d=48,h=th+.02,$fn=100);
  for(r=[0,90]) rotate([0,0,r])
  translate([-20,-.5,-.01]) cube([40,1,2.02]);
}