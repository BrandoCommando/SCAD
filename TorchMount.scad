if(!part) torchmount();
module torchmount() {
main_run=165;
main_rise=19;
mainang=atan(main_rise/main_run);
//echo(str("Main Angle: ",mainang));
*%translate([0,-2,42]) cube([200,4,10]);
mirror([0,0,1]) 
difference() {
  union(){
    intersection(){
    translate([0,0,-20]) cylinder(d=42,h=66,$fn=80);
    translate([-20,-20,-20]) cube([28,40,66],2);
    }
    translate([-4,-24,-20]) cube([8,48,19]);
    translate([-22,-32,36]) cube2([169,64,8],2);
    translate([-22,-32,40]) rcube([169,64,6],2);
    translate([100,-25,20+26]) mirror([0,0,1]) cube([20,50,28],2);
    for(m=[0,1]) mirror([0,m]) translate([100,-32,-20]) cube2([20,12,66],2);
  }
  cylinder(d=3,h=80,$fn=20);
  translate([-3,-3]) cube([6,6,29]);
  translate([0,0,-17]) rotate_extrude(convexity=4,$fn=80) translate([19,0]) polygon([[0,3],[1.5,0],[3,0],[3,9],[0,9]]);
  for(m=[0,1]) mirror([0,m]) translate([-4.01,-20.01,-1]) rotate([60,0]) mirror([0,1,0]) cube([8.02,10,10]);
  translate([99.9,-15,26]) mirror([0,0,1]) cube([22,30,24]);
  translate([0,0,-26.5]) {
    cylinder(d=33,h=35,$fn=80);
    translate([0,-33/2]) cube([100,33,35]);
    translate([0,0,34]) {
      sphere(d=33,$fn=80);
      rotate([0,-15,0]) rotate([0,90]) {
        cylinder(d=33,h=20,$fn=80);
        translate([0,0,20]) cylinder(d=36,h=20,$fn=80);
        translate([0,0,40]) {
          sphere(d=36,$fn=80);
          rotate([0,5]) {
            cylinder(d1=36,d2=33,h=30,$fn=80);
            translate([0,0,30]) {
              sphere(d=33,$fn=80);
              rotate([0,2.5]) {
                cylinder(d=33,h=30,$fn=80);
                translate([0,0,30]) {
                  sphere(d=33,$fn=80);
                  rotate([0,5]) {
                    cylinder(d=33,h=70,$fn=80);
                  }
                }
              }
            }
          }
        }
      }
      *rotate([0,-mainang,0]) rotate([0,90,0]) cylinder(d=33,h=sqrt(pow(main_run,2)+pow(main_rise,2)),$fn=80);
      //translate([main_run,0,main_rise]) sphere(d=33,$fn=80);
    }
  }
  for(y=[-25,25],x=[-15,30,140]) translate([x,y,-.01]) cylinder(d=inches(1/4),h=50,$fn=20);
  for(pos=[[[15,0,22],22],[[124,0,14],30]]) translate(pos[0]) rotate([0,90]) rotate_extrude(convexity=4,$fn=100) translate([pos[1],0]) square([4,9]);
  *for(y=[-21.5,18.5]) translate([10-1.5,y]) cube([9,3,44]);
  *linear_extrude(50,convexity=3)
    for(y=[-20,20],x=[10]) translate([x,y,-.01]) hull() {
      circle(d=3,$fn=20);
      translate([6,0]) circle(d=3,$fn=20);
    }
  *translate([10-1.5,-20,43]) cube([9,40,10]);
  *translate([0,0,43]) linear_extrude(10,convexity=3) {
    hull() {
      for(y=[-20,20],x=[10]) translate([x,y,-.01]) {
        circle(d=3,$fn=20);
        translate([6,0]) circle(d=3,$fn=20);
      }
    }
  }
}
}

module rcube(dims,r=5,$fn=30)
{
  linear_extrude(dims[2],convexity=3) {
    for(x=[r,dims[0]-r],y=[r,dims[1]-r])
      translate([x,y]) circle(r=r,$fn=$fn);
    translate([0,r]) square([dims[0],dims[1]-r*2]);
    translate([r,0]) square([dims[0]-r*2,dims[1]]);
  }
}
module cube2(dims,r=5,$fn=30)
{
  minkowski() {
    translate([r,r,r]) cube([dims[0]-r*2,dims[1]-r*2,dims[2]-r*2]);
    sphere(r=r,$fn=$fn);
  }
}
function inches(in) = 25.4 * in;