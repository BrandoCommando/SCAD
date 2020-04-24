height=30;
size=1*25.4;
holes=1;
vholes=2;
dist=(size-10)/(holes+1);
vdist=(height/(vholes+1));
echo(str("dist: ", dist, " vdist: ", vdist));
difference() {
  union(){
    linear_extrude(height,convexity=10) polygon([[0,0],[size,0],[size-2,3],[10,3],[3,10],[3,size-2],[0,size]]);
    linear_extrude(1) polygon([[size-5,3],[3,size-5],[0,0]]);
  }
  translate([11,11,1]) cylinder(d=16,h=height+.02,$fn=40);
  #for(m=[0,1])
    mirror([m,-m]) for(i=[0:holes-1],j=[0:vholes-1]) translate([10+((i+1)*dist),-.01,(j+1)*vdist]) rotate([-90,0]) {
      cylinder(d=3,h=4,$fn=20);
      translate([0,0,2]) cylinder(d1=3,d2=6,h=1.02,$fn=30);
    }
}