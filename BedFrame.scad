bed_dims=[feet(6),feet(7)+inches(.25),inches(9)];
storage_depth=inches(22);
plywood="burlywood";
cedar="sandybrown";

inner_gap=bed_dims[0]-(storage_depth*2);

echo(str("Inner Gap: ",inner_gap/25.4,"in"));

bed();
storage();
supports();
footboard();
headboard();

module footboard(main_h=inches(15),main_offz=0) {
  echo(str("Panel Size: ", (bed_dims[0]-inches(7))/25.4,"x",(main_h)/25.4,"in"));
  // plywood
  color(plywood) {
    // main panel
    translate([inches(3.5),inches(1.25),inches(4)+main_offz]) {
      cube([bed_dims[0]-inches(7),inches(3/4),main_h]);
    }
  }
  // cedar
  color(cedar) {
    translate([0,0,inches(4)+main_h+main_offz])
    {
      cube([bed_dims[0],inches(3.5),inches(1.5)]);
      translate([inches(-1),inches(-1),inches(1.5)])
        cube([bed_dims[0]+inches(2),inches(5.5),inches(1.5)]);
    }
    // outer stretchers
    for(z=[inches(4)+main_offz,inches(4)+main_h+main_offz-inches(3.5)])
    {
      translate([inches(3.5),inches(.5),z]) cube([bed_dims[0]-inches(7),inches(3/4),inches(3.5)]);
    // inner stretchers
//    for(z=[inches(4),inches(15.5)])
      if(main_offz==0)
      translate([inches(3.5),inches(2),z]) cube([bed_dims[0]-inches(7),inches(1.5),inches(3.5)]);
    }
    //posts
    mirrorx(bed_dims[0]/2) cube([inches(3.5),inches(3.5),inches(4)+main_h+main_offz]);
  }
}
module headboard() {
  //54
  translate([0,bed_dims[1]+inches(3.5)]) footboard(inches(26),inches(24));
  color(cedar)
  for(z=[inches(4),inches(19-3.5)]) translate([inches(3.5),bed_dims[1]+inches(3.5),z]) cube([bed_dims[0]-inches(7),inches(1.5),inches(3.5)]);
}

module bed() {
  color("white")
  translate([0,inches(3.5),inches(19)]) cube(bed_dims);
}

module supports() {
  leg_off=bed_dims[1]/3;
  mirrorx(bed_dims[0]/2)
  {
    color(cedar)
    translate([storage_depth,inches(3.5),inches(19-2.5-3/4)]) cube([inches(1.5),bed_dims[1],inches(2.5)]);
    for(y=[leg_off+inches(3.5):leg_off:bed_dims[1]-5])
      translate([storage_depth,y,0]) cube([inches(1.5),inches(1.5),inches(19-2.5-3/4)]);
  }
}
module storage() {
  box_w=(bed_dims[1]-(inches(3/4)))/3;
  echo(str("Box Width: ", (box_w/25.4), "in"));
  mirrorx(bed_dims[0]/2)
  {
    color(plywood)
    translate([0,inches(3.5),inches(4)]) difference() {
      cube([storage_depth, bed_dims[1],inches(15)]);
      for(y=[inches(3/4):box_w:bed_dims[0]])
      translate([-1,y,inches(3/4)]) cube([inches(15.25)+1,box_w-inches(3/4),inches(13.5)]);
    }
  }
}


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

function feet(ft) = inches(12) * ft;
function inches(in) = in * 25.4;
