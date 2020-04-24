side="top";
extra=4;
slope=0;
difference(){
  union(){
  translate([0,0,-1*extra]) cylinder(d1=21-(extra*1),d2=21,h=extra,$fn=100);
  cylinder(d=21,h=1,$fn=100);
  cylinder(d=10,h=1.6,$fn=40);
  cylinder(d=7.6,h=4,$fn=30);
  }
  translate([0,0,-0.01-extra]) {
    cylinder(d=3,h=20,$fn=20);
    if(side=="top")
      cylinder(d=7,h=4,$fn=40);
    else
      cylinder(d=6.5,h=3,$fn=6);
    if(slope)
    {
      if(side=="top")
        translate([0,0,4.99]) cylinder(d1=7.5,d2=3,h=extra,$fn=40);
      else
        translate([0,0,2.99]) cylinder(d1=6.5,d2=3,h=3,$fn=6);
    }
  }
}