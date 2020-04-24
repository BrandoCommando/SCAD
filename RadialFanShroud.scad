fanow=20;
fanoh=30;

/*difference()
{
  cube([fanow+2,fanoh+2,4]);
  translate([1,1,-.01]) cube([fanow,fanoh,4.02]);
}
*/

module scoop() {
  polygon([[0,0],[0,fanoh+4],[2,fanoh+4],[5,fanoh+2],
  
    [8,fanoh-1],
    [10,fanoh-6],
    [13,fanoh/2-6],[17,fanoh/2-8],[20,fanoh/2-10],[20,0]]);
}

rotate([0,-90]) {
linear_extrude(2) scoop();
translate([0,0,2]) linear_extrude(fanow)
difference(){
  scoop();
  translate([0,1]) scale([0.8,0.9,1.1]) scoop();
  polygon([[15,1],[15,6],[21,4],[21,1]]);
}
translate([0,0,fanow+2]) linear_extrude(2) scoop();
}