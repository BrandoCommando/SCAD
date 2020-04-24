
include <MCAD/involute_gears.scad>
pitch=180;
pinion_teeth=50;
rack_teeth=30;
th=linear_tooth_size(rack_teeth, pitch);

difference() {
  gear (circular_pitch=pitch,
    number_of_teeth=pinion_teeth,
    gear_thickness = 12,
    rim_thickness = 12,
    hub_thickness = 12);
  translate([0,0,-.01]) cylinder(d=42,h=12.02,$fn=100);
}
translate([-pitch_radius(pinion_teeth, pitch)*2,th*-(floor(rack_teeth/2)+.5),0]) darack();
difference() {
  translate([0,0,-2]) {
    cylinder(d=24,h=1.9);
    cylinder(d=19.9,h=6);
  }
  translate([0,0,-3.01]) cylinder(d=18,h=16.02);
}
#linear_extrude(12) difference() { circle(d=42); circle(d=20); }
translate([-6,-6]) encoder();

module darack() {
  difference() {
    rack(pitch,pinion_teeth,rack_teeth,12);
    translate([-.1,-5.1,-.1]) cube([pinion_teeth*pitch/720,th*rack_teeth+10.2,12.2]);
  }
  translate([0,th*rack_teeth/2-5,0]) cube([pinion_teeth*pitch/720,10,12.2]);
  translate([6,0,6]) rotate([-90,0]) cylinder(d=8,h=94,$fn=40);
}
module encoder() {
  cube([12,12,2]);
  translate([6,6]) cylinder(d=10,h=8);
  translate([6,6]) difference() {
    cylinder(d=5,h=20,$fn=30);
    translate([2,-2,10]) cube([4,4,15]);
  }
}

module rack(circular_pitch, number_of_pinion_teeth, number_of_rack_teeth, height,
pressure_angle=28,
clearance=0.2) 

{
    pitch_diameter  =  number_of_pinion_teeth * circular_pitch / 180;
    pitch_radius = pitch_diameter/2;

    base_radius = pitch_radius*cos(pressure_angle);

    // Diametrial pitch: Number of teeth per unit length.
    pitch_diametrial = number_of_pinion_teeth / pitch_diameter;

    // Addendum: Radial distance from pitch circle to outside circle.
    addendum = 1/pitch_diametrial;

    //Outer Circle
    outer_radius = pitch_radius+addendum;

    // Dedendum: Radial distance from pitch circle to root diameter
    dedendum = addendum + clearance;

    root_radius = pitch_radius-dedendum;
    half_thick_angle = (360 / number_of_pinion_teeth) / 4;

    echo("pitch_radius", pitch_radius);
    echo("outer_radius", outer_radius);
    echo("pitch_diametrial", pitch_diametrial);
    echo("addendum", addendum);
    echo("dedendum", dedendum);

    O = 360/number_of_pinion_teeth;
    th=2*sin(O/2)*pitch_radius;
    rack_teeth=number_of_rack_teeth;
    echo("tooth_length", th);
    echo("rack_length", th*rack_teeth);

    union() {
        for (i=[0:rack_teeth]) {
            translate([0,i*th,0])
            linear_extrude(height)
            involute_gear_tooth(
                pitch_radius=pitch_radius,
                root_radius=root_radius,
                base_radius=base_radius,
                outer_radius=outer_radius,
                half_thick_angle=half_thick_angle,
                involute_facets=0);
        }
        cube([root_radius,th*rack_teeth, height]);
    }
}    


function pitch_radius(number_of_teeth, circular_pitch) = (number_of_teeth * circular_pitch / 180) / 2;
function linear_tooth_size(number_of_teeth, circular_pitch) = 
    2*sin(360/number_of_teeth/2)*pitch_radius(number_of_teeth, circular_pitch);
