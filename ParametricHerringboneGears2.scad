// OpenSCAD Herringbone Wade's Gears Script
// (c) 2011, Christopher "ScribbleJ" Jansen
//
// Thanks to Greg Frost for his great "Involute Gears" script.
//
// Licensed under the BSD license.
include <MCAD/involute_gears.scad> 


// WHAT TO GENERATE?
generate = 2;    // GENERATE BOTH GEARS FOR VIEWING
// generate = 1;    // GENERATE STEPPER GEAR FOR PRINTING
// generate = 2;    // GENERATE DRIVE GEAR FOR PRINTING

// OPTIONS COMMON TO BOTH GEARS:
distance_between_axels = 15; //sqrt(pow(30,2)+pow(30,2));
gear_h = 12;
gear_shaft_h = 13;
gear2_shaft_h = 6;


// GEAR1 (SMALLER GEAR, STEPPER GEAR) OPTIONS:
// It's helpful to choose prime numbers for the gear teeth.
$fn=40;
gear1_teeth = next_prime(11);
gear1_shaft_d_real = 5;
gear1_shaft_d = gear1_shaft_d_real+.55; //inches(5/16); // 5.35;  			// diameter of motor shaft
gear1_shaft_r  = gear1_shaft_d/2;	
gear1_shaft_od = gear1_shaft_d+3.2;
//gear1_shaft_od = hex_head_diameter(gear1_shaft_d_real)+4;
gear1_shaft_notch=0;
// gear1 shaft assumed to fill entire gear.
// gear1 attaches by means of a captive nut and bolt (or actual setscrew)
gear1_setscrew_offset = 3;			// Distance from motor on motor shaft.
gear1_setscrew_d         = 0;//3.5;		
gear1_setscrew_r          = gear1_setscrew_d/2;
gear1_captive_nut_d = 0;//6.2;
gear1_captive_nut_r  = gear1_captive_nut_d/2;
gear1_captive_nut_h = 3;
gear1_captive_nut_offsetx = 5; //(gear1_shaft_od/4)+1.5;
gear1_bolt_tail = 0;
//gear1_bolt_tail = hex_head_diameter(gear1_shaft_d_real)+.2;
gear1_bolt_head = 0;
gear1_bolt_head = hex_head_diameter(gear1_shaft_d_real)+.2; //hex_head_diameter(gear1_shaft_d_real)+.2;
gear1_chamfer=1;


// GEAR2 (LARGER GEAR, DRIVE SHAFT GEAR) OPTIONS:
gear2_teeth = gear1_teeth; 
gear2_teeth = next_prime(11);
//gear2_teeth = next_prime(gear1_teeth*distance_between_axels/10);
gear_ratio = (gear2_teeth/gear1_teeth);
gear2_shaft_d_real = inches(5/16);
gear2_shaft_d = gear2_shaft_d_real+.25;
gear2_bolt_head = gear2_teeth>30?1:0;//gear_ratio>3;
gear2_bolt_hex_d = hex_head_diameter(gear2_shaft_d_real)+.2;
gear2_shaft_r  = gear2_shaft_d/2;
// gear2 has settable outer shaft diameter.
//gear2_shaft_outer_d = gear2_shaft_d+4.2;
gear2_shaft_outer_d = gear2_bolt_hex_d+1;
gear2_shaft_outer_r  = gear2_shaft_outer_d/2;
gear2_chamfer=1;

echo(str("Ratio: ",gear_ratio," Gear2 D: ",gear2_shaft_d,", ",gear2_bolt_hex_d,", ",gear2_shaft_outer_d));

// gear2 has a hex bolt set in it, is either a hobbed bolt or has the nifty hobbed gear from MBI on it.
gear2_bolt_hex_r        = gear2_bolt_hex_d/2;
// gear2_bolt_sink: How far down the gear shaft the bolt head sits; measured as distance from drive end of gear.
gear2_bolt_sink          = gear2_shaft_h+6;		
// gear2's shaft is a bridge above the hex bolt shaft; this creates 1/3bridge_helper_h sized steps at top of shaft to help bridging.  (so bridge_helper_h/3 should be > layer height to have any effect)
bridge_helper_h=0;

gear2_rim_cut = gear_h/2;
gear2_rim_margin = 3;
gear2_cut_circles  = 5;

// gear2 setscrew option; not likely needed.
gear2_setscrew_offset = 3;//(gear2_shaft_h/2);
gear2_setscrew_d         = 3;
gear2_setscrew_count = (gear2_bolt_head?0:1);
gear2_setscrew_r          = gear2_setscrew_d/2;
// captive nut for the setscrew
gear2_captive_nut_d = (gear2_shaft_h>10?6.2:0);
gear2_captive_nut_r  = gear2_captive_nut_d/2;
gear2_captive_nut_h = 3;
gear2_captive_nut_offsetx = gear2_shaft_d/2+3;


// Tolerances for geometry connections.
AT=0.02;
ST=AT*2;
TT=AT/2;

function inches(mm) = 25.4 * mm;
function hex_head_diameter(bolt_diameter) = (bolt_diameter==5?9.1:((bolt_diameter*(bolt_diameter<inches(5/16)?1.75:(bolt_diameter<inches(3/8)?1.6:1.5)))/cos(30)));
function next_prime(num) = num<=3?3:(num<=5?5:(num<=7?7:(num<=11?11:(num<=13?13:(num<=17?17:(num<=19?19:(num<=23?23:(num<=29?29:(num<=31?31:(num<=37?37:(num<=41?41:(num<=43?43:(num<=47?47:(num<=53?53:(num<=59?59:(num<=61?61:(num<=67?67:(num<=71?71:(num<=73?73:(num<=79?79:(num<=83?83:(num<=89?89:97))))))))))))))))))))));

module bridge_helper()
{
	difference()
	{
		translate([0,0,-bridge_helper_h/2])
		cylinder(r=gear2_bolt_hex_r+TT, h=bridge_helper_h+TT,$fn=6,center=true);
		translate([0,0,-bridge_helper_h/2])
		cube([gear2_bolt_hex_d+ST, gear2_shaft_d, bridge_helper_h+AT], center=true);
	}
}



module gearsbyteethanddistance(t1=13,t2=51, d=60, teethtwist=1, which=1)
{
	cp = 360*d/(t1+t2);

	g1twist = 360 * teethtwist / t1;
	g2twist = 360 * teethtwist / t2;

	g1p_d  =  t1 * cp / 180;
	g2p_d  =  t2 * cp / 180;
	g1p_r   = g1p_d/2;
	g2p_r   = g2p_d/2;

	echo(str("Your small ", t1, "-toothed gear will be ", g1p_d, "mm across (plus 1 gear tooth size) (PR=", g1p_r,")"));
	echo(str("Your large ", t2, "-toothed gear will be ", g2p_d, "mm across (plus 1 gear tooth size) (PR=", g2p_r,")"));
	echo(str("Your minimum drive bolt length (to end of gear) is: ", gear2_bolt_sink+bridge_helper_h, "mm and your max is: ", gear_h+gear2_shaft_h, "mm."));
	echo(str("Your gear mount axles should be ", d,"mm (", g1p_r+g2p_r,"mm calculated) from each other."));
	if(which == 1)
	{
		// GEAR 1
		difference()
		{
		union()
		{
      if(gear_shaft_h>0) translate([0,0,gear_h]) {
        if(gear1_shaft_od>g1p_d-3.5) {
          cylinder(d1=g1p_d-3.5,d2=gear1_shaft_od,h=2,$fn=40);
          translate([0,0,1.99]) cylinder(d=gear1_shaft_od,h=gear_shaft_h-2,$fn=40);
        } else cylinder(d=gear1_shaft_od,h=gear_shaft_h,$fn=40);
      }
      intersection(){union(){
			translate([0,0,(gear_h/2) - TT])
				gear(	twist = g1twist, 
					number_of_teeth=t1, 
					circular_pitch=cp, 
					gear_thickness = gear_shaft_h + (gear_h/2)+AT, 
					rim_thickness = (gear_h/2)+AT, 
					rim_width = 0,
          hub_diameter=gear1_shaft_od,
					hub_thickness = (gear_h/2)+AT, 
					hub_width = 0,
					bore_diameter=0); 
	
			translate([0,0,(gear_h/2) + AT])
			rotate([180,0,0]) 
				gear(	twist = -g1twist, 
					number_of_teeth=t1, 
					circular_pitch=cp, 
					gear_thickness = (gear_h/2)+AT, 
					rim_thickness = (gear_h/2)+AT, 
					hub_thickness = (gear_h/2)+AT, 
					bore_diameter=0); 
        }
        if(gear1_chamfer)
        union(){
          cylinder(d1=g1p_d+1,d2=g1p_d+3,h=1);
        translate([0,0,1]) cylinder(d=g1p_d+3,h=gear_h-2);
        translate([0,0,gear_h-1]) cylinder(d1=g1p_d+3,d2=g1p_d+1,h=1);
        }
      }
      
        if(gear1_captive_nut_d>0)
        translate([gear1_captive_nut_offsetx-gear1_captive_nut_d/2, -gear1_captive_nut_r-2, gear_h+gear_shaft_h-gear1_setscrew_offset-gear1_captive_nut_r-5]) 
					difference() {
            cube([gear1_captive_nut_h+3.5, gear1_captive_nut_d+4, gear1_captive_nut_r+gear1_setscrew_offset+5]);
            translate([gear1_shaft_od/2-gear1_shaft_r-2,-AT]) rotate([0,45]) cube([10,gear1_captive_nut_d+4+ST,10]);
          }

		}
    if(gear1_bolt_tail)
    {
      translate([0,0,gear_h+gear_shaft_h+AT]) mirror([0,0,1]) {
        cylinder(d=gear1_bolt_tail,h=4,$fn=6);
      }
    }
			//DIFFERENCE:
			//shafthole
      difference() {
        translate([0,0,-TT]) 
          cylinder(r=gear1_shaft_r, h=gear_h+gear_shaft_h+ST);
        if(gear1_shaft_notch) translate([gear1_shaft_r*.85,-3,-AT])
          cube([2,6,gear_h+gear_shaft_h+ST]);
      }
      
//      if(bridge_helper_h==0&&gear2_bolt_head)
      if(gear1_bolt_head>0)
      {
        translate([0,0,-.01]) cylinder(d=gear1_bolt_head,h=4.02,$fn=6);
        translate([0,0,4])
          cylinder(d1=gear1_bolt_head,d2=gear1_shaft_d,h=abs(gear1_shaft_d-gear1_bolt_head)/2,$fn=6);
      }

			//setscrew shaft
			translate([0,0,gear_h+gear_shaft_h-gear1_setscrew_offset])
				rotate([0,90,0])
				cylinder(r=gear1_setscrew_r, h=g1p_r*2);

			//setscrew captive nut
			translate([gear1_captive_nut_offsetx, 0, gear_h+gear_shaft_h-gear1_captive_nut_r-gear1_setscrew_offset]) 
				translate([0,0,(gear1_captive_nut_r+gear1_setscrew_offset)/2])
					cube([gear1_captive_nut_h, gear1_captive_nut_d, gear1_captive_nut_r+gear1_setscrew_offset+ST],center=true);
			
		
		}
	}
	else
	{
		// GEAR 2
		difference()
		{
		union()
		{
      translate([0,0,gear_h]) {
        cylinder(d1=gear2_shaft_outer_d-2,d2=gear2_shaft_outer_d,h=1.01,$fn=30);
        translate([0,0,1]) cylinder(d=gear2_shaft_outer_d,h=gear2_shaft_h-1,$fn=30);
      }
      intersection(){union(){
			translate([0,0,(gear_h/2) - TT])
				gear(	twist = -g2twist, 
					number_of_teeth=t2, 
					circular_pitch=cp, 
					gear_thickness = gear2_shaft_h + (gear_h/2)+AT, 
					rim_thickness = (gear_h/2)+AT, 
					rim_width = gear2_rim_margin,
					hub_diameter = gear2_shaft_outer_d,
					hub_thickness = (gear_h/2)+AT, 
					bore_diameter=0,
					circles = gear2_cut_circles); 
	
			translate([0,0,(gear_h/2) + AT])
			rotate([180,0,0]) 
				gear(	twist = g2twist, 
					number_of_teeth=t2, 
					circular_pitch=cp, 
					gear_thickness = (gear_h/2)+AT, 
					rim_thickness = (gear_h/2)+AT, 
					rim_width = gear2_rim_margin,
					hub_diameter = gear2_shaft_outer_d,
					hub_thickness = (gear_h/2)+AT, 
					bore_diameter=0,
					circles = gear2_cut_circles); 
        }
        
        if(gear2_chamfer)
        union(){
          cylinder(d1=g2p_d+1,d2=g2p_d+3,h=1);
        translate([0,0,1]) cylinder(d=g2p_d+3,h=gear_h-2);
        translate([0,0,gear_h-1]) cylinder(d1=g2p_d+3,d2=g2p_d+1,h=1);
        }
      }
		}
			//DIFFERENCE:
			//shafthole
			translate([0,0,-TT]) 
				cylinder(r=gear2_shaft_r, h=gear_h+gear2_shaft_h+ST);

			//setscrew shaft
      if(gear2_setscrew_count>0)
      for(r=[0:360/gear2_setscrew_count:360]) rotate([0,0,r]) {
			translate([0,0,gear_h+gear2_shaft_h-gear2_setscrew_offset])
				rotate([0,90,0])
				cylinder(r=gear2_setscrew_r, h=gear2_shaft_outer_d);

			//setscrew captive nut
      if(gear2_captive_nut_d>0)
			translate([gear2_captive_nut_offsetx, 0, gear_h+gear2_shaft_h-gear2_captive_nut_r-gear2_setscrew_offset]) 
				translate([0,0,(gear2_captive_nut_r+gear2_setscrew_offset)/2])
					cube([gear2_captive_nut_h, gear2_captive_nut_d, gear2_captive_nut_r+gear2_setscrew_offset+ST],center=true);
    }

			//trim shaft
			difference()
			{
        union() {
          translate([0,0,gear_h+AT])	cylinder(h=gear2_shaft_h+gear2_rim_cut+ST, r=g2p_r);
          translate([0,0,gear_h-gear2_rim_cut+AT]) cylinder(r=g2p_r-gear2_rim_margin-2,h=gear2_rim_cut+ST);
        }
        translate([0,0,gear_h-gear2_rim_cut]) difference() {
          cylinder(d1=gear2_bolt_hex_d+2.1,d2=gear2_shaft_outer_d,h=(gear_h-gear2_rim_cut)-2);
        }
				translate([0,0,0])	cylinder(h=gear2_shaft_h+gear_h, r=gear2_shaft_outer_r);
			}
      
      bolt_hex_h=gear_h+gear2_shaft_h-gear2_bolt_sink+AT;
      bolt_hex_h=5;
      
      if(bridge_helper_h==0&&gear2_bolt_head)
        translate([0,0,bolt_hex_h])
          cylinder(d1=gear2_bolt_hex_d,d2=gear2_shaft_d,h=abs(gear2_shaft_d-gear2_bolt_hex_d)/2,$fn=6);

			//hex bolt head
      if(gear2_bolt_head)
			translate([0,0,-TT]) cylinder(r=gear2_bolt_hex_r, h=bolt_hex_h+AT,$fn=6);

		}

		// hex bolt shaft bridge aid.
    if(bridge_helper_h>0)
    {
      translate([0,0,gear_h+gear2_shaft_h-gear2_bolt_sink])
        bridge_helper();
      translate([0,0,gear_h+gear2_shaft_h-gear2_bolt_sink+bridge_helper_h/3])
        rotate([0,0,60]) bridge_helper();
      translate([0,0,gear_h+gear2_shaft_h-gear2_bolt_sink+((bridge_helper_h/3)*2)])
        rotate([0,0,-60]) bridge_helper();
    }
	}
	
}


t1 = gear1_teeth;
t2 = gear2_teeth;
cp = 360*distance_between_axels/(t1+t2);
g1p_d  =  t1 * cp / 180;
g2p_d  =  t2 * cp / 180;
g1p_r   = g1p_d/2;
g2p_r   = g2p_d/2;

if(generate == 1)
{
	gearsbyteethanddistance(t1 = gear1_teeth, t2=gear2_teeth, d=distance_between_axels, which=1);
}
else if(generate == 2)
{
	gearsbyteethanddistance(t1 = gear1_teeth, t2=gear2_teeth, d=distance_between_axels, which=2);
}
else
{

	*translate([-3*g1p_r,0,0]) rotate([0,0,($t*360/gear1_teeth)]) gearsbyteethanddistance(t1 = gear1_teeth, t2=gear2_teeth, d=distance_between_axels, which=1);
	translate([-1*g1p_r-1,0,0]) rotate([0,0,($t*360/gear1_teeth)]) gearsbyteethanddistance(t1 = gear1_teeth, t2=gear2_teeth, d=distance_between_axels, which=1);
	translate([g2p_r,0,0])  rotate([0,0,($t*360/gear2_teeth)*-1]) gearsbyteethanddistance(t1 = gear1_teeth, t2=gear2_teeth, d=distance_between_axels, which=2);
}

