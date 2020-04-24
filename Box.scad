part="bin";
preview=0;

// Total Width (X)
total_width=120; // [4:300]
// Total Depth (Y)
total_depth=40; // [4:300]
// Total Height (Z)
total_height=22; // [4:300]
// Material Thickness
thick=2.7; // [0.1:0.1:9.0]
finger_width=4;
// Finger Depth (set to 0 to match thickness)
finger_depth=0; // [0:0.1:9.0]

kerf=0.1;
first_y_offset=5;
last_y_offset=5;

finger_thick=finger_depth==0?thick:finger_depth;

if(preview) preview();
else color("red") svg();
module preview() {
  rotate([0,0]) linear_extrude(thick) svg_bottom();
  color("blue") for(x=[thick,total_width])
    translate([x,0]) rotate([0,-90]) linear_extrude(thick) svg_left();
  color("green") for(y=[thick,total_depth])
    translate([0,y]) rotate([90,0]) linear_extrude(thick) svg_front();
}

module svg()
{
  translate([total_depth,0]) rotate([0,0,90]) svg_left();
  translate([total_depth+kerf,0]) svg_front();
  translate([0,-total_height-kerf]) rotate([0,0,90]) mirror([0,1]) svg_left();
  translate([total_width+total_depth+kerf,-total_height-kerf]) mirror([1,0]) svg_front();
  translate([0,-total_height-total_depth-kerf*2]) svg_bottom();
}
module svg_front()
{
  difference() {
    square([total_width,total_height]);
    for(x=[0:finger_width*2:total_width-kerf])
      translate([x-kerf,-.01]) square([finger_width+kerf*2,finger_thick]);
    for(y=[finger_width+thick-.01:finger_width*2:total_height-kerf],x=[-.01,total_width-finger_thick])
      translate([x,y]) square([finger_thick,finger_width-kerf]);
  }
}
module svg_left()
{
  difference() {
    square([total_height,total_depth]);
    translate([-.01,-.01]) square([finger_thick+kerf+.02,first_y_offset]);
    translate([-.01,total_depth-last_y_offset]) square([finger_thick+kerf+.02,last_y_offset+.01]);
    for(y=[first_y_offset-finger_width:finger_width*2:total_depth-last_y_offset])
      translate([-.01,y-kerf]) square([finger_thick+kerf+.02,finger_width+kerf*2]);
    for(x=[thick-kerf-.01:finger_width*2:total_height],y=[-.01,total_depth-finger_thick-kerf])
      translate([x,y]) square([finger_width+kerf*2+.02,finger_thick+kerf+.02]);
  }
}
module svg_bottom()
{
  difference() {
    square([total_width,total_depth]);
    for(x=[finger_width:finger_width*2:total_width],y=[-.01,total_depth-finger_thick-kerf])
      translate([x-kerf,y]) square([finger_width+kerf*2,finger_thick+kerf+.02]);
    for(y=[first_y_offset:finger_width*2:total_depth-last_y_offset],x=[-.01,total_width-finger_thick-kerf])
      translate([x,y-kerf]) square([finger_thick+kerf+.02,finger_width+kerf*2]);
  }
}