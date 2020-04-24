part="wheel2";

preview_spokes=1;
preview_nubs=1;
preview_bearings=0;
preview_plates=0;
// Small "epsilon" value for ensuring manifold geometry. "slop" is easier to type than "manifold."
slop = 0.01;

/* [Main Dimensions] */
// Distance from the hub axle center to the center of the axles of each roller.
wheel_axle_radius = 36;
// Angle of rollers relative to the hub axle. Change this and they're probably not mecanum wheels anymore. 
wheel_angle = 45;
// Number of roller spokes on the hub. 
num_wheels = 10;

// This example is for MR63ZZ bearings, because they are cheap to buy and mecanum wheels use a lot of them.
/* [Bearing Dimensions] */
// Inner diameter of bearing. 
bearing_inner_diameter = 3;
//bearing_inner_diameter = 8;
// Outer diameter of bearing, plus extra clearance for printing. Should be a snug fit.
bearing_outer_diameter = 8 + 0.2;
//bearing_outer_diameter = 22 + .02;
// Width of bearing. 
bearing_width = 3;
//bearing_width = 7;
// Thickness of printed part holding the bearing in place. 
bearing_holder_width = 3;

spoke_fudge=-1;
spoke_holeys=[2];

/* [Bearing Spacer Dimensions] */
// Width of the bearing spacer at the point where it contacts the bearing.
bearing_inner_contact_min_width = 0.4;
// Width of the spacer when at the roller.
bearing_inner_contact_max_width = 1.2;
// Height of the spacer (distance from the bearing to the main body of he roller.
bearing_inner_contact_height = 1.0;

/* [Wheel Hub Dimensions] */
// Outer radius of the main hub holding the roller wheel spokes. Needs to be small enough to allow clearance for the rollers. 
hub_outer_radius = wheel_axle_radius - bearing_outer_diameter/2 - bearing_holder_width-1.5;
plate_hub_radius = hub_outer_radius-5;
// Thickness of the hub wheel. 
hub_thickness = 3;

// Amount to trim off outer edge of hub to make it more printable.
hub_printing_trim = 1; 

// Distance from edge of hub to motor. (Clearance for the rollers to spin without hitting the motor or frame.)
hub_motor_distance = 9.68; 

hub_type=2;

/* [Hub Inner Spoke Dimensions] */
// Thickness of the angled spoke from the inner hub to the motor shaft holder.
hub_spoke_thickness = 2.5;
// Number of inner spokes. Does not have to be the same as the number of wheel rollers. 
num_spokes = num_wheels;
hub2_diameter = 3;
hub2_offset = 1;

/* [Motor Shaft Dimensions] */
motor_mount_type = 2;
motor2_diameter = 8;
motor2_hex = 14.8;
motor2_hexh = 5.8;
// Radius of the solid piece holding the motor shaft, this forms the inner axle of the wheel hub. 
motor_attachment_radius = 4;
// Radius of the motor shaft. Extra clearnace for printing is added in this example. 
motor_shaft_r = 1.5 + 0.5;
// Amount to cut off a keyed motor shaft. Extra added to make it more snug in this example. Ideally pressure-fit, unless a set screw or glue is used. 
motor_shaft_key_inset = 0.5 + 0.2; 
// Length of motor shaft holder. 
motor_shaft_length = 9;

// Please disregard that these variable are prefixed "m3". That's just the size the first version was using. 
// These are more arbitrary parameters that can be changed. 
/* [Roller Screw Axle Dimensions] */
// Radius of the screw. (extra size for printing clearance is added in this example.)
m3_screw_r = 1.5 + 0.2;
m3_screw_shaft_length = 20; // Not counting length of head and nut, add 5mm to actual screw length.
// Radius of the nut is calculated to be the circle containing the nut, plus some extra print clearance. 
m3_nut_radius = 5.5 /2 / cos(30) + 0.5;
// Depth of the captive nut holder in the roller piece. 
m3_nut_holder_depth = 3;
// Overall thickness of the solid portion of the roller between the nut and the bearing spacer. 
m3_nut_holder_thickness = 19;
// Captive nut holder widens at the end of the roller to this radius to ease insertion of the nut.
m3_entrance_clearance_r = 4;

wheel_spoke_length = wheel_axle_radius - hub_outer_radius + hub_thickness;

// Calculate the thickness of the main hub section that holds the angled outer hub spokes.
wheel_attachment_thickness = (bearing_outer_diameter + bearing_holder_width*2) * sin(wheel_angle) +
                             bearing_width * sin(wheel_angle);
echo(str("WAT:",wheel_attachment_thickness));

// Width of the virtual wheel outline filled by the mecanum wheels.
contact_shape_thickness = 25;
// Height (radial measurement) of the virtual wheel outline filled by the mecanum wheels.
contact_shape_height = 16;
wheel_distance = 100;

include<MCAD/involute_gears.scad>

if(part=="assembly")
{
  body();
  mirrory() mirrorx() translate([wheel_distance,wheel_distance]) rotate([0,0,90]) rotate([90,0]) full_wheel();
}
if(preview_plates&&part!="plate")
  translate([0,0,wheel_attachment_thickness/2]) for(m=[0,1]) mirror([0,0,m])
    wheel_plate(1-m);
if(part=="wheel2")
{
  %translate([0,0,-20]) cylinder(d=wheel_axle_radius*2,h=10,$fn=100);
  difference() {
    cylinder(r=hub_outer_radius,h=wheel_attachment_thickness,$fn=100);
    translate([0,0,wheel_attachment_thickness-motor2_hexh]) cylinder(d=motor2_hex,h=wheel_attachment_thickness,$fn=6);
    translate([0,0,-slop]) cylinder(d=motor2_diameter,h=20,$fn=30);
    for(spoke_num=[1:num_spokes])
    {

      rotate([0,0,spoke_num*(360/num_spokes)]) {
        if(!preview_nubs)
        translate([hub_outer_radius-8,0,-0]) rotate([45,0]) {
          translate([-.1,-4,-.1]) cube([10.01,26,bearing_holder_width+.2]);
          for(y=spoke_holeys)
            translate([5,y,-10]) {
              cylinder(d=3,h=30,$fn=20);
              *cylinder(d=8,h=10,$fn=40);
              *translate([0,1.5,0]) mirror([0,1,0]) cube(10);
              translate([0,0,18+bearing_holder_width*2]) cylinder(d=6,h=10,$fn=40);
            }
        }
        translate([hub_outer_radius/2+hub2_offset,0,-slop]) {
          cylinder(d=hub2_diameter,h=22,$fn=20);
          *cylinder(d=hub2_diameter+5,h=5,$fn=30);
        }
      }
    }
  }
  if(preview_nubs||preview_bearings)
  %for(spoke_num=[1:num_spokes])
  {
      rotate([0,0,(spoke_num-.34)*(360/num_spokes)])
              translate([0,wheel_axle_radius+spoke_fudge+3,wheel_attachment_thickness/2]) rotate([0,45,0]) {
        if(preview_bearings)
          MR63ZZ_bearing();
       if(preview_nubs)
         for(m=[0,1]) mirror([0,0,m])
          mecanum_wheel_shape_3d();
       }
     }
  if(preview_spokes)
  intersection(){
    *cylinder(r=hub_outer_radius+22+bearing_outer_diameter,h=wheel_attachment_thickness,$fn=100);
    for(spoke_num=[1:num_spokes])
      spoke2(spoke_num);
          
  }
}
if(part=="wheel3") wheel3();
if(part=="spoke2") rotate([-45,0]) spoke2(0);
if(part=="spoke")
{
// Position the roller spoke half for printing
rotate([0, 180, 0])
translate([0, 0, -x2 + 0.48])
mecanum_wheel_shape_3d();
}
if(part=="spokemod")
{
%rotate([0, 180, 0])
translate([0, 0, -x2 + 0.48])
mecanum_wheel_shape_3d();
  translate([0,0,-2]) cylinder(d1=8,d2=11,h=8,$fn=40);
  translate([0,0,6]) cylinder(d1=11,d2=12,h=6,$fn=40);
  translate([0,0,12]) cylinder(d1=12,d2=13.5,h=4.5,$fn=40);
}
if(part=="2spoke")
  for(x=[0,20]) translate([x,0]) rotate([0,180,0]) translate([0,0,-x2+.48]) mecanum_wheel_shape_3d(x==0);
if(part=="preview")
{
// Preview gearmotor
  if(motor_mount_type==1)
translate([0,0, hub_motor_distance - wheel_attachment_thickness/2 + motor_shaft_length])
rotate([0, 180, 0])
motor_preview();
  for(m=[0,1]) mirror([0,0,m])
    wheel_plate(1-m);
}

// Preview virtual wheel shape
/*  
%rotate_extrude($fn = 50)
translate([wheel_axle_radius, 0, 0])
wheel_shape_2d();
*/
  
if(part=="wheel"||part=="preview")
{
  // Hub needs to be printed mirrored for 2 of the wheels.
  //mirror([1, 0, 0])
  hub();
}
if(part=="plate")
{
  for(m=[0,1]) translate([m*100,0]) wheel_plate(m);
}
if(part=="all")
{
  translate([0,-170,y2+2]) for(m=[0,1],n=[0,1]) translate([m*(wheel_axle_radius+9)*2,-n*(wheel_axle_radius+9)*2]) mirror([m,0]) wheel_plate(m);
  for(y=[0,(wheel_axle_radius+8)*2],m=[0,1]) translate([((wheel_axle_radius+8)*2)*m,y,wheel_attachment_thickness/2-hub_printing_trim]) mirror([m,0]) hub();
}
if(part=="all"||part=="spokes")
{
mirror([1,0])
rotate([0, 180, 0])
translate([-30, 0, -x2 + 0.48])
  translate([0, -wheel_axle_radius-20]) mirror([0,1]) for(col=[0:num_wheels/2-1],row=[0:3]) translate([col*20,row*20]) mecanum_wheel_shape_3d();
}


// Preview a sample bearing.
// Note that the bearing previewed here does not scale with parameters.
// If you want to see how a different bearing fits, replace this module. 
// This is included as a demonstration for a particular wheel size. It does not scale with other parameters. 
module MR63ZZ_bearing() {
  difference() {
    cylinder(r = bearing_outer_diameter/2, h = bearing_width, center = true, $fn = 30);
    cylinder(r = bearing_inner_diameter/2, h = bearing_width + 2*slop, center = true, $fn = 20);
  }
}
module wheel3() {
}
module body() {
  for(z=[-23])
  translate([0,0,z-4]) linear_extrude(6) {
    difference() {
      rsquare([280,320],r=20,center=true);
      mirrorx() mirrory() translate([77,55]) rsquare([46,90]);
    }
  }
}
module full_wheel(flip=0) {
  translate([0,0,wheel_attachment_thickness/-2]) {
    rotate([0,0,flip?-24:12]) import("MecanumWheel_Full.stl");
  *translate([0,0,wheel_attachment_thickness/2]) for(m=[0,1]) mirror([0,0,m])
    wheel_plate(1-m);
  }
  color("silver") translate([0,0,wheel_attachment_thickness/2]) mirror([0,0,1]) {
    rotate([0,0,12]) cylinder(d=motor2_hex-.2,h=motor2_hexh,$fn=6);
    cylinder(d=motor2_diameter,h=inches(2.75),$fn=40);
  }
  translate([0,0,-inches(2.25)+6]) {
    color("blue") translate([-26.38,0,-8]) rotate([0,0]) {
      cylinder(d=5,h=20,$fn=40);
      mirror([0,0,1]) translate([-21,-21]) cube([42,42,40]);
      translate([0,0,18]) mirror([0,0,1]) gear (number_of_teeth=11,
        circular_pitch=250,
        gear_thickness = 12,
        rim_thickness = 10,
        hub_thickness = 17,
        circles=0);
    }
    translate([0,0,39]) linear_extrude(7) difference() { circle(d=22,$fn=60); circle(d=8,h=40); }
    *translate([-14.8002,0,14.8002]) rotate([0,90,0]) translate([-105,-117]) import("HerringBone_Gear28.stl");
    *translate([-105,-117]) import("HerringBone_Gear28.stl");
    *import("Herringbone_47-40.stl");
    gear(number_of_teeth=27,circular_pitch=250,gear_thickness=12,rim_thickness=10,hub_thickness=17,cicles=5);
  }
}
module flat_spoke() {
  difference() {
    translate([0,-4]) linear_extrude(bearing_holder_width, convexity=3) {
      difference() {
        hull() {
          square([8,22]);
          translate([wheel_axle_radius/2+spoke_fudge,11]) circle(d=bearing_outer_diameter+bearing_holder_width*2,$fn=40);
        }
        *translate([20,11]) circle(d=bearing_outer_diameter,$fn=40);
      }
    }
    translate([14,25,-slop]) cylinder(d=20,h=10,$fn=40);
    translate([wheel_axle_radius/2+spoke_fudge,11-4,-.01]) {
      cylinder(d=bearing_outer_diameter-.4,h=bearing_width,$fn=40);
      cylinder(d=bearing_outer_diameter-.4,h=10,$fn=40);
    }
    *#rotate([0,0,-(360/num_spokes)]) translate([-hub_outer_radius+8,0]) rotate([-45,0]) translate([0,4]) cylinder(d=3,h=30,$fn=20);
    *translate([3,15]) rotate([0,360/num_spokes]) translate([0,0,-2]) cylinder(d=3,h=30,$fn=20);
    for(y=spoke_holeys) translate([5,y,-10.01])  cylinder(d=3,h=30.02,$fn=20);
  }
}

module spoke2(spoke_num=1) {
  intersection() {
    cylinder(r=hub_outer_radius+22+bearing_outer_diameter,h=wheel_attachment_thickness,$fn=100);
  difference() {
    rotate([0,0,spoke_num*(360/num_spokes)]) {
      translate([hub_outer_radius-8,0,-0]) rotate([45,0]) {
        flat_spoke();
      }
    }
    rotate([0,0,(spoke_num+1)*(360/num_spokes)]) translate([hub_outer_radius-8,0]) rotate([45,0]) for(y=spoke_holeys) {
      translate([5,y,-10]) cylinder(d=3,h=30,$fn=20);
      translate([5,y,14]) cylinder(d=6,h=5,$fn=30);
    }
  }
}
}
module wheel_plate(axle_hole=1)
{
  color("yellow") translate([0,0,-y2-2]) difference() {
    rotate_extrude($fn=80,convexity=3) difference() {
      union() {
        square([plate_hub_radius,wheel_attachment_thickness+1.9-(axle_hole?0:0)]);
        square([wheel_axle_radius+x1-1-spoke_fudge,4]);
        translate([wheel_axle_radius+x1-1-spoke_fudge,4]) circle(r=4,$fn=20);
      }
      translate([wheel_axle_radius+x1/2+1-spoke_fudge,7]) scale([1.3,1.1]) circle(r=5,$fn=40);
    }
      if(axle_hole)
      {
        translate([0,0,-slop]) {
          cylinder(d=motor2_diameter,h=20,$fn=30);
          difference() {
          cylinder(d=22.2,h=4,$fn=80);
          translate([0,0,3.4]) cylinder(d=8+1.22*2,h=1,$fn=50);
          }
        }
      }
      for(spoke_num=[1:num_spokes])
                rotate([0,0,spoke_num*(360/num_spokes)]) translate([hub_outer_radius/2+hub2_offset,0,-slop]) {
                  cylinder(d=hub2_diameter,h=22,$fn=20);
                  cylinder(d=hub2_diameter+3,h=4,$fn=30);
                }
    }
}

// Create a 2D shape that will define the "virtual wheel" to which the rollers will
// attempt to conform. Try different shapes to see weird results!
// y = radial dimension
module wheel_shape_2d() {
  // As an example, uncomment the next two lines to test making rollers with
  // very rounded ends to make a less square wheel cross-section. 
  // Warning! This particular shape increases the poly count, and SCAD might
  // be prohibitively slow.
  //*offset(r = 4)
  //*offset(r = -4)
  *difference(){
    square([contact_shape_height, contact_shape_thickness], center = true);
    translate([contact_shape_height/2,-contact_shape_thickness/4+4]) scale([2,2]) circle(d=2,$fn=12);
  }
  union() {
  square([contact_shape_height, contact_shape_thickness], center = true);
  *circle(d=contact_shape_thickness,$fn=20);
  hull() {
    *translate([contact_shape_height/2-1,0]) circle(r=1,$fn=20);
    x=contact_shape_height/2;
    y=contact_shape_thickness/2+2;
    *polygon([[0,-y],[0,y],[x,y-2],[x-1,y],[x,-y+2],[x-2,-y]]);
    *for(x=[contact_shape_height/-2+1,contact_shape_height/2-1],y=[contact_shape_thickness/-2+1,contact_shape_thickness/2-1]) translate([x,y]) circle(r=1,$fn=12);
  }
}
}

// Calculate intersection points to determine an angle to take a slice of the
// wheel profile. This is not remotely an optimal or particularly elegant solution,
// but it worked well for the wheels I wanted to make. 
x1 = cos(wheel_angle) * contact_shape_height/2;
y1 = sin(wheel_angle) * contact_shape_height/2;

y2 = y1 + contact_shape_thickness/2;
x2 = tan(wheel_angle) * y2;

cross_section_angle = atan(contact_shape_thickness/2 / (x1 + x2));

echo(str("X1:",x1," X2:",x2," Y1:",y1," Y2:",y2));
echo(cross_section_angle);
module only1st() {
  children(0);
}
module mecanum_wheel_shape_3d(nut=1) {
  difference() {
    // Create the base spoke shape
    rotate_extrude($fn=(part=="spoke"?60:20)) //$fn=60)
    rotate([180, 0, 90])
    intersection() {
      translate([-80,0]) square([160, 100]);
      // Take a slice of the intersection of the virtual wheel and allowable spoke cylinder. 
      projection(cut = true) 
      rotate([0, 45, 0])
      intersection() {
        translate([0, -wheel_axle_radius, 0])
        rotate([0,0,60]) rotate_extrude(angle=80,$fn = part=="spoke"?100:30)
        translate([wheel_axle_radius, 0, 0])
        wheel_shape_2d();
        
        rotate([0, wheel_angle, 0])
        cylinder(r = contact_shape_height/2, h = 50, center = true, $fn = 30);
      }
    }
    *translate([0, 0, -slop]) cylinder(r = 20, h = bearing_width/2 + 2*slop); // Remove material for hub
    translate([0, 0, -50]) cylinder(r = m3_screw_r, h = 100, $fn = 20); // Screw hole
    *if(nut) {
      translate([0, 0, bearing_width/2 + m3_nut_holder_thickness]) cylinder(r = m3_nut_radius, h = m3_nut_holder_depth + slop, $fn = 6); // Nut holder hole
      // Cutout for screw and nut at the end of the roller. 
      translate([0, 0, bearing_width/2 + m3_nut_holder_thickness + m3_nut_holder_depth])
      intersection() {
         remaining_height = x2 - bearing_width/2 - m3_nut_holder_thickness - m3_nut_holder_depth;
         cylinder(r1 = m3_nut_radius, r2 = m3_nut_radius + remaining_height/4, h = remaining_height, $fn = 6);
         cylinder(r = m3_entrance_clearance_r, h = remaining_height, $fn = 30);
      }
    } else {
      translate([0, 0, bearing_width/2 + m3_nut_holder_thickness]) cylinder(r = m3_nut_radius, h = m3_nut_holder_depth + slop, $fn = 30); // Nut holder hole
      // Cutout for screw and nut at the end of the roller. 
      translate([0, 0, bearing_width/2 + m3_nut_holder_thickness + m3_nut_holder_depth])
      intersection() {
         remaining_height = x2 - bearing_width/2 - m3_nut_holder_thickness - m3_nut_holder_depth;
         cylinder(r1 = m3_nut_radius, r2 = m3_nut_radius + remaining_height/4, h = remaining_height, $fn = 30);
         cylinder(r = m3_entrance_clearance_r, h = remaining_height, $fn = 30);
      }
    }
    // Cut out some extra clearance around the bearing spacer.
    // This cavity will collect fluff and other junk forever. It's great. 
    *translate([0, 0, bearing_width/2 - slop])
    difference() {
      cylinder(r1 = contact_shape_height/2 - 3.5 + bearing_inner_contact_max_width, r2 = contact_shape_height/2 - 3.5, h = bearing_inner_contact_height - 2*slop, $fn = 30); // Screw hole
      translate([0, 0, -slop]) cylinder(r1 = m3_screw_r + bearing_inner_contact_max_width, r2 = m3_screw_r + 2*bearing_inner_contact_max_width - bearing_inner_contact_min_width, h = bearing_inner_contact_height, $fn = 30); // Screw hole
    }
  }
  // Bearing spacer. Larger designs might want to omit this and go with a manufactured spacer matching the selected bearing. 
  *translate([0,0,bearing_width/2-bearing_inner_contact_height+slop]) cylinder(d=8,h=3,$fn=40);
  *translate([0, 0, bearing_width/2 - bearing_inner_contact_height + slop])
  *difference() {
    cylinder(r1 = m3_screw_r + bearing_inner_contact_min_width, r2 = m3_screw_r + bearing_inner_contact_max_width, h = bearing_inner_contact_height, $fn = 30);
    translate([0, 0, -slop]) cylinder(r = m3_screw_r, h = bearing_inner_contact_height + 2*slop, $fn = 30);
  }
}

module hub() {
  difference() {
    union() {
      // Wheel holders:
      for(wheel_num = [1: num_wheels]) {
        rotate([0, 0, 360/num_wheels * (wheel_num-1)])
        rotate([0, 45, 0])
        translate([0, wheel_axle_radius, 0]) {
          difference() {
            union() {
              cylinder(r = bearing_outer_diameter/2 + bearing_holder_width, h = bearing_width, center = true, $fn = 30);
              translate([0, -wheel_spoke_length/2, 0])
              cube([bearing_outer_diameter + bearing_holder_width*2, wheel_spoke_length, bearing_width], center=true);
            }
            cylinder(r = bearing_outer_diameter/2, h = bearing_width + 2*slop, center = true, $fn = 30);
          }
          // Preview the bearing and wheels. 
          // Note that the bearing previewed here does not scale with parameters.
          // If you want to see how a different bearing fits, replace this module call. 
          if(part=="preview")
          {
          %MR63ZZ_bearing();
          %mecanum_wheel_shape_3d();
          mirror([0, 0, 1])
          %mecanum_wheel_shape_3d();
          }
        }
        
      }
      // Main hub body.
      difference() {
        cylinder(r = hub_outer_radius, h = wheel_attachment_thickness, center = true, $fn = 50);
        cylinder(r = hub_outer_radius - hub_thickness, h = wheel_attachment_thickness + 2*slop, center = true, $fn = 50);
      }
      
      // Motor key
      if(motor_mount_type==1)
      {
        translate([0, 0, hub_motor_distance - wheel_attachment_thickness/2])
        difference() {
          cylinder(r = motor_attachment_radius, h = motor_shaft_length, $fn = 20);
          translate([0, 0, -slop]) intersection() {
            cylinder(r = motor_shaft_r, h = motor_shaft_length + 2*slop, $fn = 20);
            translate([-motor_shaft_r, -motor_shaft_r, 0]) cube([motor_shaft_r*2, motor_shaft_r*2 - motor_shaft_key_inset, motor_shaft_length + 2.5]);
          }
        }
      }
      
      if(hub_type==1)
      {
          // Hub spokes
          for(spoke_num = [1: num_spokes]) {
            rotate([0, 0, 80 + 360/num_spokes * (spoke_num-1)]) {
              translate([0, 0, -wheel_attachment_thickness/2])
              rotate([90, 0, 0])
              translate([0, 0, -hub_spoke_thickness/2])
              linear_extrude(height = hub_spoke_thickness)
              polygon([[motor_shaft_r + slop, hub_motor_distance],
                       [motor_shaft_r + slop, hub_motor_distance + motor_shaft_length],
                       [hub_outer_radius - hub_thickness + slop, wheel_attachment_thickness],
                       [hub_outer_radius - hub_thickness + slop, 0]]);
            }
          }
        } else if(hub_type==2)
        {
          translate([0,0,-wheel_attachment_thickness/2])
            linear_extrude(hub_spoke_thickness+hub_motor_distance,convexity=3) difference() {
              circle(r=hub_outer_radius,$fn=30);
              for(spoke_num=[1:num_spokes])
                rotate([0,0,spoke_num*(360/num_spokes)]) translate([hub_outer_radius/2+hub2_offset,0])
                  circle(d=hub2_diameter,$fn=30);
            }
        }
    }
    
    if(motor_mount_type==2)
    {
      translate([0,0,-wheel_attachment_thickness/2-slop]) cylinder(d=motor2_diameter,h=hub_spoke_thickness+hub_motor_distance+slop*2,$fn=30);
      translate([0,0,hub_motor_distance-wheel_attachment_thickness/2-motor2_hexh+2.5]) cylinder(d=motor2_hex,h=motor2_hexh+slop,$fn=6);
    }
    
    translate([0, 0, -wheel_attachment_thickness/2 - slop])
    cylinder(r = 2*wheel_axle_radius, h = hub_printing_trim);
  }

  // Report the slop as a sanity check for printing.   
  spoke_slope = atan((hub_outer_radius - hub_thickness - motor_shaft_r)/(hub_motor_distance));
  echo(str("Spoke overhang slope is: ", spoke_slope));
}

// Module to preview a small gearmotor.
// This is included as a demonstration for a particular motor size.
// It does not scale with other parameters. 
module motor_preview() {
  color([0.7, 0.7, 0.7, 0.7])
  %intersection() {
    cylinder(r = 1.5, h = 9, $fn = 10);
    translate([-1.5, -1.5, 0]) cube([3, 2.5, 9]);
  }

  color([0.7, 0.7, 0.2, 0.7])
  translate([-6, -5, -9.5]) %cube([12, 10, 9.5]);
    
  color([0.7, 0.7, 0.7, 0.7])
  translate([0, 0, -24.5])
  %intersection() {
    cylinder(r = 6, h = 15, $fn = 20);
    translate([-6, -5, 0]) cube([12, 10, 15]);
  }
}
module mirrorx(off=0)
{
  translate([off/2,0]) for(m=[0,1]) mirror([m,0]) translate([off/-2,0]) children();
}
module mirrory(off=0)
{
  translate([0,off/2,0]) for(m=[0,1]) mirror([0,m,0]) translate([0,off/-2,0]) children();
}
module mirrorz(off=0)
{
  translate([0,0,off/2]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,off/-2]) children();
}
module rsquare(dims,r=5,center=false,$fn=30)
{
  translate(center?[dims[0]/-2,dims[1]/-2]:[0,0])
  hull() for(x=[r,dims[0]-r],y=[r,dims[1]-r]) translate([x,y]) circle(r=r,$fn=$fn);
}
module rcube(dims,r=5,$fn=30)
{
  linear_extrude(dims[2],convexity=3) {
    for(x=[r,dims[0]-r],y=[r,dims[1]-r])
      translate([x,y]) circle(r=r,$fn=$fn);
    translate([0,r]) square([dims[0],dims[1]-r*2]);
    translate([r,0]) square([dims[0]-r*2,dims[1]]);
  }
}
module cube2(dims,r=5,$fn=30)
{
  minkowski() {
    translate([r,r,r]) cube([dims[0]-r*2,dims[1]-r*2,dims[2]-r*2]);
    sphere(r=r,$fn=$fn);
  }
}

function inches(in) = 25.4 * in;