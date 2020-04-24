$fn=32;

wall_thickness=1.2;
brick_width=4;
brick_height=2;
brick_depth=2;

nub_spacing=8;
nub_dia=4.8;
nub_height=2;

bnub_od=6.5;
bnub_id=bnub_od-wall_thickness*2;

outer_spacing = .2;

total_width=brick_width*nub_spacing-outer_spacing;
total_height=brick_height*nub_spacing-outer_spacing;
total_depth=brick_depth*4+nub_height;

echo(str("Size: ",total_width,"x",total_height,"x",total_depth));

rotate([0,0,90]) lego();
*test();

module test() {
  for(xi=[0:4]) translate([xi*(total_width+outer_spacing),0]) lego();
  #translate([total_width+outer_spacing-nub_spacing,total_height,total_depth-nub_height+outer_spacing]) rotate([0,0,-90]) lego();
}

module lego() {
  shell();
  nubs();
  underside();
}

module shell()
{
  difference() {
    cube([total_width,total_height,total_depth-nub_height]);
    translate([wall_thickness,wall_thickness,-.01])
      cube([brick_width*nub_spacing-wall_thickness*2-outer_spacing,brick_height*nub_spacing-wall_thickness*2-outer_spacing,brick_depth*4-wall_thickness]);
  }
}

module underside()
{
  intersection(){
    cube([total_width,total_height,total_depth-nub_height]);
    union() {
      startx=nub_spacing-outer_spacing/2;
      if(brick_width>1&&brick_height>1)
        for(x=[startx:nub_spacing:total_width],y=[nub_spacing:nub_spacing:total_height])
          translate([x,y]) {
            linear_extrude(brick_depth*4,convexity=3) rotate([0,0,360/16]) difference() { circle(d=bnub_od); circle(d=bnub_id); }
            translate([0,0,nub_height+1]) rotate([0,0,360/16]) difference() {
              chamh=brick_depth*4-nub_height-1-wall_thickness;
              d1=bnub_od;
              cylinder(d1=d1,d2=d1+chamh,h=chamh);
              id1=bnub_id;
              translate([0,0,-.01]) cylinder(d1=id1,d2=0,h=chamh+.02);
            }
          }
      translate([wall_thickness,wall_thickness,nub_height+1])
      {
        mirrory(total_height-wall_thickness*2+outer_spacing/2) rotate([45,0]) cube([total_width,10,10]);
        mirrorx(total_width-wall_thickness*2+outer_spacing/2) rotate([0,-45]) cube([10,total_height,10]);
      }
    }
  }
}

module nubs()
{
  translate([0,0,brick_depth*4])
  for(nubx=[nub_spacing/2-outer_spacing/2:nub_spacing:total_width],nuby=[nub_spacing/2-outer_spacing/2:nub_spacing:total_height])
    translate([nubx,nuby]) rotate([0,0,360/16]) cylinder(d=nub_dia,h=nub_height);
}

module mirrorx(offset) {
  translate([offset/2,0]) for(m=[0,1]) mirror([m,0]) translate([offset*-.5,0]) children();
}
module mirrory(offset) {
  translate([0,offset/2,0]) for(m=[0,1]) mirror([0,m,0]) translate([0,offset*-.5,0]) children();
}