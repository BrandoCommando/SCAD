size_in=1.25;
difference() {
  cube([inches(size_in)*2+14,inches(size_in)+10,inches(size_in)+6]);
  translate([2,2,2]) cube([inches(size_in)*2+10,inches(size_in)+6,inches(size_in)+6]);
}
for(x=[0,inches(size_in)+4]) translate([5+x,5])
  !cube2([inches(size_in),inches(size_in),inches(size_in)],2.5,$fn=40);
function inches(in) = 25.4 * in;

module cube2(dims, r=5, $fn=20)
{
  minkowski() {
    translate([r,r,r]) cube([dims[0]-r*2,dims[1]-r*2,dims[2]-r*2]);
    sphere(r=r, $fn=$fn);
  }
}