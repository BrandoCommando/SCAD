use <ccube.scad>
include <servos.scad>

wall = 1.6;
leg_h = 38.5;
foot_h = 5;
foot_w = 43;
foot_l = 62;

k=1.03;

x1 = mg90s_x1*k;
y1 = mg90s_y1*k;
z1 = mg90s_z1*k;
x2 = mg90s_x2*k;
y2 = mg90s_y2*k;
z2 = mg90s_z2*k;
t2 = mg90s_t2*k;
h1 = mg90s_h1*k;
d1 = mg90s_d1*k;
h2 = mg90s_h2*k;
d2 = mg90s_d2*k;
h3 = mg90s_h3*k;
d3 = mg90s_d3*k;
ta = mg90s_ta*k;
arm_d1 = mg90s_arm_d1*k;
arm_h1 = mg90s_arm_h1*k;
arm_d2 = mg90s_arm_d2*k;
arm_h2 = mg90s_arm_h2*k;
arm_l = mg90s_arm_l*k;
arm_o = mg90s_arm_o*k;
module servo(){
    mg90s(k=1.03);
}
module servo_arm(){
    mg90s_arm(k=1.03);
}

// if you want to use the sg90, try this configs (not tested)
//x1 = sg90_x1*k;
//y1 = sg90_y1*k;
//z1 = sg90_z1*k;
//x2 = sg90_x2*k;
//y2 = sg90_y2*k;
//z2 = sg90_z2*k;
//t2 = sg90_t2*k;
//h1 = sg90_h1*k;
//d1 = sg90_d1*k;
//h2 = sg90_h2*k;
//d2 = sg90_d2*k;
//h3 = sg90_h3*k;
//d3 = sg90_d3*k;
//ta = sg90_ta*k;
//arm_d1 = sg90_arm_d1*k;
//arm_h1 = sg90_arm_h1*k;
//arm_d2 = sg90_arm_d2*k;
//arm_h2 = sg90_arm_h2*k;
//arm_l = sg90_arm_l*k;
//arm_o = sg90_arm_o*k;
//module servo(){
//    sg90(k=1.03);
//}
//module servo_arm(){
//    sg90_arm(k=1.03);
//}



module leg(){
    difference(){
        cCube([z1+h1+wall+2,y1+2*wall,leg_h],h1=0,l=wall*sqrt(2),h2=wall);
        union(){
            translate([wall+2.001,wall,leg_h]) rotate([0,90,0]) servo();
            translate([wall,wall,leg_h-(x2-x1)/2-y1/2]) cube([z1+h1+2,y1,y1/2+(x2-x1)/2]);
            translate([wall,wall,arm_h1-arm_o]) cube([t2+z2+2,y1,leg_h-(arm_h1-arm_o)]);
            translate([wall+t2+z2+wall+2,y1/2+wall,leg_h-x2+(x2-x1)/4]) rotate([0,90,0]) cylinder(h=10,d=5);
            translate([-1,y1/2+wall,leg_h-(x2-x1)/2-y1/2]) rotate([0,90,0]) cylinder(h=2*wall,d=5);
            translate([wall+t2+z2+2,y1/2+wall,leg_h-x2+(x2-x1)/4]) rotate([0,90,0]) cylinder(h=5,d=2);
            translate([(z1+h1+wall)/2,y1/2+wall,0]) rotate([0,0,180]) servo_arm();
            translate([wall+1,-1,arm_h1-arm_o])
            intersection(){
                translate([0,y1+2*wall+2,0]) rotate([90,0,0]) cylinder(y1+2*wall+2,28,28,$fn=3);
                cube([19,y1+2*wall+2,14]);
            }
        }
    }
}

module foot(){
    l1 = z1+h1+wall+2+(arm_h1-arm_o-0.0001)*2+1.7;
    l2 = z1+h1+wall+2+1.7;
    difference(){
        union(){
            cCube([foot_w,foot_l,foot_h],h1=arm_h2,l=7,h2=0);
            translate([0,l1+(foot_l-l1)/2,-3]) rotate([90,0,0]) intersection(){
                cCube([21,28,l1],h1=arm_h2,l=7,h2=arm_h2);
                translate([0,3,0]) cube([21,25,l1]);
            }
        }
        translate([0,l2+(foot_l-l2)/2,5]) rotate([90,0,0]) cube([21,21,l2],h1=3,l=7,h2=3);
        translate([-l2/2+21+3,l2/2+(foot_l-l2)/2,2]) rotate([0,0,45]) cylinder(3,(l2-6)*sqrt(2)/2,l2*sqrt(2)/2,$fn=4);
        translate([21/2,(foot_l-l2)/2,foot_h+(x2-x1)/2+y1/2]) rotate([0,-90,90]) servo_arm();
    }
    translate([21/2,foot_l-(foot_l-l2)/2,foot_h+(x2-x1)/2+y1/2]) sphere(d=5);    
}

module body(){
}
module head(){
    
}

//translate([3,0,0]) foot();
//mirror([1,0,0]) translate([3,0,0]) foot();
//leg();
//body();