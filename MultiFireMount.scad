fire_count=4;
mount_height=190;

difference() {
  cube2([126,15*fire_count+6,mount_height]);
  for(yi=[1:fire_count])
  translate([5,5+(yi-1)*15,3]) rotate([0,0])
    cube2([116,11,mount_height],4.5);
}

module cube2(dims,r=2) {
  minkowski() {
    translate([r,r,r]) cube([dims[0]-r*2,dims[1]-r*2,dims[2]-r*2]);
    sphere(r=r,$fn=r*10);
  }
}