hatdia=160;

difference() {
  translate([0,0,-hatdia*.25])
  intersection() {
    scale([.9,1,1]) sphere(d=hatdia,$fn=120);
    translate([hatdia*-.5,hatdia*-.5,hatdia*.25]) cube([hatdia,hatdia,30]);
  }
  translate([0,0,-19]) scale([.8,.9,.4]) sphere(d=hatdia,$fn=100);
  translate([12,0]) {
  translate([-65,-35,10]) {
    translate([8,0]) cube([32,70,21]);
    translate([24,35,-10.01])
      for(x=[-11.5,11.5],y=[-29,29]) 
        translate([x,y]) cylinder(d=3,h=20,$fn=20);
  }
  for(x=[-9,9]) translate([x,32.5,20]) rotate([0,0,-90]) rotate([0,90]) rotate([0,0,-90]) battery();
    translate([18,-35,22]) cube([20,70,20]);
  }
}


module battery(type="18650",neg=1,top=0)
{
  noff=neg?4:0;
  if(type=="18650") {
    cylinder(d=18+(neg?0.5:0),h=65+noff,$fn=40);
    translate([-9-(neg?0.25:0),-11]) cube([18+(neg?0.5:0),11,65+noff]);
    if(neg)
    {
      for(m=[0,1]) translate([0,0,m?65+noff:0]) mirror([0,0,m]) {
        translate([-5,-10.02,-1.7]) cube([10,17,1]);
        if(top)
          translate([-5.5,-6,-1.7]) cube([11.02,4,1]);
        translate([0,0,-.71]) {
          cylinder(d=8,h=2.02,$fn=30);
          translate([-4,-10.01]) cube([8,10,2.02]);
          translate([-5,-14.01]) cube([10,14,2.02]);
        }
        *translate([-2,1,-1.7]) cube([4,10,1]);
        *translate([-1,-5,-1.2]) cube([2,10,2]);
        *translate([-3,9.01,-3.01]) cube([6,1,2.3]);
      }
    } else
    translate([0,0,64.99+noff]) cylinder(d=6,h=1.4,$fn=20);
  }
}