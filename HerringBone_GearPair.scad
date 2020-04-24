// Play between tooth flanks
play = 0.05;
// Height of the tooth tip over the cone; Specification for the outside of the cone
tooth_height = 1;
// Number of wheel teeth on the wheel
number_of_teeth_wheel = 28;
// Number of wheel teeth on the pinion
number_of_teeth_pinion = 28;
// Angle between the axles of wheel and pinion
axis_angle = 90;
// Width of the teeth from the outside toward the apex of the cone, default value = 90 degrees
tooth_width = 5;
// Diameter of the center hole of the wheel
d_bore_wheel = 5;
// Diameter of the center hole of the pinion
d_bore_pinion = 5;
// Pressure angle, standard value = 20 degrees according to DIN 867
pressure_angle = 20;
// Bend angle, default = 0 degrees
helix_angle=30;
// Assembled or separated for printing
assembled = 1;

/* Library for involute gears

Author: Dr Joerg Janssen
As of: June 15, 2016
Version: 1.3
License: GNU non-commercial license

Rough translation to English using Google Translate
Cameron Lamont
20 October 2019

Permitted modules according to DIN 780:
0.05 0.06 0.08 0.10 0.12 0.16
0.20 0.25 0.3  0.4  0.5  0.6
0.7  0.8  0.9  1    1.25 1.5
2    2.5  3    4    5    6
8    10   12   16   20   25
32   40   50   60
*/


/* [Hidden] */
pi = 3.14159;
rad = 57.29578;
$fn = 96;

*bevel_gear_pair(tooth_height, number_of_teeth_wheel, number_of_teeth_pinion, axis_angle, tooth_width, d_bore_wheel, d_bore_pinion, pressure_angle, helix_angle, assembled);
for(i=[0:2:22])
  translate([0,50*i])
  bevel_gear_pair(tooth_height, 16+2*i, 17+2*i, axis_angle, tooth_width, d_bore_wheel, d_bore_pinion, pressure_angle, helix_angle, 0);

/* Ball Gradient function
    Returns the polar coordinates of a globe grad
    theta0 = angle of the cone at the cutting edge of the big ball rolls the involute
    theta = angle to the cone axis for which the azimuth angle of the involute is to be calculated */
function kugelev(theta0,theta) = 1/sin(theta0)*acos(cos(theta)/cos(theta0))-acos(tan(theta0)/tan(theta));


/* Converts spherical coordinates to Cartesian
    Format: radius, theta, phi; theta = angle to z-axis, phi = angle to x-axis on xy-plane */
function sphereical_to_cartesian(vect) = [
	vect[0]*sin(vect[1])*cos(vect[2]),  
	vect[0]*sin(vect[1])*sin(vect[2]),
	vect[0]*cos(vect[1])
];

/* Check if a number is even
	= 1, if yes
	= 0 if the number is odd */
function is_even(number) =
	(number == floor(number/2)*2) ? 1 : 0;
	
/* Bevel gear
    tooth_height = height of the tooth tip over the cone; Specification for the outside of the cone
    number_of_teeth = number of wheel teeth
    partial_cone_angle = (half) angle of the cone on which the other ring gear rolls
    tooth_width = width of the teeth from the outside in the direction of the apex of the cone
	d_bore = diameter of the center hole
    pressure_angle = angle of attack, standard value = 20 degrees according to DIN 867
	helix_angle = angle of inclination, standard value = 0 degrees */
module bevel_gear(tooth_height, number_of_teeth, partial_cone_angle, tooth_width, d_bore, pressure_angle = 20, helix_angle=0) {

	// Dimensions calculations
	d_outside = tooth_height * number_of_teeth;									// Part cone diameter on the Kegelgrundflaeche,
																	// corresponds to the chord in a spherical section
	r_outside = d_outside / 2;										// Part cone radius on the Kegelgrundflaeche
	rg_outside = r_outside/sin(partial_cone_angle);						// Large bevel radius for tooth outside, corresponds to the length of the cone flank;
	rg_inside = rg_outside - tooth_width;								// Big bevel radius for tooth inside
	r_inside = r_outside*rg_inside/rg_outside;
	alpha_stirn = atan(tan(pressure_angle)/cos(helix_angle));// Elbow angle in the frontal section
	delta_b = asin(cos(alpha_stirn)*sin(partial_cone_angle));			// Basic cone angle		
	da_outside = (tooth_height <1)? d_outside + (tooth_height * 2.2) * cos(partial_cone_angle): d_outside + tooth_height * 2 * cos(partial_cone_angle);
	ra_outside = da_outside / 2;
	delta_a = asin(ra_outside/rg_outside);
	c = tooth_height / 6;													// Kopfspiel "head game"
	df_outside = d_outside - (tooth_height +c) * 2 * cos(partial_cone_angle);
	rf_outside = df_outside / 2;
	delta_f = asin(rf_outside/rg_outside);
	rkf = rg_outside*sin(delta_f);									// Radius of the cone foot
	height_f = rg_outside*cos(delta_f);								// Height of the cone from the foot cone
	
	echo("Part cone diameter on the Kegelgrundflaeche = ", d_outside);
	
	// Large complementary truncated cone
	height_k = (rg_outside-tooth_width)/cos(partial_cone_angle);			// Height of the complement cone for correct tooth length
	rk = (rg_outside-tooth_width)/sin(partial_cone_angle);				// Foot radius of the Komplementaerkegels
	rfk = rk*height_k*tan(delta_f)/(rk+height_k*tan(delta_f));		// Head radius of the cylinder for
																	// Complementary truncated cone
	height_fk = rk*height_k/(height_k*tan(delta_f)+rk);				// Height of the komplementaer truncated cone

	echo("Bevel Gear Height = ", height_f-height_fk);
	
	phi_r = kugelev(delta_b, partial_cone_angle);						// Angle to the point of the involute on partial cone
		
	// Torsion angle gamma from the angle of inclination
	gamma_g = 2*atan(tooth_width*tan(helix_angle)/(2*rg_outside-tooth_width));
	gamma = 2*asin(rg_outside/r_outside*sin(gamma_g/2));
	
	schritt = (delta_a - delta_b)/16;
	tau = 360/number_of_teeth;												// pitch angle
	start = (delta_b > delta_f) ? delta_b : delta_f;
	mirror_point = (180*(1-play))/number_of_teeth+2*phi_r;

	// drawing
	rotate([0,0,phi_r+90*(1-play)/number_of_teeth]){						// Center tooth on x-axis;
																	// makes alignment with other wheels easier
		translate([0,0,height_f]) rotate(a=[0,180,0]){
			union(){
				translate([0,0,height_f]) rotate(a=[0,180,0]){								// Cone stumpf (Truncated Cone)							
					difference(){
						linear_extrude(height=height_f-height_fk, scale=rfk/rkf) circle(rkf*1.001); // 1 thousanth of a mm overlap with tooth base
						translate([0,0,-1]){
							cylinder(h = height_f-height_fk+2, r = d_bore/2);				// Centre Bore
						}
					}	
				}
				for (rot = [0:tau:360]){
					rotate (rot) {															// Copy and rotate "number of teeth"
						union(){
							if (delta_b > delta_f){
								// tooth root
								flank_point_below = 1*mirror_point;
								flank_point_above = kugelev(delta_f, start);
								polyhedron(
									points = [
										sphereical_to_cartesian([rg_outside, start*1.001, flank_point_below]),	// 1 thousandth of a mm overlap with tooth
										sphereical_to_cartesian([rg_inside, start*1.001, flank_point_below+gamma]),
										sphereical_to_cartesian([rg_inside, start*1.001, mirror_point-flank_point_below+gamma]),
										sphereical_to_cartesian([rg_outside, start*1.001, mirror_point-flank_point_below]),								
										sphereical_to_cartesian([rg_outside, delta_f, flank_point_below]),
										sphereical_to_cartesian([rg_inside, delta_f, flank_point_below+gamma]),
										sphereical_to_cartesian([rg_inside, delta_f, mirror_point-flank_point_below+gamma]),
										sphereical_to_cartesian([rg_outside, delta_f, mirror_point-flank_point_below])								
									],
									faces = [[0,1,2],[0,2,3],[0,4,1],[1,4,5],[1,5,2],[2,5,6],[2,6,3],[3,6,7],[0,3,7],[0,7,4],[4,6,5],[4,7,6]],
									convexity =1
								);
							}
							// Teeth
							for (delta = [start:schritt:delta_a-schritt]){
								flank_point_below = kugelev(delta_b, delta);
								flank_point_above = kugelev(delta_b, delta+schritt);
								polyhedron(
									points = [
										sphereical_to_cartesian([rg_outside, delta, flank_point_below]),
										sphereical_to_cartesian([rg_inside, delta, flank_point_below+gamma]),
										sphereical_to_cartesian([rg_inside, delta, mirror_point-flank_point_below+gamma]),
										sphereical_to_cartesian([rg_outside, delta, mirror_point-flank_point_below]),								
										sphereical_to_cartesian([rg_outside, delta+schritt, flank_point_above]),
										sphereical_to_cartesian([rg_inside, delta+schritt, flank_point_above+gamma]),
										sphereical_to_cartesian([rg_inside, delta+schritt, mirror_point-flank_point_above+gamma]),
										sphereical_to_cartesian([rg_outside, delta+schritt, mirror_point-flank_point_above])									
									],
									faces = [[0,1,2],[0,2,3],[0,4,1],[1,4,5],[1,5,2],[2,5,6],[2,6,3],[3,6,7],[0,3,7],[0,7,4],[4,6,5],[4,7,6]],
									convexity =1
								);
							}
						}
					}
				}	
			}
		}
	}
}

/* Arrow bevel gear; uses the module "bevel_gear"
    tooth_height = Height of the tooth head over the pitch circle
    number_of_teeth = number of wheel teeth
    height = Height of the gear
    d_bore = Diameter of the center hole
    pressure_angle = Pressure angle, standard value = 20 degrees according to DIN 867
    helix_angle = Bend angle, default = 0 degrees */
module arrow_bevel_gear(tooth_height, number_of_teeth, partial_cone_angle, tooth_width, d_bore, pressure_angle = 20, helix_angle=0){

	// Dimensions calculations
	
	tooth_width = tooth_width / 2;
	
	d_outside = tooth_height * number_of_teeth;								// Part cone diameter on the Kegelgrundflaeche,
																// corresponds to the chord in a spherical section
	r_outside = d_outside / 2;									// Part cone radius on the Kegelgrundflaeche
	rg_outside = r_outside/sin(partial_cone_angle);					// Big cone radius, corresponds to the length of the cone flank;
	c = tooth_height / 6;												// Kopfspiel (head game)
	df_outside = d_outside - (tooth_height +c) * 2 * cos(partial_cone_angle);
	rf_outside = df_outside / 2;
	delta_f = asin(rf_outside/rg_outside);
	height_f = rg_outside*cos(delta_f);							// Height of the cone from the foot cone

	// Torsion angle gamma from the angle of inclination
	gamma_g = 2*atan(tooth_width*tan(helix_angle)/(2*rg_outside-tooth_width));
	gamma = 2*asin(rg_outside/r_outside*sin(gamma_g/2));
	
	echo("Part cone diameter on the Kegelgrundflaeche = ", d_outside);
	
	// Groessen fuer Komplementaer-Kegelstumpf
	height_k = (rg_outside-tooth_width)/cos(partial_cone_angle);		// Height of the complement cone for correct tooth length
	rk = (rg_outside-tooth_width)/sin(partial_cone_angle);			// Foot radius of the Komplementaerkegels
	rfk = rk*height_k*tan(delta_f)/(rk+height_k*tan(delta_f));	// Head radius of the cylinder for
																// Complementary truncated cone
	height_fk = rk*height_k/(height_k*tan(delta_f)+rk);			// Height of the komplementaer truncated cone
	
	tooth_height_inside = tooth_height*(1-tooth_width/rg_outside);

		union(){
		bevel_gear(tooth_height, number_of_teeth, partial_cone_angle, tooth_width, d_bore, pressure_angle, helix_angle);		// bottom half
		translate([0,0,height_f-height_fk])
			rotate(a=-gamma,v=[0,0,1])
      {
        difference() {
				bevel_gear(tooth_height_inside, number_of_teeth, partial_cone_angle, tooth_width, d_bore, pressure_angle, -helix_angle);	// upper half
          *if(d_bore==8)
        cylinder(d=14.8,h=4,$fn=6);
        }
        *if(d_bore==5)
        {
          translate([-3,2,-(height_f-height_fk)]) cube([6,2,(height_f-height_fk)*2]);
          difference() {
            cylinder(d=15,h=8,$fn=40);
            translate([0,0,-.01]) difference() {
              cylinder(d=5,h=10.02,$fn=30);
              translate([-3,2,-.01]) cube([6,2,10.04]);
            }
            translate([-3,2+.84,2]) cube([6,2.8,6.01]);
          translate([0,0,5]) rotate([-90,0]) cylinder(d=3,h=10,$fn=20);
          }
        }
      }
	}
}


/*	Arrow and bevel gear pair with any axis angle; uses the module "arrow_bevel_gear"
    tooth_height = Height of the tooth tip over the cone; Specification for the outside of the cone
    number_of_teeth_wheel = Number of wheel teeth on the wheel
    number_of_teeth_pinion = Number of wheel teeth on the pinion
	axis_angle = Angle between the axles of wheel and pinion
    tooth_width = Width of the teeth from the outside toward the apex of the cone
    d_bore_wheel = Diameter of the center hole of the wheel
    d_bore_pinion = Diameter of the center holes of the pinion
    pressure_angle = Pressure angle, standard value = 20 degrees according to DIN 867
    helix_angle = Bend angle, default = 0 degrees */
module bevel_gear_pair(tooth_height, number_of_teeth_wheel, number_of_teeth_pinion, axis_angle=90, tooth_width, d_bore_wheel, d_bore_pinion, pressure_angle = 20, helix_angle=10, assembled=1){
 
	r_wheel = tooth_height*number_of_teeth_wheel/2;							// Part cone radius of the wheel
	delta_wheel = atan(sin(axis_angle)/(number_of_teeth_pinion/number_of_teeth_wheel+cos(axis_angle)));	// Cone angle of the wheel
	delta_pinion = atan(sin(axis_angle)/(number_of_teeth_wheel/number_of_teeth_pinion+cos(axis_angle)));// Cone angle of the pinion
	rg = r_wheel/sin(delta_wheel);								// Radius of the Grossugel
	c = tooth_height / 6;											// Kopfspiel (head game)
	df_pinion = 4*pi*rg*delta_pinion/360 - 2 * (tooth_height + c);	// Foot cone diameter on the big ball
	rf_pinion = df_pinion / 2;								// Foot cone radius on the big ball
	delta_f_pinion = rf_pinion/(2*pi*rg) * 360;				// Kopfkegelwinkel
	rkf_pinion = rg*sin(delta_f_pinion);					// Radius of the cone foot
	height_f_pinion = rg*cos(delta_f_pinion);				// Height of the cone from the foot cone
	
	echo("Wheel Cone angle = ", delta_wheel);
	echo("Pinion Cone angle = ", delta_pinion);
 
	df_wheel = 4*pi*rg*delta_wheel/360 - 2 * (tooth_height + c);		// Foot cone diameter on the big ball
	rf_wheel = df_wheel / 2;									// Foot cone radius on the big ball
	delta_f_wheel = rf_wheel/(2*pi*rg) * 360;					// Tip angle
	rkf_wheel = rg*sin(delta_f_wheel);							// Radius of the cone foot
	height_f_wheel = rg*cos(delta_f_wheel);						// Height of the cone from the foot cone

	echo("Wheel Height = ", height_f_wheel);
	echo("Pinion Height = ", height_f_pinion);
	
	should_rotate = is_even(number_of_teeth_pinion);
	
	// Wheel
	rotate([0,0,180*(1-play)/number_of_teeth_wheel*should_rotate])
		arrow_bevel_gear(tooth_height, number_of_teeth_wheel, delta_wheel, tooth_width, d_bore_wheel, pressure_angle, helix_angle);
	
  echo(str("translate([-",height_f_pinion*cos(90-axis_angle),",0,",height_f_wheel-height_f_pinion*sin(90-axis_angle),"]) rotate([0,",axis_angle,",0])"));
	// Pinion
	if (assembled == 1)
		translate([-height_f_pinion*cos(90-axis_angle),0,height_f_wheel-height_f_pinion*sin(90-axis_angle)])
			rotate([0,axis_angle,0])
				arrow_bevel_gear(tooth_height, number_of_teeth_pinion, delta_pinion, tooth_width, d_bore_pinion, pressure_angle, -helix_angle);
	else
		translate([rkf_pinion*2+tooth_height+rkf_wheel,0,0])
			arrow_bevel_gear(tooth_height, number_of_teeth_pinion, delta_pinion, tooth_width, d_bore_pinion, pressure_angle, -helix_angle);

}
