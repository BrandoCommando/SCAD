thick=4;
holed=6.8;
hook_type=4;
racks=2;
headoff=2;
xo=-15;
yo=20;
part="w";
if(part=="w") {
  linear_extrude(2) {
  difference(){
    circle(d=9,$fn=50);
    circle(d=6,$fn=40);
    translate([-10,-10]) square([20,10]);
  }
  for(m=[0,1]) mirror([m,0])
  polygon([[4.5,0],[24,4],[24,-.5],[22,-.5],[25.6,-4],[25.6,6],[3.5,1.4]]);
}
} else {
*for(i=[0:1])
  translate([2.5-xo*i,11+yo*i,10.4]) grab();
echo(str("build4(3)=",build4(racks)));
echo(str("buildpairs(",racks,")=",buildpairs(racks)));
boltpos=hook_type==4?build4(racks):
  [[9,7],[50,7],[50,36],[61,20],[20,20],[31,33]];
hook();
*!mount_block(1);
*!mount_plate();
*for(i=[0:1]) {
  *translate([0,i*40]) mount_block(3);
  *translate([14,14+i*40]) rotate([0,0,-90]) mount_block(2);
  for(j=[0:1])
  translate([65+j*40,10+i*40]) for(r=[0:4]) rotate([0,0,45+r*(360/5)]) translate([13,0]) mount_plate();
}
}
function buildpairs(pt=racks,force=0) = force || pt <= 0 ? concat([[pt,pt+1,holed],[0,racks,holed],[1,racks+1,holed]]) : concat(buildpairs(pt-2,0),buildpairs(pt,1));
function build4(pt=4,force=0) = force || pt <= 0 ? concat([[3-xo*pt,7+yo*pt],[44-xo*pt,7+yo*pt]]) : concat(build4(pt-1,0),build4(pt,1));
module hook(type=hook_type) {
  posn=hook_type==1?3:(
        hook_type==2?2:
        hook_type==3?-1:
        hook_type==4?5:1);
difference() {
  union() {
    linear_extrude(thick,convexity=3) minkowski(){
      union(){
        polygon([[0,-5],[8,-3],[8,5],[33.4,5],[33.4,-3],[34,-3],[34,5+headoff],[7.4,5+headoff],[7.4,-2.5],[0,-4.5]]);
        if(hook_type==3)
          translate([48,5]) rotate([0,0,10]) square([2,60]);
        else if(hook_type==4)
        {
          translate([0,holed/2-1.5+headoff,0])
            for(pairs=buildpairs())
          //for(pairs=[[0,4,holed],[0,1,holed],[1,5,holed],[2,3,holed],[4,5,holed]])
            hull(){
              translate(boltpos[pairs[0]]) circle(d=pairs[2],$fn=20);
              translate(boltpos[pairs[1]]) circle(d=pairs[2],$fn=20);
            }
        }
        translate([37,20]) difference() {
          intersection() {
            union(){
              if(hook_type<3)
              {
              circle(d=30,$fn=30);
              translate([11,-15]) square([20,10+(hook_type<3?20:0)]);
              }
            }
            if(hook_type<3)
            translate([0,-15]) square([15,33-(hook_type<3?0:5)]);
          }
          if(hook_type==1)
            circle(d=28,$fn=25);
          if(hook_type==2)
            translate([0,2,0]) scale([1,1.15]) circle(d=28,$fn=25);
        }
        *polygon([[50,5],[40,30],[40,5]]);
        *translate([49,5]) rotate([0,0,20]) square([1,30]);
      }
      circle(d=3,$fn=20);
    }
    if(posn>=0)
    translate([0,holed/2-1.5+headoff]) for(posi=[0:posn])
      translate(boltpos[posi]) cylinder(d=6,h=thick,$fn=30);
  }
  *translate([-2,-2,thick]) cube([40,6,24.5]);
  *translate([46,8,thick]) cube([6,34,24]);
  if(posn>=0)
  translate([0,holed/2-1.5+headoff,-.01]) for(posi=[0:posn])
      translate(boltpos[posi]) cylinder(d=holed,h=thick+.02,$fn=20);
}
}
module grab()
{
  rotate([0,90,0]) rotate([0,0,180]) translate([0,-27.5,-3.6]) import("ToolGrab_SingleHookedQI7.stl");

}
module mount_plate()
{
  difference() {
    union() {
      cylinder(d=13.8,h=4,$fn=40);
      cylinder(d1=13.8,d2=16,h=4,$fn=40);
      translate([0,0,4]) cylinder(d=16,h=1,$fn=40);
      cylinder(d=5.5,h=9,$fn=40);
    }
    translate([0,0,-.01]) {
      cylinder(d=4,h=9.02,$fn=40);
      cylinder(d1=8,d2=4,h=2,$fn=40);
    }
  }
}
module mount_block(points=2)
{
  spots=[[0,25.4],[0,0],[25.4,0]];
  linear_extrude(25.4/2) difference() {
    union(){
      if(points>1)
      for(i=[0:points-2])
        hull() {
          translate(spots[i]) circle(d=4,$fn=8);
          translate(spots[i+1]) circle(d=4,$fn=8);
        }
    for(spoti=[0:points-1])
      translate(spots[spoti]) circle(d=14,$fn=40);
  }
    for(spoti=[0:points-1])
      translate(spots[spoti]) circle(d=5,$fn=20);
  }
}