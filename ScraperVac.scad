ld=42;
bd=58;
xoffs=[0];
%mirror([0,0,1])
  bottom();
top();
module bottom() {
  difference() {
    union() {
      connector(1);
      for(x=xoffs)
        translate([x,0]) intersection() {
          rotate([30,0]) translate([0,0,-10]) cylinder(d=40,h=50,$fn=80);
          translate([-20,-40]) cube([40,80,60]);
        }
    }
      for(x=xoffs)
        translate([x,0]) rotate([30,0]) translate([0,0,-20]) cylinder(d=36,h=70,$fn=70);
    }
}
module top() {
  connector();
  skirt();
}
module connector(mid=0) {
linear_extrude(2,convexity=2) difference() {
  hull() {
    translate([-50,0]) circle(d=bd,$fn=40);
    translate([50,0]) circle(d=bd,$fn=40);
  }
  if(!mid)
  hull() {
    translate([-50,0]) circle(d=ld-2,$fn=40);
    translate([50,0]) circle(d=ld-2,$fn=40);
  }
  for(m=[0,1]) mirror([m,0])
  translate([-50,0]) for(r=[90:45:270]) rotate([0,0,r]) translate([ld/2+2,0]) circle(d=3,h=3,$fn=20);
  for(x=[-30:20:30],y=[-ld/2-2,ld/2+2]) if(y>0||abs(x)>11)
    translate([x,y]) circle(d=3,$fn=20);
}
}
module skirt() {
  difference() {
    intersection() {
      translate([-100,-40]) cube([200,80,50]);
      union(){
        rotate([-20,0]) {
        translate([-64,-25,-10]) cube([128,5.5,20]);
        translate([0,0,-20]) linear_extrude(40,convexity=2) difference() {
          hull() {
            translate([-50,0]) circle(d=bd,$fn=40);
            translate([50,0]) circle(d=bd,$fn=40);
          }
          scale([1.03,1])
          hull() {
            translate([-50,0]) circle(d=bd-10,$fn=40);
            translate([50,0]) circle(d=bd-10,$fn=40);
          }
        }
        }
      }
    }
    translate([-80,-50,15]) cube([160,100,50]);
    translate([0,0,-.01]) linear_extrude(10) {
      *for(m=[0,1]) mirror([m,0])
      translate([-50,0]) for(r=[90:45:270]) rotate([0,0,r]) translate([ld/2+2,0]) circle(d=3,h=3,$fn=20);
      for(x=[-30:20:30],y=[-ld/2-2,ld/2+2]) if(y>0||abs(x)>11)
        translate([x,y]) circle(d=3,$fn=20);
      }
    }
}