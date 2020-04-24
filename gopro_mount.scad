translate([-7.3,10.9,-7.36]) cube([54.6,20,14.7]);
mirror([1,0,0])
rotate([0,90,0]) {
gopro_connector("triple", withnut=true);
translate([0,40,-40]) mirror([0,1,0])
  gopro_connector("double");
}
/* [Main] */

// First head kind ("example" show them all but is not printable)
gopro_primary="triple"; // [example,triple,double]
// The other head kind (only for the triple or double primary kind)
gopro_secondary_what="double"; // [double,triple,rod,clamp,none]
// If ever you rotate the seconday head you will probably need to enable support to print it
gopro_secondary_rotated=0; // [0:false,1:true]

// Optional axis-to-axis extension rod (hence, it cannot be less than 20.7)
gopro_ext_len=50;
// The wall thickness of the extension rod (2 to 6mm are good values)
gopro_ext_th=3;

/* [Rod and captive nut] */

// This tab is useful only if you have selected "rod" as the secondary head. The optional rod diameter (also the captive nut internal diameter)
gopro_captive_rod_id= 3.8;
// The angle the rod makes with the axis (0 is colinear, 90 is a right angle)
gopro_captive_rod_angle= 45; // [0:90]
// Optional captive nut thickness with freeplay (tightest would be 3.2)
gopro_rod_nut_th= 3.6;
// Optional captive nut diameter with freeplay (from corner to corner)
gopro_rod_nut_od= 8.05;
// How much is the protruding output of the rod on the rod attachment (can be zero), useful if you don't want a captive nut with still a tight coupling
gopro_captive_protruding_h= 0.5;

/* [Clamp/bar mount] */

// This tab is useful only if you have selected "clamp" as the secondary head.  The optional (handle)bar diameter
gopro_bar_rod_d= 31;
// How thick is the ring around the bar
gopro_bar_th= 3.2;
// How big is the gap between the jaws
gopro_bar_gap= 2.4;
// The jaw screw diameter
gopro_bar_screw_d= 3;
// The diameter of the head of the screw
gopro_bar_screw_head_d= 6.2;
// The diameter of the nut of the screw from corner to corner (can be zero)
gopro_bar_screw_nut_d= 6.01;
// How thick are the shoulders on which to bolt (each side)
gopro_bar_screw_shoulder_th=4.5;
// Whether to reverse the bolt orientation (from which side you will screw the bolt, defaut is from the joint)
gopro_bar_screw_reversed=false; // [true,false]

/* [Hidden] */

// The gopro connector itself (you most probably do not want to change this but for the first two)

// The locking nut on the gopro mount triple arm mount (keep it tight)
gopro_nut_d= 9.2;
// How deep is this nut embossing (keep it small to avoid over-overhangs)
gopro_nut_h= 2;
// Hole diameter for the two-arm mount part
gopro_holed_two= 5;
// Hole diameter for the three-arm mount part
gopro_holed_three= 5.5;
// Thickness of the internal arm in the 3-arm mount part
gopro_connector_th3_middle= 3.1;
// Thickness of the side arms in the 3-arm mount part
gopro_connector_th3_side= 2.7;
// Thickness of the arms in the 2-arm mount part
gopro_connector_th2= 3.04;
// The gap in the 3-arm mount part for the two-arm
gopro_connector_gap= 3.1;
// How round are the 2 and 3-arm parts
gopro_connector_roundness= 1;
// How thick are the mount walls
gopro_wall_th= 3;

gopro_connector_wall_tol=0.5+0;
gopro_tol=0.04+0;

// Can be queried from the outside
gopro_connector_z= 2*gopro_connector_th3_side+gopro_connector_th3_middle+2*gopro_connector_gap;
gopro_connector_x= gopro_connector_z;
gopro_connector_y= gopro_connector_z/2+gopro_wall_th;

///////////////////////////////////////////////////////////////////////
//
// GoPro Hero mount and joint (gopro_mounts_mooncactus.scad) - Rev 1.03
//
///////////////////////////////////////////////////////////////////////
//
// CC-BY-NC 2013 jeremie.francois@gmail.com
// http://www.thingiverse.com/thing:62800
// http://betterprinter.blogspot.com
//

// It slices neatly on an ultimaker with the following parameters
//
// 0.1 mm layers (for better look & more compact FDM) -- 0.15 is still OK (and faster)
// 0.8 mm walls (loops->infill->perimeters)
// 0.8 mm bottom/top
// 100% fill (probably safer, though 30% is quite OK)
//
// Rev 1.01: fixed printing angle vs captive nut slot, added a slight freeplay
// Rev 1.02: added handle/bar mount and rounded the angles of the rod mount
// Rec 1.03: examples and first release (20130317-1234)




//
// ============================= GOPRO CONNECTOR =============================
//

module gopro_torus(r,rnd)
{
	translate([0,0,rnd/2])
		rotate_extrude(convexity= 10)
			translate([r-rnd/2, 0, 0])
				circle(r= rnd/2, $fs=0.2);
}

module gopro_rcyl(r,h, centered, rnd=1)
{
	translate([0,0,center ? -h/2 : 0])
	hull() {
		translate([0,0,0]) gopro_torus(r=r, rnd=rnd);
		translate([0,0,h-rnd]) gopro_torus(r=r, rnd=rnd);
	}
}

module gopro_connector(version="double", withnut=true, captive_nut_th=0, captive_nut_od=0, captive_rod_id=0, captive_nut_angle=0)
{
	module gopro_profile(th)
	{
		hull()
		{
			gopro_torus(r=gopro_connector_z/2, rnd=gopro_connector_roundness);
			translate([0,0,th-gopro_connector_roundness])
				gopro_torus(r=gopro_connector_z/2, rnd=gopro_connector_roundness);
			translate([-gopro_connector_z/2,gopro_connector_z/2,0])
				cube([gopro_connector_z,gopro_wall_th,th]);
		}
	}
	difference()
	{
		union()
		{
			if(version=="double")
			{
				for(mz=[-1:2:+1]) scale([1,1,mz])
						translate([0,0,gopro_connector_th3_middle/2 + (gopro_connector_gap-gopro_connector_th2)/2]) gopro_profile(gopro_connector_th2);
			}
			if(version=="triple")
			{
				translate([0,0,-gopro_connector_th3_middle/2]) gopro_profile(gopro_connector_th3_middle);
				for(mz=[-1:2:+1]) scale([1,1,mz])
					translate([0,0,gopro_connector_th3_middle/2 + gopro_connector_gap]) gopro_profile(gopro_connector_th3_side);
			}

			// add the common wall
			translate([0,gopro_connector_z/2+gopro_wall_th/2+gopro_connector_wall_tol,0])
				cube([gopro_connector_z,gopro_wall_th,gopro_connector_z], center=true);

			// add the optional nut emboss
			if(version=="triple" && withnut)
			{
				translate([0,0,gopro_connector_z/2-gopro_tol])
				difference()
				{
					cylinder(r1=gopro_connector_z/2-gopro_connector_roundness/2, r2=11.5/2, h=gopro_nut_h+gopro_tol);
					cylinder(r=gopro_nut_d/2, h=gopro_connector_z/2+3.5+gopro_tol, $fn=6);
				}
			}
		}
		// remove the axis
		translate([0,0,-gopro_tol])
			cylinder(r=(version=="double" ? gopro_holed_two : gopro_holed_three)/2, h=gopro_connector_z+4*gopro_tol, center=true, $fs=1);
	}
}

//
// ============================= CAPTIVE NUT/ROD =============================
//

module gopro_rod_connect(nut_od, rod_id, nut_th, angle=0)
{
	if( (nut_th>0 && nut_od>0) || rod_id>0 )
	translate([0,gopro_connector_z,0])
	{
		difference()
		{
			// Main body mass
			difference()
			{
				hull()
				{
					translate([0,-gopro_connector_z/2+gopro_wall_th,0]) // attachment
						cube([gopro_connector_z,gopro_tol,gopro_connector_z], center=true);

					// main cylinder
					translate([gopro_connector_z/8,gopro_connector_z/4,0]) scale([0.75,0.5,1]) // optional
					gopro_rcyl(r=gopro_connector_z/2, h=gopro_connector_z, center=true, rnd=3);

					// nozzle
					rotate([0,0,angle])
						translate([0,gopro_connector_z/2-gopro_tol,0])
							rotate([-90,0,0])
							{
								hull()
								{
									translate([0,0,-1.5]) gopro_torus(r=gopro_connector_z/2, rnd=1.5);
									translate([0,0,gopro_captive_protruding_h-1])
									gopro_torus(r=nut_od/2, rnd=1);
								}
							}
				}

				// Captive nut slot
				if(nut_th>0 && nut_od>0)
				{
					translate([0,0,0])
						rotate([0,(angle<18)?180:0,angle]) // easier print only for small angles
							hull()
					{
						rotate([-90,0,0]) cylinder(r=nut_od/2, h=nut_th+2*gopro_tol, $fn=6, center=true);
						translate([gopro_connector_z,0,0])
							rotate([-90,0,0]) cylinder(r=nut_od/2, h=nut_th+2*gopro_tol, $fn=6, center=true);
					}
				}
			}

			// Carve the rod void
			if(rod_id>0)
			{
				rotate([0,0,angle])
				{
					if(angle>=80 || angle<=-80)
						rotate([-90,30,0])
							cylinder(r=rod_id/2, h=gopro_connector_z+2*gopro_captive_protruding_h+2*gopro_tol, $fs=0.2, center=true);
					else
						translate([0,gopro_wall_th+gopro_tol*2-nut_th/2,0])
							rotate([-90,30,0])
							cylinder(r=rod_id/2, h=gopro_connector_z/2+gopro_captive_protruding_h+gopro_tol, $fs=0.2);
				}
			}
		}
	}
}

//
// ============================= BAR CLAMP =============================
//

module gopro_bar_clamp(
	rod_d= 31,
	th= 3.2,
	gap= 2.4,
	screw_d= 3,
	screw_head_d= 6.2,
	screw_nut_d= 6.01,
	screw_shoulder_th=4.5,
	screw_reversed=1
	)
{
	module clamp_profile(r)
	{
		scale([r,r,1])
			translate([0,rod_d/2,0])
				cylinder(r=rod_d/2 + th,h=gopro_tol);
	}
	
	screw_x= rod_d/2+screw_head_d/2;
	translate([0,gopro_connector_z,0])
	difference()
	{
		hull()
		{
			translate([0,-gopro_connector_z/2+gopro_wall_th,0]) // attachment
				cube([gopro_connector_z,gopro_tol,gopro_connector_z], center=true);

			clamp_profile(1);
			for(m=[-1:2:+1]) scale([1,1,m])
				translate([0,0,-gopro_connector_z/2])
					clamp_profile((rod_d-0.8)/rod_d);

			// Shoulder screw support
			for(m=[-1:2:+1]) scale([m,1,1])
			{
				translate([screw_x,rod_d/2,gopro_tol/2])
					rotate([90,0,0])
						translate([0,0,-(gap+th*2)/2])
							cylinder(r=screw_head_d/2+0.78,h=gap+th*2);
			}
			
		}

		translate([0,rod_d/2,0])
		{
			// Main hole and gap
			translate([0,0,-gopro_tol-gopro_connector_z/2])
				cylinder(r=rod_d/2,h=gopro_connector_z+2*gopro_tol, $fs=1); // inner
				
			// Gap
			cube([screw_x*2 + screw_head_d*2, gap, gopro_connector_z+2*gopro_tol+1],center=true);

			// Screws
			for(mx=[-1:2:+1]) scale([mx,1,1])
			{
				translate([screw_x,0,0]) rotate([90,0,0])
				{
						translate([0,0,-rod_d/2-screw_shoulder_th]) cylinder(r=screw_d/2,h=rod_d+2*screw_shoulder_th,$fs=0.5); // screw axis
						if(screw_head_d>0)
							scale([1,1,screw_reversed?-1:1])
								translate([0,0,gap/2+screw_shoulder_th])
									cylinder(
										r1=screw_head_d/2,
										r2=1.5*screw_head_d/2,
										h=rod_d/2,$fs=0.5); // screw head
						if(screw_nut_d>0)
							scale([1,1,screw_reversed?1:-1])
								translate([0,0,gap/2+screw_shoulder_th])
									rotate([0,0,30])
										cylinder(
											r1=screw_nut_d/2,
											r2=1.5*screw_nut_d/2,
											h=rod_d/2,$fn=6); // screw nut
				}
			}

		}
	}
}


module gopro_extended(len, th=3)
{
	linlen= len - 2*gopro_connector_y;
	if(linlen>0)
	{
		translate([-.71*gopro_connector_y,gopro_connector_y*1,-.705*gopro_connector_y])
		{
			rotate([90,0,0])
				translate([0,0,-linlen/2])
					linear_extrude(height = linlen, center = true, convexity = 10)
			{
        square(linlen/2);
			}
		}
	}
}

