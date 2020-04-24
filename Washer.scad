main_thickness=0.9; // [0:0.1:20]
outer_diameter=22; // [3:0.2:50]
inner_diameter=8; // [1:0.2:48]
inner_notch=0.6; // [0:0.1:5]
outer_notch=0.6; // [0:0.1:5]
filament_width=0.4; // [0.3:0.05:0.8]

ring(t=main_thickness,od=outer_diameter,id=inner_diameter);
translate([0,0,main_thickness-.01]) {
  if(inner_notch>0)
    ring(t=inner_notch,od=inner_diameter+filament_width*6,id=inner_diameter);
  if(outer_notch>0)
    ring(t=outer_notch,id=outer_diameter-filament_width*6,od=outer_diameter);
}

module ring(t,od,id){
  linear_extrude(t,convexity=3) difference() {
    circle(d=od,$fn=outer_diameter*4);
    circle(d=id,$fn=inner_diameter*5);
  }
}