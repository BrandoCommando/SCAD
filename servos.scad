$fn = 50;

//sg90(arm=true,angle=90,k=1.03);
//mg90s(arm=true,angle=90,k=1.03);

mg90s_x1 = 22.7;
mg90s_y1 = 12.3;
mg90s_z1 = 22.9;
mg90s_x2 = 32.3;
mg90s_y2 = mg90s_y1;
mg90s_z2 = 2.7;
mg90s_t2 = 19;
mg90s_h1 = 5.7;
mg90s_d1 = mg90s_y1;
mg90s_h2 = 5.7; //5.3;
mg90s_d2 = 5;
mg90s_h3 = 4.3;
mg90s_d3 = 4.6;
mg90s_ta = 1.5;
mg90s_arm_d1 = 7;
mg90s_arm_h1 = 5;
mg90s_arm_d2 = 4;
mg90s_arm_h2 = 2.2;
mg90s_arm_l = 21.7;
mg90s_arm_o = 0.5;

sg90_x1 = 22.7;
sg90_y1 = 12.3;
sg90_z1 = 22.6;
sg90_x2 = 32.3;
sg90_y2 = sg90_y1;
sg90_z2 = 2.4;
sg90_t2 = 16.5;
sg90_h1 = 4.4;
sg90_d1 = sg90_y1;
sg90_h2 = 4.4;
sg90_d2 = 5.5;
sg90_h3 = 3.1;
sg90_d3 = 4.7;
sg90_ta = 0.8;
sg90_arm_d1 = 6.7;
sg90_arm_h1 = 4.1;
sg90_arm_d2 = 3.9;
sg90_arm_h2 = 2.1;
sg90_arm_l = 19.5;
sg90_arm_o = 0;

module mg90s(arm=true,angle=0,k=1){
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
    translate([(x2-x1)/2,0,0]){
        cube([x1,y1,z1]);
        translate([-(x2-x1)/2,0,t2]) cube([x2,y2,z2]);
        translate([y1/2,y1/2,z1]) cylinder(d=d1,h=h1);
        translate([y1+0.6,y1/2,z1]) cylinder(d=d2,h=h2);
        translate([y1/2,y1/2,z1+h1]) cylinder(d=d3,h=h3);
        if(arm){
            translate([y1/2,y1/2,z1+h1+ta])
            rotate([0,0,angle])
            mg90s_arm(k);
        }
    }
}

module sg90(arm=true,angle=0,k=1){
    x1 = sg90_x1*k;
    y1 = sg90_y1*k;
    z1 = sg90_z1*k;
    x2 = sg90_x2*k;
    y2 = sg90_y2*k;
    z2 = sg90_z2*k;
    t2 = sg90_t2*k;
    h1 = sg90_h1*k;
    d1 = sg90_d1*k;
    h2 = sg90_h2*k;
    d2 = sg90_d2*k;
    h3 = sg90_h3*k;
    d3 = sg90_d3*k;
    ta = sg90_ta*k;
    translate([(x2-x1)/2,0,0]){
        cube([x1,y1,z1]);
        translate([-(x2-x1)/2,0,t2]) cube([x2,y2,z2]);
        translate([y1/2,y1/2,z1]) cylinder(d=d1,h=h1);
        translate([y1+0.6,y1/2,z1]) cylinder(d=d2,h=h2);
        translate([y1/2,y1/2,z1+h1]) cylinder(d=d3,h=h3);
        if(arm){
            translate([y1/2,y1/2,z1+h1+ta])
            rotate([0,0,angle])
            sg90_arm(k);
        }
    }
}

module mg90s_arm(k=1){
    d1 = mg90s_arm_d1*k;
    h1 = mg90s_arm_h1*k;
    d2 = mg90s_arm_d2*k;
    h2 = mg90s_arm_h2*k;
    l = mg90s_arm_l*k;
    o = mg90s_arm_o*k;
    cylinder(d=d1,h=h1);
    translate([0,0,h1-h2-o]) hull(){
        cylinder(d=d1,h=h2);
        translate([l-d1/2-d2/2,0,0]) cylinder(d=d2,h=h2);
    }
}
module sg90_arm(k=1){
    d1 = sg90_arm_d1*k;
    h1 = sg90_arm_h1*k;
    d2 = sg90_arm_d2*k;
    h2 = sg90_arm_h2*k;
    l = sg90_arm_l*k;
    o = sg90_arm_o*k;
    cylinder(d=d1,h=h1);
    translate([0,0,h1-h2-o]) hull(){
        cylinder(d=d1,h=h2);
        translate([l-d1/2-d2/2,0,0]) cylinder(d=d2,h=h2);
    }
}
