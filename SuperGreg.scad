// Greg's Wade Extruder. 
// It is licensed under the Creative Commons - GNU GPL license. 
//  2010 by GregFrost
// Extruder based on prusa git repo.
// http://www.thingiverse.com/thing:6713

include<configuration.scad>
include<jonaskuehling-default.scad>

// Define the hotend_mounting style you want by specifying hotend_mount=style1+style2 etc.
$fn=50;
mount_hole_offset=[35/2];
bowden_hole=0;
screw_in_bowden = 0;

malcolm_hotend_mount=1;
groovemount=2;
peek_reprapsource_mount=4;
arcol_mount=8;
mendel_parts_v6_mount=16; 
grrf_peek_mount=32;
wildseyed_mount=64;
geared_extruder_nozzle=128; // http://reprap.org/wiki/Geared_extruder_nozzle
jhead_mount=256;
reprapfaborg_mount=512; // http://reprap-fab.org hotend with 10mm PEEK insulator

//Set the hotend_mount to the sum of the hotends that you want the extruder to support:
//e.g. wade(hotend_mount=groovemount+peek_reprapsource_mount);

//Set motor- and bolt-elevation for additional clearance when using e.g. 9/47 gears like in http://www.thingiverse.com/thing:11152
elevation=4;

//Set extra gear separation when using slightly bigger non-standard gears like 9/47 herringbone gears
extra_gear_separation=0.2945;

// Nut wrench sizes ISO 4032
m3_wrench = 5.5;
m4_wrench = 7;

// Adjust for deeper groove in hobbed bolt, so that idler is still vertical when tightened
// Values like 0.5 to 1 should work, the more, the closer the idler will move to the bolt
// Sometimes the idler will be slightly angled towards the bolt which causes the idler screws
// to slip off the slots in die idler to the top.. Adjusting this should help:
less_idler_bolt_dist = 0.5;





////////// RENDER EXTRUDER //////////////////////////////////////////////////////////////
wade(hotend_mount=groovemount, legacy_mount=false);
//wade(hotend_mount=reprapfaborg_mount, legacy_mount=false);
//wade(hotend_mount=jhead_mount, legacy_mount=false);
//wade(hotend_mount=arcol_mount, legacy_mount=false);
//wade(hotend_mount=grrf_peek_mount, legacy_mount=false);


////////// RENDER BEARING WASHER ///////////////////////////////////////////////////
*translate([-15,45,0])								// POSITIONING
	bearing_washer();


	*!translate(motor_mount_translation){
		translate([-gear_separation,0,0]){
      translate([-13-filament_feed_hole_offset/2-.6,0,9.5]) scale([1.1,1.1,1]) {
        translate([0,0,1.5]) b608(h=6);
        cylinder(d1=14,d2=hole_for_608,h=1.51,$fn=40);
        translate([0,0,7.49]) cylinder(d1=hole_for_608,d2=14,h=6,$fn=60);
      }
    }
  }

////////// RENDER IDLER /////////////////////////////////////////////////////////////////////
*translate([78+extra_gear_separation,-20,16.20-(1.5-filament_diameter/2)])	rotate([0,-90,0])
		wadeidler();






//===================================================
// Parameters defining the wade body:
wade_block_height=55+elevation;
wade_block_width=24;
wade_block_depth=28;
wade_reinforce_width=0;
wade_reinforce_height=23;

block_bevel_r=6;

base_thickness=7;
base_length=70;
base_leadout=25;

nema17_hole_spacing=1.2*25.4; 
nema17_width=1.7*25.4;
nema17_support_d=nema17_width-nema17_hole_spacing;

screw_head_recess_diameter=7.2;
screw_head_recess_depth=3;

motor_mount_rotation=25;
motor_mount_translation=[50.5+extra_gear_separation,34+elevation,0];
motor_mount_thickness=8;

bolt_shaft_diameter=25.4*(1/2);
m8_clearance_hole=bolt_shaft_diameter+.8;
hole_for_608=(25.4*1.125)+.6;
608_diameter=(25.4*1.125);

block_top_right=[wade_block_width,wade_block_height];

layer_thickness=0.3;
filament_feed_hole_d=2.25;
filament_diameter=1.75;
filament_feed_hole_offset=bolt_shaft_diameter/2;
idler_nut_trap_depth=7.3;
idler_nut_thickness=3.7;

gear_separation=7.4444+32.0111+0.25+extra_gear_separation;

echo(str("Gear Sep: ", gear_separation));

function motor_hole(hole)=[motor_mount_translation[0],motor_mount_translation[1]] +
	rotated(45+motor_mount_rotation+hole*90)*nema17_hole_spacing/sqrt(2);

// Parameters defining the idler.

filament_pinch=[
	motor_mount_translation[0]-gear_separation-filament_feed_hole_offset-filament_diameter/2,
	motor_mount_translation[1],
	wade_block_depth/2];
idler_axis=filament_pinch-[608_diameter/2,0,0];
idler_fulcrum_offset=608_diameter/2+3.5+m3_diameter/2;
idler_fulcrum=idler_axis-[0+less_idler_bolt_dist,idler_fulcrum_offset,0];
idler_corners_radius=4; 
idler_height=12;
idler_608_diameter=20;
idler_608_height=5;
idler_625_diameter=17.6;
idler_625_height=5.4;
idler_625_inset=2.2;
idler_625_shaft_diameter=5.4;
idler_shaft_diameter=14;
idler_mounting_hole_across=8;
idler_mounting_hole_up=15;
idler_short_side=wade_block_depth-2;
idler_hinge_r=m3_diameter/2+3.5;
idler_hinge_width=6.5;
idler_end_length=(idler_height-2)+5;
idler_mounting_hole_diameter=m4_diameter+0.25;
idler_mounting_hole_elongation=0.9;
idler_long_top=idler_mounting_hole_up+idler_mounting_hole_diameter/2+idler_mounting_hole_elongation+2.5;
idler_long_bottom=idler_fulcrum_offset;
idler_long_side=idler_long_top+idler_long_bottom;

module bearing_washer(){
	difference(){
		cylinder(r=hole_for_608/2-0.3,h=1);
		translate([0,0,-1])
		cylinder(r=8,h=3);
	}
}

module wade (hotend_mount=0,legacy_mount=false){
	difference (){
		union(){
			// The wade block.
			cube([wade_block_width,wade_block_height,wade_block_depth]);
      translate([-wade_reinforce_width,0]) cube([wade_reinforce_width,wade_reinforce_height,wade_block_depth]);

			// Filler between wade block and motor mount.
			translate([10,motor_mount_translation[1]-hole_for_608/2,0])
			cube([wade_block_width+extra_gear_separation,
				wade_block_height-motor_mount_translation[1]+hole_for_608/2,
				motor_mount_thickness]);

			// Connect block to top of motor mount.
			linear_extrude(height=motor_mount_thickness)
			barbell(block_top_right-[0,5],motor_hole(0),5,nema17_support_d/2,100,60);

			//Connect motor mount to base.
			linear_extrude(height=motor_mount_thickness)
			barbell([base_length-base_leadout,
				base_thickness/2],motor_hole(2),base_thickness/2,
				nema17_support_d/2,100,60);

			// Round the ends of the base
			translate([base_length-base_leadout,base_thickness/2,0])
			cylinder(r=base_thickness/2,h=wade_block_depth,$fn=20);

			translate([-base_leadout,base_thickness/2,0])
			cylinder(r=base_thickness/2,h=wade_block_depth,$fn=20);

			//Provide the bevel betweeen the base and the wade block.
			render()
			difference(){
				translate([-block_bevel_r,0,0])
				cube([block_bevel_r*2+wade_block_width,
					base_thickness+block_bevel_r,wade_block_depth]);				
				translate([-block_bevel_r,block_bevel_r+base_thickness])
				cylinder(r=block_bevel_r,h=wade_block_depth,$fn=60);
				translate([wade_block_width+block_bevel_r,
					block_bevel_r+base_thickness])
				cylinder(r=block_bevel_r,h=wade_block_depth,$fn=60);
			}

			// The idler hinge.
			translate(idler_fulcrum){
				translate([idler_hinge_r,0,0])
				*cube([idler_hinge_r*2,idler_hinge_r*2,idler_short_side-2*idler_hinge_width-0.5],
					center=true);
				rotate(-20){
					cylinder(r=idler_hinge_r,
						h=idler_short_side-2*idler_hinge_width-0.5,
						center=true,$fn=60);
					translate([idler_hinge_r+5,0,0])
					cube([idler_hinge_r*2+10,idler_hinge_r*2,
						idler_short_side-2*idler_hinge_width-0.5],
						center=true);
				}
			}

			// The idler hinge support.
			*translate(idler_fulcrum){
				rotate(-15)
				translate([-(idler_hinge_r+3)+1,-idler_hinge_r-2,-wade_block_depth/2])
				difference(){
					cube([idler_hinge_r+3,
						idler_hinge_r*2+4,
						wade_block_depth/2-
						idler_short_side/2+
						idler_hinge_width+0.25+
						layer_thickness]);
					translate([idler_hinge_r+2,(idler_hinge_r*2+4)/2,-layer_thickness])
					cylinder(r=idler_hinge_r+1,h=10,$fn=50);
				}
				rotate(-15)
				translate([-(idler_hinge_r+3)+1,-idler_hinge_r-2,
					-idler_short_side/2+idler_hinge_width+0.25])
				cube([idler_hinge_r+3+15,
					idler_hinge_r*2+4,
					layer_thickness]);
			}

			//The base.
			translate([-base_leadout,0,0])
			cube([base_length,base_thickness,wade_block_depth]);

			motor_mount ();
		}

		block_holes(legacy_mount=legacy_mount);
		motor_mount_holes ();

		translate([motor_mount_translation[0]-gear_separation-filament_feed_hole_offset,
			0,wade_block_depth/2])
		rotate([-90,0,0]){
			if (in_mask (hotend_mount,malcolm_hotend_mount))
				malcolm_hotend_holes ();
			if (in_mask (hotend_mount,groovemount))
				groovemount_holes ();
			if (in_mask (hotend_mount,peek_reprapsource_mount))
				peek_reprapsource_holes ();
			if (in_mask (hotend_mount,arcol_mount))
				arcol_mount_holes ();
			if (in_mask (hotend_mount,mendel_parts_v6_mount)) 
				mendel_parts_v6_holes(insulator_d=12.7);
			if (in_mask(hotend_mount,grrf_peek_mount))
				grrf_peek_mount_holes();
			if (in_mask(hotend_mount,wildseyed_mount))
				wildseyed_mount_holes(insulator_d=12.7);
			if (in_mask(hotend_mount,geared_extruder_nozzle))
				mendel_parts_v6_holes(insulator_d=15);
			if (in_mask(hotend_mount,jhead_mount))
				wildseyed_mount_holes(insulator_d=16);
			if (in_mask(hotend_mount,reprapfaborg_mount))
				peek_reprapfaborg_holes();
		}
	}
}

function in_mask(mask,value)=(mask%(value*2))>(value-1); 

//block_holes();

module block_holes(legacy_mount=false){
	//Round off the top of the block. 
	translate([0,wade_block_height-block_bevel_r,-1])
	render()
	difference(){
		translate([-1,0,0])
		cube([block_bevel_r+1,block_bevel_r+1,wade_block_depth+2]);
		translate([block_bevel_r,0,0])
		cylinder(r=block_bevel_r,h=wade_block_depth+2,$fn=40);
	}

	// Round the top front corner.
	translate ([-base_leadout-base_thickness/2,-1,wade_block_depth-block_bevel_r])
	render()
	difference(){
		translate([-1,0,0])
		cube([block_bevel_r+1,base_thickness+2,block_bevel_r+1]);
		rotate([-90,0,0])
		translate([block_bevel_r,0,-1])
		cylinder(r=block_bevel_r,h=base_thickness+4);
	}

	// Round the top back corner.
	translate ([base_length-base_leadout+base_thickness/2-block_bevel_r,
		-1,wade_block_depth-block_bevel_r])
	render()
	difference(){
		translate([0,0,0])
		cube([block_bevel_r+1,base_thickness+2,block_bevel_r+1]);
		rotate([-90,0,0])
		translate([0,0,-1])
		cylinder(r=block_bevel_r,h=base_thickness+4);
	}

	// Round the bottom front corner.
	translate ([-base_leadout-base_thickness/2,-1,-2])
	render()
	difference(){
		translate([-1,0,-1])
		cube([block_bevel_r+1,base_thickness+2,block_bevel_r+1]);
		rotate([-90,0,0])
		translate([block_bevel_r,-block_bevel_r,-1])
		cylinder(r=block_bevel_r,h=base_thickness+4);
	}

	// Idler fulcrum hole.
	translate(idler_fulcrum+[0,0,0.4])
	cylinder(r=m3_diameter/2,h=idler_short_side-2*idler_hinge_width-0.5,center=true,$fn=16);

	translate(idler_fulcrum+[0,0,idler_short_side/2-idler_hinge_width-1])
	cylinder(r=m3_nut_diameter/2+0.25,h=1,$fn=40);

	//Rounded cutout for idler hinge.
	//render()
	translate(idler_fulcrum)
	difference(){
		cylinder(r=idler_hinge_r+0.5,h=idler_short_side+0.5,center=true,$fn=60);
		cylinder(r=idler_hinge_r+1,h=idler_short_side-2*idler_hinge_width-0.5,center=true);
	}

	translate(motor_mount_translation){
		translate([-gear_separation,0,0]){
			*rotate([0,180,0])
			translate([0,0,1])
			import("wade-large.stl");

			// Open the top to remove overhangs and to provide access to the hobbing.
			translate([-wade_block_width,-1,9.5])
			cube([wade_block_width,
				wade_block_height-motor_mount_translation[1]+1,
				wade_block_depth]);

			// Open 30° slot for idler screws to avoid overhang at top corner
			translate([-wade_block_width,idler_mounting_hole_up-(idler_mounting_hole_diameter/2),wade_block_depth/2-idler_mounting_hole_across-((idler_mounting_hole_diameter*cos(180/6))/2)])
			cube([wade_block_width,
				wade_block_height-motor_mount_translation[1]+1,
				wade_block_depth]);
		
			translate([0,0,-1-idler_625_height])
			b608(h=9);
		
			translate([0,0,20+idler_625_height]) {
        b608();
        translate([0,0,7.98]) cylinder(d1=12,d2=8,h=3,$fn=40);
      }
		
			translate([-13-filament_feed_hole_offset/2-.6,0,9.5]) {
        translate([0,0,1.5]) cylinder(d=idler_608_diameter,h=6,$fn=60);
        cylinder(d1=14,d2=idler_608_diameter,h=1.51,$fn=40);
        translate([0,0,7.49]) cylinder(d1=idler_608_diameter,d2=14,h=6,$fn=60);
      }
		
      //translate([0,0,8-layer_thickness])
        #cylinder(d=bolt_shaft_diameter,h=wade_block_depth-layer_thickness+2);	
			cylinder(r=m8_clearance_hole/2,h=wade_block_depth+2);	
      
      translate([-16,0,-1]) cylinder(d=idler_625_diameter+2,h=wade_block_depth+2,$fn=40);

			*translate([0,0,20-2])
			cylinder(r=16/2,h=wade_block_depth-(8+layer_thickness)+2);	

			// Filament feed.
			translate([-filament_feed_hole_offset,0,wade_block_depth/2])
			rotate([90,0,0])
			rotate(360/16)
			cylinder(r=filament_feed_hole_d/2,h=wade_block_depth*3,center=true,$fn=8);	

			//Widened opening for hobbed bolt access.
			// EDIT jonaskuehling: removed for better stability around tilt screw nut traps
/*			translate([2,wade_block_height/2+2,wade_block_depth/2+0.2])
			rotate([90,0,0])
			rotate(-45)
			union(){
				cylinder(r=5,h=wade_block_height,center=true,$fn=30);	
				translate([-5,0,0])
				cube([10,10,wade_block_height],center=true);
			}
*/
			// Mounting holes on the base.
			translate(legacy_mount?[-3.4,0,-1]:[0,0,0])
			for (mount=[0:1],off=mount_hole_offset){
				translate([-filament_feed_hole_offset+off*((mount<1)?1:-1),
					-motor_mount_translation[1]-1,wade_block_depth/2])
				rotate([-90,0,0])
//				rotate(360/16)
				{
          cylinder(d=3.4,h=base_thickness+2,$fn=20);	
          //if(!mount)
          {
          translate([0,0,base_thickness+1.01]) difference() {
              hull()
              {
                translate([-4*(mount),0,16]) sphere(d=2,$fn=12);
                cylinder(d1=10,d2=2,h=6,$fn=12);
                mirror([mount,0])
                translate([20,0]) cylinder(d=30,h=10,$fn=40);
              }
              if(!mount) translate([8,0]) cube(20);
            }
          }
        }
	
        for(off=mount_hole_offset)
				translate([-filament_feed_hole_offset+off*((mount<1)?1:-1),
					-motor_mount_translation[1]+base_thickness/2,
					wade_block_depth/2])
				rotate([-90,30,0]){
//				cylinder(r=m4_nut_diameter/2,h=base_thickness,$fn=6);
				translate([0,0,base_thickness/2]) rotate([0,0,30]) nut_trap(m3_wrench,base_thickness,0);}
			}

		}
		*translate([0,0,-8])
		import_stl("wade-small.stl");
	}

	// Idler mounting holes and nut traps.
	for (idle=[-1,1]){
		translate([0,
			idler_mounting_hole_up+motor_mount_translation[1],
			wade_block_depth/2+idler_mounting_hole_across*idle])
		rotate([0,90,0]){
			rotate([0,0,30]){
				// screw holes
				translate([0,0,-1])
				cylinder(r=idler_mounting_hole_diameter/2,h=wade_block_depth+6,$fn=6);

				// nut traps
				translate([0,0,wade_block_width-idler_nut_trap_depth+idler_nut_thickness/2])
//				cylinder(r=m4_nut_diameter/2,h=idler_nut_thickness,$fn=6);	
				nut_trap(m4_wrench,idler_nut_thickness);
			}
			// nut slots
			translate([0,10/2,wade_block_width-idler_nut_trap_depth+idler_nut_thickness/2])
			cube([m4_wrench+0.4,10,idler_nut_thickness],center=true);

			// screw holes 30°
			for(tilt=[1:6]){
				translate([0,0,(wade_block_width-idler_nut_trap_depth+idler_nut_thickness/2)])
				rotate([tilt*5,0,0])
				rotate([0,0,30])
				translate([0,0,-28])
				cylinder(r=idler_mounting_hole_diameter/2,h=wade_block_depth+10,$fn=6);
			}

			// nut traps 30°
			translate([0,0,wade_block_width-idler_nut_trap_depth+idler_nut_thickness/2])
			for(tilt_nut=[1:6])
				rotate([tilt_nut*5,0,0])
				rotate([0,0,30])
//				cylinder(r=m4_nut_diameter/2,h=idler_nut_thickness,$fn=6);
				nut_trap(m4_wrench,idler_nut_thickness);
				
			

		}
	}
}

module motor_mount(){
	linear_extrude(height=motor_mount_thickness){
		barbell (motor_hole(0),motor_hole(1),nema17_support_d/2,
			nema17_support_d/2,20,160);
		barbell (motor_hole(1),motor_hole(2),nema17_support_d/2,
			nema17_support_d/2,20,160);
	}
}

module motor_mount_holes(){
	radius=4/2;
	slot_left=1;
	slot_right=2;

	{
		translate([0,0,screw_head_recess_depth+layer_thickness])
		for (hole=[0:2]){
			translate([motor_hole(hole)[0]-slot_left,motor_hole(hole)[1],0])
			cylinder(h=motor_mount_thickness-screw_head_recess_depth,r=radius,$fn=16);
			translate([motor_hole(hole)[0]+slot_right,motor_hole(hole)[1],0])
			cylinder(h=motor_mount_thickness-screw_head_recess_depth,r=radius,$fn=16);

			translate([motor_hole(hole)[0]-slot_left,motor_hole(hole)[1]-radius,0])
			cube([slot_left+slot_right,radius*2,motor_mount_thickness-screw_head_recess_depth]);
		}

		translate([0,0,-1])
		for (hole=[0:2]){
			translate([motor_hole(hole)[0]-slot_left,motor_hole(hole)[1],0])
			cylinder(h=screw_head_recess_depth+1,
				r=screw_head_recess_diameter/2,$fn=16);
			translate([motor_hole(hole)[0]+slot_right,motor_hole(hole)[1],0])
			cylinder(h=screw_head_recess_depth+1,
				r=screw_head_recess_diameter/2,$fn=16);

			translate([motor_hole(hole)[0]-slot_left,
				motor_hole(hole)[1]-screw_head_recess_diameter/2,0])
			cube([slot_left+slot_right,
				screw_head_recess_diameter,
				screw_head_recess_depth+1]);
		}
	}
}

module wadeidler(){

	guide_height=12.3;
	guide_length=10;

	difference(){
		union(){
			//The idler block.
			translate(idler_axis+[-idler_height/2+2,+idler_long_side/2-idler_long_bottom,0]){
				translate([.4,0]) cube([idler_height+.8,idler_long_side,idler_short_side],center=true);
	
				//Filament Guide.
				translate([guide_height/2+idler_height/2-1,idler_long_side/2-guide_length/2,0])
				cube([guide_height+1,guide_length,8],center=true);
        
        translate([-6,16,-5.625]) translate([4,0]) rotate([0,-90,0]) linear_extrude(4) hull() {
            for(x=[2,9.25],y=[2,11]) translate([x,y]) circle(r=2,$fn=20);
          }
        translate([-2,18.5,-5.625]) difference() {
          cube([4,4,11.25]);
          translate([4,4,-.01]) rotate([0,0]) cylinder(r=4,h=11.27,$fn=30);
        }
			}

			// The fulcrum Hinge
			translate(idler_fulcrum)
			rotate([0,0,-30]){
				cylinder(h=idler_short_side,r=idler_hinge_r,center=true,$fn=60);
				translate([-idler_end_length/2,0,0])
				cube([idler_end_length,idler_hinge_r*2,idler_short_side],center=true);
			}		
		}
	
		//Filament Path	
		translate(idler_axis+[2+guide_height,+idler_long_side-idler_long_bottom-guide_length/2,0]){
			cube([7,guide_length+2,3.5],center=true);
			translate([-7/2,0,0])
			rotate([90,0,0])
			cylinder(h=guide_length+4,r=3.5/2,center=true,$fn=16);
		}


		//Back of idler. Rueckseite glaetten
		translate(idler_axis+[-idler_height/2+2-idler_height,
			idler_long_side/2-idler_long_bottom-10,0])
		cube([idler_height,idler_long_side,idler_short_side+2],center=true);

		//Slot for idler fulcrum mount. Ausbruch Aufhaengung
		translate(idler_fulcrum){
			cylinder(h=idler_short_side-2*idler_hinge_width,
				r=idler_hinge_r+0.5,center=true,$fn=60);
			rotate(-30)
			translate([0,-idler_hinge_r-0.5,0])
			cube([idler_hinge_r*2+1,idler_hinge_r*2+1,
				idler_short_side-2*idler_hinge_width],center=true);

		}


		//Bearing cutout. Kugelleager Aufhaengung
		translate(idler_axis){
      *!idler_bearing();
			difference(){
        union() {
          cylinder(h=idler_608_height+2,d=idler_608_diameter,
					center=true,$fn=60);
          translate([0,idler_608_diameter/-2,idler_608_height/-2]) cube([idler_608_diameter,idler_608_diameter,idler_608_height]);
        }
				*for (i=[0,1])
				rotate([180*i,0,0])
				translate([0,0,6.9/2])
				cylinder(r1=12/2,r2=16/2,h=2);
			}
			translate([0,0,-.02]) cylinder(h=idler_short_side+.08,r=idler_shaft_diameter/2-0.25/*Tight*/,
				center=true,$fn=20);
      if(idler_625_diameter)
      {
        for(mz=[0,1]) mirror([0,0,mz]) translate([0,0,idler_short_side/2-idler_625_height-idler_625_inset+.01]) for(xs=[1]) scale([xs,1/xs,1]) cylinder(d=idler_625_diameter,h=idler_625_height);
      }
		}
    

		//Fulcrum hole. Gelenkloch
		translate(idler_fulcrum)
		rotate(360/12)
		cylinder(h=idler_short_side+2,r=m3_diameter/2-0.1,center=true,$fn=8);

		//Nut trap for fulcrum screw. Loch fuer Mutter
		*translate(idler_fulcrum+[0,0,idler_short_side/2-idler_hinge_width-1+1.5])
//		rotate(360/16)
//		cylinder(h=3,r=m3_nut_diameter/2,$fn=6);
//		rotate([0,0,30])
		nut_trap(m3_wrench,3);

		for(idler_screw_hole=[-1,1])
		translate(idler_axis+[2-idler_height,0,0]){
			//Screw Holes. Schraubenloecher
			translate([-1,idler_mounting_hole_up-1,
				idler_screw_hole*idler_mounting_hole_across])
			rotate([0,90,0]){
				cylinder(r=idler_mounting_hole_diameter/2,h=idler_height+2,$fn=16);
				translate([0,idler_mounting_hole_elongation+0.8,0])
				cylinder(r=idler_mounting_hole_diameter/2,h=idler_height+2,$fn=16);
				translate([-idler_mounting_hole_diameter/2,0,0])
				cube([idler_mounting_hole_diameter,idler_mounting_hole_elongation+7,
					idler_height+2]);
			}

			// Rounded corners.
			render()
			translate([idler_height/2,idler_long_top,
				idler_screw_hole*(idler_short_side/2)])
			difference(){
				translate([0,-idler_corners_radius/2+0.5,-idler_screw_hole*(idler_corners_radius/2-0.5)])
				cube([idler_height+2,idler_corners_radius+1,idler_corners_radius+1],
					center=true);
				rotate([0,90,0])
				translate([idler_screw_hole*idler_corners_radius,-idler_corners_radius,0])
				cylinder(h=idler_height+4,r=idler_corners_radius,center=true,$fn=40);
			}
		}
	}
}

module idler_bearing()
{
  ir=idler_625_shaft_diameter/2;
  redge=idler_608_diameter/2-ir;
  difference() {
    rotate_extrude($fn=100) {
      translate([ir,idler_608_height/-2]) difference() {
        square([redge,idler_608_height]);
        translate([redge+.3,idler_608_height/2]) scale([1,3]) rotate([0,0,45]) square(1,center=true);
      }
    }
    for(r=[0:360/floor(redge*7):359]) rotate([0,0,r]) translate([ir+redge,0]) rotate([90,0]) rotate_extrude($fn=30) {
      translate([.4,0]) circle(d=.8,$fn=10);
      translate([0,-.3]) square([.4,.6]);
    }
    *translate([0,0,idler_608_height/-2+1]) cylinder(d=9,h=4.1,$fn=6);
  }
  translate([0,0,idler_608_height/2]) difference() {
    cylinder(d1=14,d2=idler_625_shaft_diameter+2.2,h=3,$fn=100);
    translate([0,0,-.01]) cylinder(d=idler_625_shaft_diameter,h=3.02,$fn=100);
  }
}

module b608(h=8){
	translate([0,0,h/2]) cylinder(r=hole_for_608/2,h=h,center=true,$fn=60);
}

module barbell (x1,x2,r1,r2,r3,r4) {
	x3=triangulate (x1,x2,r1+r3,r2+r3);
	x4=triangulate (x2,x1,r2+r4,r1+r4);
	render()
	difference (){
		union(){
			translate(x1)
			circle (r=r1);
			translate(x2)
			circle(r=r2);
			polygon (points=[x1,x3,x2,x4]);
		}
		
		translate(x3)
		circle(r=r3,$fa=5);
		translate(x4)
		circle(r=r4,$fa=5);
	}
}

function triangulate (point1, point2, length1, length2) = 
point1 + 
length1*rotated(
atan2(point2[1]-point1[1],point2[0]-point1[0])+
angle(distance(point1,point2),length1,length2));

function distance(point1,point2)=
sqrt((point1[0]-point2[0])*(point1[0]-point2[0])+
(point1[1]-point2[1])*(point1[1]-point2[1]));

function angle(a,b,c) = acos((a*a+b*b-c*c)/(2*a*b)); 

function rotated(a)=[cos(a),sin(a),0];

//========================================================
// Modules for defining holes for hotend mounts:
// These assume the extruder is verical with the bottom filament exit hole at [0,0,0].

//malcolm_hotend_holes ();
module malcolm_hotend_holes (){
	extruder_recess_d=16; 
	extruder_recess_h=3.5;

	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1);	
}

//groovemount_holes ();
module groovemount_holes (){
	extruder_recess_d=16.4; 
	extruder_recess_h=5.5;

	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1);	
  
  if(screw_in_bowden)
    cylinder(d=12,h=extruder_recess_h+16);
  if(bowden_hole)
    cylinder(d=4.6,h=extruder_recess_h+50);
}

//peek_reprapsource_holes ();
module peek_reprapsource_holes (){
	extruder_recess_d=11;
	extruder_recess_h=19; 

	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1);	

	// Mounting holes to affix the extruder into the recess.
	translate([0,0,min(extruder_recess_h/2, base_thickness)])
	rotate([-90,0,0])
	cylinder(r=m4_diameter/2-0.5/* tight */,h=wade_block_depth+2,center=true); 
}

//arcol_mount_holes();
module arcol_mount_holes(){ 
	hole_axis_rotation=42.5; 
	hole_separation=30;
	hole_slot_height=4;
	for(mount=[-1,1])
		translate([hole_separation/2*mount,-7,0]) {
			translate([0,0,-1])
				cylinder(r=m4_diameter/2,h=base_thickness+2,$fn=8);
			
				translate([0,0,base_thickness/2])
				//rotate(hole_axis_rotation){
					cylinder(r=m4_nut_diameter/2,h=base_thickness/2+hole_slot_height,$fn=6);
				translate([0,-m4_nut_diameter,hole_slot_height/2+base_thickness/2]) 
					cube([m4_nut_diameter,m4_nut_diameter*2,hole_slot_height],center=true);
		}
}

//mendel_parts_v6_holes ();
module mendel_parts_v6_holes (insulator_d=12.7) {
	extruder_recess_d=insulator_d+0.7;
	extruder_recess_h=10; 
	hole_axis_rotation=42.5; 
	hole_separation=30;
	hole_slot_height=5;
	
	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1); 
	
	for(mount=[-1,1])
	rotate([0,0,hole_axis_rotation+90+90*mount])
	translate([hole_separation/2,0,0]){
		translate([0,0,-1])
		cylinder(r=m4_diameter/2,h=base_thickness+2,$fn=8);

		translate([0,0,base_thickness/2])
		rotate(-hole_axis_rotation+180){
//			rotate(30)
			cylinder(r=m4_nut_diameter/2,h=base_thickness/2+hole_slot_height,$fn=6);
			translate([0,-m4_nut_diameter,hole_slot_height/2+base_thickness/2]) 
			cube([m4_nut_diameter,m4_nut_diameter*2,hole_slot_height],
					center=true);
		}
	}
}

//grrf_peek_mount_holes();
module grrf_peek_mount_holes(){  
	extruder_recess_d=16.5;
	extruder_recess_h=10;

	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1);
	
	for (hole=[-1,1]){
		rotate(90,[1,0,0])
			translate([hole*(extruder_recess_d/2-1.5),3+1.5,-wade_block_depth/2-1]){
				translate([0,0,3.25+layer_thickness])
					cylinder(r=1.5,h=wade_block_depth+2,$fn=10);
				translate([0,0,1.75])
					nut_trap(m3_wrench, 3);
			}
	}
}

//wildseyed_mount_holes(insulator_d=16);
module wildseyed_mount_holes(insulator_d=12.7){  
	extruder_recess_d=insulator_d+0.7;
	extruder_recess_h=10;

	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1);
	
	for (hole=[-1,1])
	rotate(90,[1,0,0])
	translate([hole*(extruder_recess_d/2-1.5),3+1.5,-wade_block_depth/2-1])
	cylinder(r=1.5,h=wade_block_depth+2,$fn=10);
}

//PEEK mount holes for reprap-fab.org 10mm dia insulator
module peek_reprapfaborg_holes(){
	extruder_recess_d=10.8;
	extruder_recess_h=20; 

	// Recess in base
	translate([0,0,-1])
	cylinder(r=extruder_recess_d/2,h=extruder_recess_h+1);	

	// Mounting holes to affix the extruder into the recess.
	translate([5,0,min(extruder_recess_h/2, base_thickness-2)])
	rotate([-90,0,0]){
//	cylinder(r=m3_diameter/2-0.5,/*tight*/,h=wade_block_depth+2,center=true);
	polyhole(2.5,wade_block_depth+2);}
	translate([-5,0,min(extruder_recess_h/2, base_thickness-2)])
	rotate([-90,0,0]){
//	cylinder(r=m3_diameter/2-0.5,/*tight*/,h=wade_block_depth+2,center=true);
	polyhole(2.5,wade_block_depth+2);}

	//cylinder(r=m4_diameter/2-0.5/* tight */,h=wade_block_depth+2,center=true); 
}