for(x=[20,120]) !translate([x,-10,28]) {
  translate([-5,9,4]) linear_extrude(1) {
      square([20,15]);
  }
  difference() {
    linear_extrude(5,convexity=3) {
      square([10,9]);
      translate([5,0]) circle(d=10,$fn=40);
    }
    translate([5,0,-.01]) {
      cylinder(d=4,h=20,$fn=24);
      cylinder(d1=8,d2=4,h=4,$fn=40);
    }
  }
}
intersection(){ union() {
for(pos=[[2,90],[2,2],[137,2],[137,90]]) translate(pos) linear_extrude(40,convexity=3) difference() {
  circle(d=8,$fn=50);
  circle(d=3,$fn=20);
}
difference() {
intersection() {
  difference() {
  linear_extrude(40,convexity=4) difference(){
    offset(4,$fn=20) translate([2,2]) square([5.5*25.4-4,92-4]);
    translate([28,26]) {
      circle(d=13,$fn=40);
    }
    translate([24,67]) circle(d=36,$fn=60);
    translate([66,46]) {
      circle(d=10,$fn=30);
      translate([0,31]) circle(d=4,$fn=24);
      translate([0,-31]) circle(d=4,$fn=24);
      *translate([-22,-35]) square([44,70]);
    }
    
    	translate([110,25]) {
        translate([0,19.3915]) circle(d=4,$fn=30);
        for(y=[0,19.3915*2]) translate([0,y]) rotate([0,0,90]) difference() {
				circle(r=17.4625, h=15, center = true);
				translate([-24.2875,-15,-2]) square([10,37], center = false);
				translate([14.2875,-15,-2]) square([10,37], center = false);
								}
              }
            }
      translate([28,26]) translate([-8,-14.5,1.01]) cube([16,29,3]);
      translate([1.4,1.4,2]) minkowski() {
        translate([2,2,3.99]) cube([5.5*25.4-2.8-4,92-2.8-4,50]);
        sphere(r=4,$fn=20);
      }
  }
  *translate([5,60]) cube([47,28,2]);
}
  translate([-4,28,18]) rotate([90,180,90]) linear_extrude(10,convexity=3) plugin_profile();
}
  translate([0,0,40]) linear_extrude(2,convexity=3) difference() {
    offset(4,$fn=20) translate([2,2]) square([5.5*25.4-4,92-4]);
    for(pos=[[2,90],[2,2],[137,2],[137,90]]) translate(pos) 
  circle(d=3,$fn=20);

  }
}
  difference() {
    translate([-5,-5,28]) cube([5.5*25.4+8,100,30]);
    
    translate([0,0,36.01]) for(pos=[[2,90],[2,2],[137,2],[137,90]]) translate(pos)  {
      cylinder(d=6,h=6,$fn=20);
      translate([0,0,-3]) cylinder(d1=3,d2=6,h=3,$fn=20);
    }
  }
}

module plugin_profile()
{
  translate([-11.5,8]) mirror([0,1]) {
      offset(2) polygon([[0,0],[23,0],[23,12],[19,16],[4,16],[0,12]]);
      translate([-8.5,8]) circle(d=3,$fn=20);
      translate([31.5,8]) circle(d=3,$fn=20);
    }
}