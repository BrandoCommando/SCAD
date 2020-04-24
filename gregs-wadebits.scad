// Greg's Wade Gears.
// It is licensed under the Creative Commons - GNU GPL license. 
// � 2010 by GregFrost
// Parametric extruder gears based on prusa git repo.
// http://www.thingiverse.com/thing:6713

$fn=50;
//include <configuration.scad>
m8_nut_diameter=25.4*(3/4)/cos(30);
use </Users/brandon/Downloads/3dPrints/parametric_involute_gear_v5.0.scad>

translate([55,40,0]) difference() {
   *gear (number_of_teeth=45,
			circular_pitch=268,
			gear_thickness =inches(1/4),
			rim_thickness = inches(1/4),
			rim_width = 3,
			hub_thickness = inches(1/2),
			hub_diameter = inches(1.5),
			bore_diameter = inches(1/2),
			circles=5);

  WadesL(number_of_teeth=45,bore_diameter=25.4*(1/2),gear_thickness=inches(1/4),hub_diameter=inches(1.5),hole_size=4,hole_offset=24,num_holes=8,nut_trap_depth=4,m8_nut_diameter=0); //this module call will make the large gear
  translate([0,0,inches(1/4)-4.15]) cylinder(d=inches(3/4)/cos(30),h=8.3,$fn=6);
  
  for(r=[30:60:360]) rotate([0,0,r]) translate([14,0,-.01]) {
    cylinder(d=3,h=20.02,$fn=20);
  }
}
translate([15,60,0]) WadesS(); //this module call will make the small gear

module WadesL(
number_of_teeth=43,
	num_holes=7,
	hole_size=6,
	hole_offset=18.5,
	gear_thickness=5,
	nut_trap_depth=3,
	nut_trap_thickness=6,
hub_diameter=22,
  bore_diameter=8,
m8_nut_diameter=m8_nut_diameter)
{

	difference(){
		gear (number_of_teeth=number_of_teeth,
			circular_pitch=268,
			gear_thickness =gear_thickness,
			rim_thickness = 7,
			rim_width = 3,
			hub_thickness = nut_trap_thickness+nut_trap_depth,
			hub_diameter = hub_diameter,
			bore_diameter = bore_diameter,
			circles=0);

		*translate([0,0,nut_trap_thickness])
		rotate(30)
		cylinder($fn=6,r=m8_nut_diameter/2-0.5,h=nut_trap_depth+1);


color([0,0,1])
		for (hole=[0:num_holes-1])
		{
			rotate([0,0,360/num_holes*hole])
			translate([hole_offset,0,0])
			rotate(10)
			translate([0,0,-1])
			{
				cylinder(r=hole_size,h=gear_thickness+2);
				*cube([hole_size,hole_size,gear_thickness+2]);
			}
		}
	}
}

module WadesS(){
	mirror([0,0,1]) difference(){
    union(){
		rotate([0,0,360/18]) gear (number_of_teeth=9,
			circular_pitch=268,
			gear_thickness = 18,
			rim_thickness = 20,
			hub_thickness = 20,
			hub_diameter = 18,
			bore_diameter = 5.25,
			circles=0);
    
    translate([2,-2,9]) cube([2,4,11]);
    }
    *rotate([0,0,90]) {
		*translate([0,-5,17])cube([6.2,3,9],center = true);
		translate([0,0,14])rotate([0,90,-90])rotate(30)cylinder(r=1.7,h=20);
		*translate([0,-5,14])rotate([0,90,-90])cylinder(r=6.2/2/cos(30),h=3,$fn=6,center=true);
    }
	}
}


function inches(in) = 25.4*in;