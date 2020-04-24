/* [Global options] */

// Part to print
part="base"; // [full:Preview Bot,left_foot:Left Foot,right_foot:Right Foot,base:Base section,middle:Middle section,top:Top Plate,head:Head,battery_holder:Battery Holder,arm:Arm,bracket2:Printable Bracket (leg)]
global_width=120; // [70:1:200]
global_depth=84; // [70:1:200]
// Global rounding radius
global_radius=25; // [0:.1:50]
print_standoffs=1; // [0:No,1:Yes]
// Use RobotGeek parts
rgstock=0; // [0:No,1:Yes]

/* [Base] */

base_height=37; // [35:0.5:80]
// Base thickness
base_thick=1.5; // [0.4:0.1:5]
// Put Open Source Hardware gear on base
osh_base=1; // [1:Yes,0:No]
// Toggle Switch hole on base
base_switch_hole=1; // [1:Yes,0:No]
// Buzzer hole on base
base_buzzer_hole=1; // [1:Yes,0:No]
// Horizontal Leg offset from center
leg_offset_h=30; // [0:1:80]
// Vertical Leg offset from edge
leg_offset_v=6; // [0:1:100]
leg_rotation_left=45;
leg_rotation_right=-45;

/* [Mid Section] */

// Battery holder/hole
mid_battery=1; // [1:Yes,0:No]
battery_type="18650"; // [stock:RobotGeek Stock,18650=4x 18650 size (18x65) rechargeables]
middle_height=27; // [20:1:80]
// Wall thickness on midsection
mid_thick=1.5; // [1:0.25:5]
// Arm holes (make global depth >= 84, middle_height >= 34)
mid_arms=0; // [1:Yes,0:No]


/* [Top Plate] */

// Top-plate thickness
plate_height=2; // [0.2:0.1:10]

/* [Head] */

head_height=46.5; // [20:0.5:80]
// Head thickness
head_thick=1.5; // [0.2:0.1:3]
head_vents=0; // [0:No,1:Yes]
// Head Hole Type (20x4 needs head height >= 60)
head_front="lcd20x2"; // [none:None,lcd20x2:Standard LCD (20x2),lcd20x4:Tall LCD (20x4),eyes10:Eyes (10mm dia),eyes20:Eyes (20mm dia)]
// IR
head_ir=1; // [1:Yes,0:No]

/* [Arm] */

// Connect arm directly to servo
arm_direct=0; // [0:No,1:Yes]
// Arm Thickness
arm_thick=5; // [3:.5:10]
// Arm Outline
armpath=[[[-28,-8],[10,-10],[30,-20],[50,-20],[50,-10],[30,-10],[30,10],[50,10],[50,20],[30,20],[10,10],[-28,8]],[[0,1,2,3,4,5,6,7,8,9,10,11]]]; // [draw_polygon:100x100]

/* [Foot] */

// Foot Thickness
foot_thick=5; // [5:0.5:30]
// Foot Outline
footpath=[[[-22.8,-37.11],[32.8,-37.11],[32.8,37.11],[-32.8,37.11],[-32.8,-27.11]],[[0,1,2,3,4]]]; // [draw_polygon:100x100]
// Label left/right foot
foot_stamp=0;

/* [Bracket] */

bracket_thick=1.575; // [1:0.125:5]
bracket_length=74; // [30:1:100]

/* [Hidden] */

if(part=="full"||part=="all"||part=="bot")
  bot();
else if(part=="full2") {
  stl_bot();
  *translate([27.5,-2.1,142.5]) armblock();
} else if(part=="bracket2") {
  rotate([90,0])
  bracket(bracket_thick);
} else if(part=="base") {
  base();
} else if(part=="middle") {
  middle();
  //%translate([0,0,middle_height]) top_plate();
} else if(part=="top") {
  //%translate([0,0,-middle_height-.01]) middle();
  //%translate([0,0,head_height+2.01]) mirror([0,0,1]) head();
  top_plate();
} else if(part=="head") {
  mirror([1,0]) head();
} else if(part=="foot"||part=="left_foot") {
  foot();
} else if(part=="right_foot") {
  foot(left=0);
} else if(part=="servo") {
  servo();
} else if(part=="shoe"||part=="left_shoe") {
  shoe();
} else if(part=="right_shoe") {
  mirror([1,0]) shoe();
} else if(part=="arm") {
  arm(arm_direct);
} else if(part=="battery_holder") {
  battery_holder();
}
module arm(direct=0) {
  translate([0,0,-arm_thick]) difference(){
    union(){
      translate([20,0]) linear_extrude(arm_thick,convexity=10) {
        polygon(points=armpath[0],paths=armpath[1]);
      }
      if(direct) {
      translate([0,0,arm_thick]) cylinder(d1=15,d2=15,h=5,$fn=50);
      translate([0,0,arm_thick+5]) cylinder(d1=15,d2=10,h=2,$fn=30);
      }
    }
    translate([0,0,-.01]) cylinder(d=3,h=30,$fn=30);
    if(direct)
      translate([0,0,7]) cylinder(d=6,h=30,$fn=30);
    else
      translate([0,0,3]) servo_blade(h=8);
  }
}
module servo_blade(h=2,sub=0) {
 linear_extrude(h+.01) {
       for(r=[0]) rotate([0,0,r]) {
         
    circle(d=13,$fn=40);
    translate([17,0]) circle(d=6,$fn=20);
    *translate([-17,0]) circle(d=6,$fn=20);
    polygon([[0,-5.5],[17,-3],[17,3],[0,5.5]]);
    }
  }
  if(sub!=0) {
    for(x=[7.5:3:16.5],r=[0:90:360]) rotate([0,0,r])
    translate([x,0,-10]) cylinder(d=2,h=20,$fn=20);
  }
}
module armblock() {
  cube([100,70,40]);
}
module bracket(thick=bracket_thick,servo=!rgstock) {
  //#translate([-23.75,-10.5]) import("Chip-E_-_RobotGeek_Biped/files/Bracket.stl");
  if(servo) {
    translate([0,0,-3]) difference(){
      cylinder(d1=10,d2=16,h=3,$fn=30);
      translate([0,0,-.01]) cylinder(d=5.8,h=3.02,$fn=20);
    }
  }
  difference(){
    translate([-23.2,-10.5,0.01]) cube([46.4,21,thick]);
    if(!servo) hornholes(thick);
    else servoholes(thick);
  }
  for(m=[0,1]) mirror([m,0]) {
    difference(){
      translate([-23.5-thick,-10.5,thick+.5]) union() {
        cube([thick,21,bracket_length-20.01+(servo?0:3.5)]);
        if(servo)
          translate([thick,10.5,bracket_length-21.5]) rotate([0,90]) {
            translate([0,0,-thick]) cylinder(d=21,h=thick,$fn=50);
            difference() {
              cylinder(d1=16,d2=10,h=3,$fn=30);
              translate([0,0,-.01]) cylinder(d=5.4,h=3.02,$fn=30);
            }
          }
          translate([thick+0.8,0,0.3]) rotate([0,90]) rotate([-90,0]) rotate_extrude(angle=90,$fn=50) translate([0.8,0]) square([thick,21]);
        *rotate([-90,0]) intersection() {
          translate([2.5,-.45]) linear_extrude(21,convexity=10) difference(){
            circle(d=5,$fn=30);circle(d=1,$fn=20);
          }
          translate([0,0]) cube([5,5,21]);
        }
      }
      translate([-23.6-thick,0,bracket_length-20]) rotate([0,90]) {
        if(!servo) hornholes(thick,1);
        else servoholes(thick);
        if(rgstock)
       for(y=[0:-8.25:-bracket_length+43])
        translate([15.2-y,-7.5]) {
          intersection(){
            cube([5,15,thick+1]);
            translate([-.25,4.5]) rotate([0,0,-45]) translate([-0,4,1]) cube([12,12,thick+3],center=true);
          }
          
        }
      }
    }
  }
    if(!servo) for(m=[0,1]) mirror([0,m])
      translate([-24,10.2,2.5]) rotate([0,90,0]) intersection() {
        linear_extrude(47.5,convexity=10) difference(){
          circle(d=5,$fn=20);circle(d=2,$fn=20);
        }
        translate([-.2,-.2]) cube([2.69,3,47.5]);
      }
}
module servo() {
  *%import("Servo13.stl");
  translate([rgstock?-2.5:0,0]) {
  if(rgstock) {
    translate([10,10,-5]) cylinder(d=6,h=38,$fn=20);
    translate([10,10,37]) difference() {
      translate([0,0,-38.5]) cylinder(d=12,d2=11.75,h=40.1,$fn=50);
      translate([0,0,-.01]) cylinder(d=6,h=2,$fn=30);
    }
  }
  cube([40,20,37]);
  *translate([10,10,-2]) cylinder(d=6,h=41,$fn=20);
  if(!rgstock) translate([-6.25,0,10]) difference() {
    cube([52.5,20,2.3]);
    for(x=[2,50.5],y=[4.5,15.5])
      translate([x,y,-.01]) cylinder(d=4.5,h=3,$fn=30);
  }
  if(rgstock) {
    difference() {
      mirror_zoffset(19.15) {
        difference() { union() {
            translate([40,-5,8.15]) cube([5,30,1.25]);
            mirror_yoffset(10) translate([40,-1,9.4]) cube([5,7,1.25]);
          }
          mirror_yoffset(10) translate([42.5,2.5,9.4]) { cylinder(d=4.5,h=2,$fn=6);
            translate([0,0,-5]) cylinder(d=2.1,h=10,$fn=30);
            translate([0,-2]) cube([2.51,4,3]);
          }
        }
        mirror_yoffset(10) 
        translate([0,-4.97,8.15]) difference() {
          union(){
            cube([40,5,1.25]);
            translate([0,0,1.25]) {
              cube([6,5,1.25]);
              translate([14.1,0])
                cube([11.85,5,1.25]);
              translate([34,0])
                cube([6.94,5,1.25]);
            }
          }
          for(x=[2.5,17.5,22.5,37.5])
            translate([x,2.5,1.25]) {
              rotate([0,0,90])
                cylinder(d=4.5,h=2,$fn=6);
              translate([-2,-2.51]) cube([4,2.5,3]);
              translate([0,0,-5]) cylinder(d=2.1,h=10,$fn=30);
            }
        }
      }
      mirror_yoffset(10) mirror_zoffset(20) mirror_xoffset(21) translate([-3,0,7]) rotate([0,0,-135]) cube(10);
    }
  }
  }
}
module mirror_xoffset(xoff)
{
  translate([xoff,0]) for(m=[0,1]) mirror([m,0]) translate([-xoff,0]) children();
}
module mirror_yoffset(yoff)
{
  translate([0,yoff]) for(m=[0,1]) mirror([0,m]) translate([0,-yoff]) children();
}
module mirror_zoffset(zoff)
{
  translate([0,0,zoff]) for(m=[0,1]) mirror([0,0,m]) translate([0,0,-zoff]) children();
}
module servoholes(thick) {
   cylinder(d=3,h=thick+1,$fn=20);
}
module hornholes(thick,square=0) {
  cylinder(d=10,h=thick+.5,$fn=20);
  for(r=[0:45:359])
    rotate([0,0,r]) translate([7.5,0]) cylinder(d=2,h=thick+.5,$fn=12);
  if(square)
    translate([-15,-5]) cube([15,10,thick+2]);
}

module foot(bot_offset=0,left=1) {
  //%translate([-121.11,-33.82]) import("Chip-E_-_RobotGeek_Biped/files/Foot_Left.stl");
  //import("Chip-E_-_RobotGeek_Biped/files/Foot_Left.stl");
  translate(bot_offset?[121.11,32]:[]) {
    translate([0,-2]) mirror([0,1]) mirror([left?0:1,0])
    {
      translate([-26,17,5.11]) rotate([90,0]) {
        if(part=="full")
          translate([0,foot_thick-5]) color("gray") servo();
        //else %servo();
      }
      if(!rgstock) foot_sidemod();
      }
    mirror([left?0:1,0])
    difference() {
      linear_extrude(foot_thick) polygon(points=footpath[0],paths=footpath[1]);
      if(foot_stamp) mirror([left?0:1,0])
        translate([0,-26,foot_thick-.8]) rotate([0,0,180]) linear_extrude(1) text(left?"left":"right",valign="center",halign="center");
      translate([32.8-7,-33.82+3.6,foot_thick-.6]) cylinder(d=7,h=2,$fn=30);
      translate([0,0,foot_thick-5]) if(rgstock) {
        translate([-29,-13.7,-.01]) cube([44.9,22.5,5.2]);
        for(x=[8.5,-6.5,-11.5,-26.5]) translate([x,-18,2.5]) rotate([-90,0]) cylinder(d=2,h=30,$fn=20);
      }
    }
    mirror([left?0:1,0])
    linear_extrude(foot_thick+1) difference() {
      polygon(points=footpath[0],paths=footpath[1]);
      offset(r=-3) polygon(points=footpath[0],paths=footpath[1]);
    }
  }
}
module foot_sidemod(both=0) {
  
  translate([-25.8,16.8,5.5]) rotate([90,0]) {
    translate([0,0,40.5]) {
      difference(){
        union(){
          translate([-1,-1,-1]) cube([21,21,3]);
          translate([10,10]) cylinder(d=5,h=3,$fn=40);
        }
        translate([10,10,-1.02]) cylinder(d=3,h=5.02,$fn=30);
      }
      *translate([10,10]) 
        cylinder(d=6,h=3,$fn=30);
    }
  translate([0,10]) for(m=both?[0,1]:[0]) mirror([0,m,0]) translate([-7,-5-10,8.2]) difference(){
    union(){
      cube([54,4.5,22]);
      translate([0,0,4.3]) cube([6.5,25,30]);
      translate([47,0,4.3]) cube([6.5,25,17.7]);
    }
    *translate([-.01,-.01,22]) cube([8,5,14.5]);
    translate([-.01,12,20]) cube([10,14,11.3]);
    translate([7,-.01,both?8:3]) cube([39,28,16]);
    /*
    rotate([0,0,45]) translate([-1,-8,-2]) cube([5.3,30,40]);
    translate([-1,-8,-2]) cube([5.3,13,40]);
    translate([48,0]) rotate([0,0,-45]) translate([-1,-8,-2]) cube([5.3,30,40]);
    translate([50,0]) translate([-1,-8,-2]) cube([5.3,13,40]);
    */
    for(x=[3,51],y=[9.5,20.5])
      translate([x,y,0]) cylinder(d=3,h=40,$fn=20);
    for(x=[9.6,24.5,29.5,44.5])
      translate([x,2.5,-.01]) cylinder(d=2.5,h=30,$fn=20);
  }
}
}
module base() {
//  base_heigt=37;
  //%translate([-77.58,-32.94,-78.48]) import("Chip-E_-_RobotGeek_Biped/files/Base.stl");
  intersection()
  {
    translate([global_width*-.5,global_depth*-.5,.01]) 
        cube2([global_width,global_depth,base_height-.01],global_radius);
    union(){

  difference() {
    color(part=="full"?"green":false) union() {
    translate([global_width*-.5,global_depth*-.5]) difference() {
      cube2([global_width,global_depth,base_height],global_radius);
      translate([base_thick,base_thick,-.01]) cube2([global_width-base_thick*2,global_depth-base_thick*2,base_height+.02],global_radius);
    }
    }
    // buzzer hole
    if(base_buzzer_hole)
      translate([0,global_depth*-.5-.01,22]) rotate([-90,0]) cylinder(d=12,h=3,$fn=30);
    if(osh_base)
      translate([0,global_depth*.5-.5,base_height/2]) rotate([90,0]) scale(0.4) mirror([0,0,1]) osh_badge();
  }
  *%mirror_xoffset(0) translate([-10-leg_offset_h/2,-13]) rotate([0,0,90]) servo();
  difference() {
    color(part=="full"?"green":false) union() {
      translate([global_width*-.5,global_depth*-.5]) cube2([global_width,global_depth,2],global_radius);
      // center block
      translate([0,(global_depth-70)/2]) translate([-8.375,16.4]) linear_extrude(7) polygon([[0,0],[15.6,0],[15.6,9.7],[13.6,17],[3.1,17],[0,9.2]]);
    for(m=[0,1]) mirror([m,0]) {
        translate([-35.8-leg_offset_h/2,-14-leg_offset_v]) cube([29.6,55,7]);
        if(print_standoffs)
        for(ym=[0,1]) mirror([0,ym]) translate([global_width*-.5+5,global_depth*-.5+5]) offset_global_radius() { 
          cylinder(d=7,h=37,$fn=30);
          translate([-3.5,-3.5]) cube([3.5,3.5,37]);
        }
      }
    }
    mirror_xoffset(0)
    translate([-30-leg_offset_h/2,-7.5-leg_offset_v,-.01]) {
      cube([20,40.8,7.02]);
      translate([0,-6]) for(y=[3,50.5],x=[4.5,15.5])
translate([x,y,-.01]) cylinder(d=3,h=9,$fn=30);
      if(rgstock) // RG servo holes
      for(x=[-2.5,22.3],y=[3,38])
      translate([x,y,-.01]) cylinder(d=2,h=9,$fn=20);
    }
    translate([0,(global_depth-70)/2]) {
      // Wire hole
      translate([-6.5,18.3,-.01]) cube([11.7,5.25,8]);
      // Switch hole
      if(base_switch_hole)
      translate([0,28.8,-.01]) cylinder(d=6.5,h=8,$fn=20);
      mirror_xoffset()
      {
        translate([0,(global_depth-70)/-2]) for(ym=[0,1]) mirror([0,ym]) translate([global_width*-.5+5,global_depth*-.5+5,-.01]) { 
            offset_global_radius()
            cylinder(d=2.8,h=38,$fn=30);
          }
      }
    }
  }
    *if(base_buzzer_hole)
      color("black") translate([0,global_depth*-.5-1.01,22]) rotate([-90,0]) cylinder(d=11.5,h=3,$fn=30);
  }
  }
}

module middle() {
  //%translate([-77.58,-32.94,-128.98+13.5]) import("Chip-E_-_RobotGeek_Biped/files/Midsection.stl");
  difference() {
    union() {
      difference() {
        translate([global_width*-.5,global_depth*-.5]) cube2([global_width,global_depth,middle_height],r=global_radius);
        translate([global_width*-.5+mid_thick,global_depth*-.5+mid_thick,2]) cube2([global_width-mid_thick*2,global_depth-mid_thick*2,middle_height],r=(global_radius>0)?global_radius-1:0);
        translate([(leg_offset_h-10)/2,leg_offset_v-10]) {
          translate([15,-13,-.01]) cube([20,20,3]);
          translate([-35.2,-13,-.01]) cube([20,40.2,3]);
          translate([-47.8,7.3,-.01]) cube([14,11.65,3]);
          translate([-20,13.2,-.01]) cube([24.1,11.65,3]);
        }
        
        mirror_xoffset(0) mirror_yoffset(0) translate([global_width*-.5+5,global_depth*-.5+5,-.01]) offset_global_radius() cylinder(d=3,h=30,$fn=20);
      }
      if(print_standoffs)
        for(my=[0,1],mx=[0,1]) mirror([mx,0]) mirror([0,my]) translate([global_width*-.5+mid_thick+4,global_depth*-.5+12]) offset_global_radius() {
        translate([-0.5,0]) cylinder(d=6,h=middle_height,$fn=20);
        translate([-(global_radius>5?global_radius/2:0)-1,-3]) cube([global_radius>5?global_radius/2:0,6,middle_height]);
      }
      if(mid_battery)
      {
        if(battery_type=="18650") {
          translate([30,global_depth*-.5+mid_thick+0.5,4]) rotate([0,0,90]) battery_holder(4);
        }
        translate([28.419-(global_radius>5?global_radius/2:0),global_depth/2-27]) {
          difference(){
            union() {
              linear_extrude(8) polygon([[10.5,3.5],[12.4,8],[12.4,27],[0,27],[0,7.9],[1.7,3.5]]);
              translate([1.7,0]) cube([9,3.5,12.2]);
            }
            translate([-.01,9.4,3.52]) cube([13,4.1,3.2]);
            translate([6.2,-.01,14.5]) rotate([-90,0]) cylinder(d=9,h=5,$fn=30);
          }
        }
      }
      if(mid_arms) {
        mirror_xoffset(0) {
         *%translate([global_width*-.5-6.5,-17.5-(rgstock?0:2.5),middle_height/2-8.8]) rotate([0,90]) rotate([0,0,90]) servo();
          translate([global_width*-.5-5.5,-28,0]) cube2([7,56,middle_height],r=global_radius>2?2:global_radius);
        }
      }
    }
    if(mid_arms) {
      mirror_xoffset(0) translate([global_width*-.5-.01,-20.25,middle_height/2-9]) {
        translate([-6,0]) cube([mid_thick+6.02,40.5,20.5]);
        translate([-7,-.4,20]) rotate([0,90,0]) {
        translate([0,-6]) for(y=[3,50.5],x=[4.5,15.5])
          translate([x,y,-.01]) cylinder(d=2.8,h=9,$fn=30);
        if(rgstock) // RG servo holes
          for(x=[-2.5,22.3],y=[3,38])
            translate([x,y,-.01]) cylinder(d=2,h=9,$fn=20);
        }
      }
    }
    if(mid_battery)
    translate([34.619-(global_radius>5?global_radius/2:0),global_depth/2-3,14.5]) rotate([-90,0]) cylinder(d=12.5,h=5,$fn=30);
    // Standoff holes
    mirror_xoffset(0) mirror_yoffset(0) translate([global_width*-.5+5,global_depth*-.5+12,-.01]) offset_global_radius() cylinder(d=3,h=middle_height+.02,$fn=20);
  }
}
module battery_holder()
{
  bht=8;
  if(battery_type=="18650")
  {
    difference() {
      cube([20*4,69,bht]);
      for(x=[10:18.2:70])
        translate([(x>40?5:0)+x,2,bht+3]) rotate([-90,0]) cylinder(d=18,h=65,$fn=40);
    }
  }
}

module offset_global_radius()
{
  rotate([0,0,45]) translate([global_radius>5?(global_radius)/2.5-2:0,0]) rotate([0,0,-45])
  children();
}

module head_shape()
{
  headshape=[[global_width*-.5,0],[global_width*.5,0],[global_width*.5,head_height],[global_width*-.5+8.7,head_height],[global_width*-.5,head_height-8.7]];
  difference() {
    if(global_radius>0) {
        minkowski() {
            translate([0,global_depth*.5-global_radius]) rotate([90,0]) linear_extrude(global_depth-global_radius*2) polygon([for(point=headshape) [point[0]+(point[0]<0?global_radius:-global_radius),point[1]]]);
            cylinder(r=global_radius,$fn=global_radius*5);
          }
        } else {
          translate([0,global_depth*.5]) rotate([90,0]) linear_extrude(global_depth) polygon(headshape);
        }
        if(global_radius>0) {
          minkowski() {
            translate([0,global_depth*.5-head_thick-global_radius]) rotate([90,0]) linear_extrude(global_depth-head_thick*2-global_radius*2) offset(head_thick*-1) polygon([for(point=headshape) [point[0]+(point[0]<0?global_radius:-global_radius),point[1]]]);
              cylinder(r=global_radius,$fn=global_radius*5);
          }
        } else {
            translate([0,global_depth*.5-head_thick]) rotate([90,0]) linear_extrude(global_depth-head_thick*2) offset(head_thick*-1) polygon(headshape);
        }
        translate([global_width*-.5+head_thick,global_depth*-.5+head_thick,-1]) cube2([global_width-head_thick*2,global_depth-head_thick*2,6],global_radius);
        }
}

module head()
{
  difference() {
    union() {
      
      color(part=="full"?"red":false) translate([0,0,head_height]) mirror([0,0,1]) {
        //%translate([-42.22,35,46.5]) rotate([0,180,180]) import("Chip-E_-_RobotGeek_Biped/files/Head.stl");
        head_shape();
      }
      translate([50-(global_width/2),0]) {
        if(head_ir)
          for(x=[-38,-18],y=[-7.5,22.5]) translate([x,y,1]) cylinder(d=6,h=4.5,$fn=20);
      }
      if(head_front=="lcd20x2"||head_front=="lcd20x4")
      {
        translate([global_width*-.5+9.35,global_depth*-.5+head_thick,1]) cube([4.5,4-head_thick,24.5]);
      }
    }
    for(xm=[0,1],ym=[0,1]) mirror([xm,0]) mirror([0,ym]) offset_global_radius()
        translate([global_width*-.5+(xm?5:12),global_depth*-.5+(!xm&&!ym?10:5),-2]) cylinder(d=3,h=head_height,$fn=20);

    *for(y=[global_depth*-.5+10,global_depth/2-5]) translate([-38,y,-2]) cylinder(d=3,h=4,$fn=20);
    if(head_ir) {
      translate([50-(global_width/2),0]) for(x=[-38,-18],y=[-7.5,22.5]) translate([x,y,-.01]) cylinder(d=3,h=10,$fn=20);
        translate([global_width/-2+16,11.5,-2]) linear_extrude(4) chamfer_square(12.2,12);
    }
      translate([global_width*-.5-.01,25,28.5]) mirror([0,1]) rotate([0,180]) rotate([0,0,90]) rotate([-90,0,0]) linear_extrude(3) chamfer_square(15,10);
      if(head_vents) {
        for(x=[global_width*-.5+10:10:global_width/2],y=[6,36]) translate([x,global_depth/2+.01,y]) rotate([90,0]) cylinder(d=3,h=4,$fn=20);
        for(x=[-35,-5,25]) translate([x,global_depth/2-3,21.5]) cube([10,5,3.5]);
        }
      if(head_front!="none")
      translate([-36,global_depth*-.5+3,12]) rotate([90,0]) {
      linear_extrude(5) {
        
        if(head_front=="eyes10"||head_front=="eyes20")
        {
          for(x=[20,-20])
          translate([36+x,head_height/2-12]) circle(d=head_front=="eyes10"?10:20,h=5,$fn=50);
        } else {
          square([72,24.5*(head_front=="lcd20x4"?2:1)]);
        }
        }
        if(head_front=="lcd20x2"||head_front=="lcd20x4")
          translate([2.9,4.5,2.6]) cylinder(d=20,h=3,$fn=50);
      }
  }   
  if(head_front=="lcd20x2"||head_front=="lcd20x4")
  {
    translate([-36,global_depth*-.5,12.3]) lcd();
  }
}
module chamfer_square(w,h,chamfer=1.5)
{
  polygon([[chamfer,0],[w-chamfer,0],[w,chamfer],[w,h-chamfer],[w-chamfer,h],[chamfer,h],[0,h-chamfer],[0,chamfer]]);
}

module top_plate()
{
  //%translate([-77.58,-32.94,-142.48]) import("Chip-E_-_RobotGeek_Biped/files/Top_Plate.stl");
  difference() {
    union() {
      translate([global_width*-.5,global_depth*-.5]) cube2([global_width,global_depth,plate_height],global_radius);
      // Standoffs
      if(print_standoffs)
      for(xm=[0,1],ym=[0,1]) mirror([xm,0]) mirror([0,ym]) offset_global_radius()
        translate([global_width*-.5+(xm?5:12),global_depth*-.5+(!xm&&!ym?10:5)]) {
          cylinder(d=7,h=head_height,$fn=30);
          cylinder(d1=8,d2=6,h=4,$fn=30);
        }
    }
    
    mirror_xoffset(0) mirror_yoffset(0) offset_global_radius() translate([global_width*-.5+5,global_depth*-.5+12,-.01]) cylinder(d=3,h=30,$fn=20);
    translate([0,0,-.01]) for(pos=[[-15.7,-19.25],[-14.5,29],[36.6,-14.25],[36.6,13.8]]) translate(pos) cylinder(d=3.3,h=3,$fn=26);
      translate([mid_arms?-5:-42.4,-5.8,-.01]) cube([11.65,17.3,plate_height+1]);
    // Standoff holes
      for(xm=[0,1],ym=[0,1]) mirror([xm,0]) mirror([0,ym]) offset_global_radius()
        translate([global_width*-.5+(xm?5:12),global_depth*-.5+(!xm&&!ym?10:5),-.01]) cylinder(d=2.8,h=head_height+2,$fn=20);

  }
}

module lcd() {
  if(part=="full")
  translate([0,-2]) {
    color("black")
      cube([72,4,head_front=="lcd20x2"?24:40]);
    color("cyan")
      translate([4,-.01,4]) cube([64,1,head_front=="lcd20x2"?16:32]);
  }
  
}

module cube2(dims,r=0)
{
  linear_extrude(dims[2]) {
    translate([r,0]) square([dims[0]-r*2,dims[1]]);
    translate([0,r]) square([dims[0],dims[1]-r*2]);
    for(x=[r,dims[0]-r],y=[r,dims[1]-r])
      translate([x,y]) circle(r=r,$fn=r*10);
  }
}
module shoe(bot_offset=0) {
  *%translate([35,0]) mirror([1,0])
  *servo();
  translate(bot_offset?[166,35]:[])
    translate([-26,17,5.1]) rotate([bot_offset?90:0,0])
  //translate([rgstock?-7.5:-10,rgstock?19.5:20,3]) rotate([0,0,180])
  {
    *%import("Chip-E_-_RobotGeek_Biped/files/Shoe_Left.stl");
    difference() {
      union(){
        translate([-22,15]) scale([1,0.92,1]) cylinder(d=50,h=32.5,$fn=50);
        translate([-5,0,0]) cube([8,15,32.5]);
      }
      translate([rgstock?-50:-45,rgstock?-5:-10,rgstock?5:6.5]) cube([50,30,rgstock?22.5:30]);
      translate([-50,-10,-1]) cube([45,30,50]);
      translate([-50,19,-1]) cube([5,20,40]);
      translate([-6,-5,-1]) cube([5,5,40]);
      if(rgstock) {
        translate([-5,20]) mirror([1,0]) for(x=[2.5,17.5,22.5,37.5])
          translate([x,2.5,1.25]) {
            translate([0,0,-5]) cylinder(d=2.1,h=40,$fn=30);
          }
        for(y=[2.5,17.5]) translate([-2.5,y,-5]) cylinder(d=2.1,h=40,$fn=30);
      } else {
        for(y=[4.5,15.5])
        translate([-0.5,y,-1]) cylinder(d=2.8,h=20,$fn=20);
      }
    }
  }
}

module bot() {
  translate([77.58,0]) {
    translate([-160-leg_offset_h/2,-26.94-leg_offset_v]) translate([140,35]) rotate([0,0,leg_rotation_right]) translate([-140,-35]) {
      
      foot(1,left=0);
      translate([0,0,foot_thick-5]) color("teal")
      translate([0,35.75]) translate([124,0]) mirror([1,0]) translate([-118,0]) mirror([0,1]) translate([0,-35.75]) shoe(1);
    }
    translate([-82.58+leg_offset_h/2,-26.94-leg_offset_v]) translate([100,35]) rotate([0,0,leg_rotation_left]) translate([-100,-35]) {
      foot(1);
      translate([0,0,foot_thick-5]) color("teal")
      translate([0,35.75]) mirror([0,1]) translate([0,-35.75]) shoe(1);
    }
  //import("Chip-E_-_RobotGeek_Biped/files/Foot_Right.stl");
  //import("Chip-E_-_RobotGeek_Biped/files/Base.stl");
  base_bottom=bracket_length+(foot_thick-10);
  translate([0,0,base_bottom]) base();
  translate([0,0,base_bottom+base_height]) {
    color("blue")
      middle();
    if(mid_arms)
    mirror_xoffset(0) translate([global_width*-.5-12,-10,middle_height/2+2]) rotate([90,0]) rotate([0,90]) rotate([0,0,-90]) translate([0,0,arm_direct?0:5]) arm();
  }
  translate([0,0,base_bottom+base_height+middle_height]) top_plate();
  translate([0,0,base_bottom+base_height+middle_height+plate_height+head_height+.01]) mirror([0,0,1]) head();
    
  translate([-20-leg_offset_h/2,8-leg_offset_v,base_bottom]) rotate([180,0,90]) {
    if(rgstock) {
      legs();
    } else {
      color("purple")
      legs();
    }
  }
  }
}
module legs() {
    rotate([0,0,-leg_rotation_right]) bracket();
    translate([0,40+leg_offset_h,0]) rotate([0,0,-leg_rotation_left]) bracket();
}

module stl_bot(head_offset) {
  translate([0,-5,6]) {
  import("Chip-E_-_RobotGeek_Biped/files/Foot_Left.stl");
  translate([15,15]) rotate([0,0,180]) rotate([90,0])
  import("Chip-E_-_RobotGeek_Biped/files/Shoe_Left.stl");
    import("Chip-E_-_RobotGeek_Biped/files/Foot_Right.stl");
  translate([139,15]) rotate([0,0,180]) rotate([90,0])
    import("Chip-E_-_RobotGeek_Biped/files/Shoe_Right.stl");
  }
    import("Chip-E_-_RobotGeek_Biped/files/Base.stl");
    import("Chip-E_-_RobotGeek_Biped/files/Midsection.stl");
    translate([0,0,head_offset?40:0]) {
    import("Chip-E_-_RobotGeek_Biped/files/Top_Plate.stl");
    translate([26.2,33,144.5]) translate([9,35,46.5]) rotate([0,180,180]) import("Chip-E_-_RobotGeek_Biped/files/Head.stl");
    }
  translate([52,26,76]) rotate([180,0,90]) {
    bracket();
    translate([0,50,0]) bracket();
  }
}

module osh_badge(text=0,dmain=30,dinner=12,h=8) {
  difference(){
    osh_teeth(dmain=dmain);
    translate([0,0,-.01]) cylinder(d=dmain,h=h+.02,$fn=50);
  }
  difference(){
    union(){
    cylinder(d=dmain,h=h,$fn=50);
    }
    translate([0,0,-.01]) {
      cylinder(d=dinner,h=h+.02,$fn=40);
    rotate([0,0,-90]) translate([dmain*.5+1,-6,0]) linear_extrude(h+.02) mirror([1,0]) polygon([[0,12],[12,8],[12,4],[0,0]]);
    }
    if(text)
      osh_text();
  }
}

module osh_teeth(dmain=30,h=8)
{
  for(rot=[-225:45:45])
    rotate([0,0,rot+180])
    translate([dmain*.5-1,-4,0]) linear_extrude(h) polygon([[0,8],[8,6],[8,2],[0,0]]);
}
module osh_text()
{
  translate([0,0,h-.99]) linear_extrude(1) 
    for(i=[0:len(txt)])
    {
      ang=220-i*lang;
      translate([cos(ang)*9.5,sin(ang)*9.5])
      rotate([0,0,ang-90])
      text(txt[i],size=3,valign="baseline",halign="center",font="Courier");
    }
  }
 