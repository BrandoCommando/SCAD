cube([192,9,1]);
for(x=[20:36:170]) translate([x,0,20]) rotate([0,90,0]) linear_extrude(8) polygon([[0,0],[20,40],[20,0]]);
linear_extrude(2)
difference() {
round_rect([192,50],1);
  mirrorx(96) polygon([[-1,6],[20,30],[20,51],[-1,51]]);
  
  translate([20,0]) {
    
for(x=[10:36:140])
{
  translate([x-1,6]) round_rect([26,40],r=8);
  translate([x+2.5,6]) square([19,50]);
}
}
}

module round_rect(dims,r=1)
{
  spots=[[r,r],[r,dims[1]-r],[dims[0]-r,dims[1]-r],[dims[0]-r,r]];
  for(i=[0:3])
    translate(spots[i]) rotate([0,0,270+i*90]) circle(r=r,$fn=16+(r*8));
  translate([r,0]) square([dims[0]-r*2,dims[1]]);
  translate([0,r]) square([dims[0],dims[1]-r*2]);
}

function arc(a1,a2,r,$fn) =
  (a1+((a2-a1)/$fn)>=a2?
    [arcpoint(a2,r)] :
    concat([arcpoint(a1,r)],arc(a1+$fn, a2, r, $fn)));
function arcpoint(angle,r) = [r*cos(angle),r*sin(angle)];

module mirrorz(offset=0)
{
  translate([0,0,offset]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,offset*-1]) children();
}
module mirrory(offset=0)
{
  translate([0,offset,0]) for(m=[0,1]) mirror([0,m,0]) translate([0,offset*-1,0]) children();
}
module mirrorx(offset=0)
{
  translate([offset,0]) for(m=[0,1]) mirror([m,0]) translate([offset*-1,0]) children();
}