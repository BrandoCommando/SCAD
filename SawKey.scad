difference(){union(){
cube([10,17,7]);
translate([3.4,2,7]) cube([3.2,13,16]);
}
  translate([6.61,1.49,7]) mirror([1,0,0]) rotate([180,270,90]) linear_extrude(14.02) polygon([[0,0],[16.01,0],[16.01,1]]);
  translate([3.39,1.49,7]) mirror([0,0,0]) rotate([180,270,90]) linear_extrude(14.02) polygon([[0,0],[16.01,0],[16.01,1]]);
  translate([3.19,1.99,7]) mirror([0,1]) rotate([0,270,180]) linear_extrude(4.02) polygon([[0,0],[16.01,0],[16.01,1.5]]);
  translate([3.19,15.01,7]) rotate([0,270,180]) linear_extrude(4.02) polygon([[0,0],[16.01,0],[16.01,1.5]]);
  translate([-.01,-.01,-.01]) rotate([0,0,90]) rotate([90,0]) linear_extrude(10.02) polygon([[1,0],[0,7],[0,0]]);
  translate([-.01,17.01,-.01]) mirror([0,1]) rotate([90,0,90]) linear_extrude(10.02) polygon([[1,0],[0,7],[0,0]]);
  translate([10.01,-.01,-.01]) rotate([0,0,0]) rotate([270,180]) linear_extrude(17.02) polygon([[1,0],[0,7],[0,0]]);
  translate([-.01,-.01,-.01]) mirror([1,0]) rotate([0,0,0]) rotate([270,180]) linear_extrude(17.02) polygon([[1,0],[0,7],[0,0]]);

}
translate([3.5,5,14.7]) cube([3,7,.8]);
translate([3.5,5,16.3]) cube([3,7,.8]);
translate([4.5,2.2,8]) rotate([90,0,90]) linear_extrude(1) polygon([[0,0],[0,6],[3,15],[9.6,15],[12.6,6],[12.6,0]]);
