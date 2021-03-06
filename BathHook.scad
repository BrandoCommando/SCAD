nl=10;
nl2=2;
hd=25.4*5/16;
md=6;
intersection() {translate([-100,-100]) cube([200,200,8]);
  union(){
translate([0,2,1.8]) {
  sphere(d=md+3,$fn=40);
  rotate([90,0]) {
    cylinder(d=md+1,h=8,$fn=30);
    translate([0,0,8]) cylinder(d1=md+1,d2=md,h=2,$fn=30);
    translate([0,0,8]) cylinder(d=md,h=nl,$fn=26);
  }
  *translate([-6,-nl-hd-8,-3]) {
    cube([11,3,5]);
    cube([6,10,5]);
  }
  translate([hd,-8-nl]) mirror([0,1]) rotate_extrude($fn=40,angle=180) {
    translate([hd,0]) circle(d=md,$fn=26);
  }
  translate([hd*2,-8-nl]) rotate([-90,0]) cylinder(d=md,h=nl2,$fn=26);
  translate([hd*2,-8-nl+nl2]) sphere(d=md+.5,$fn=30);
}
*translate([-2.5,0]) linear_extrude(2.5,convexity=3) {
  polygon([[0,0],[0,-0],[0.5,-0],[0.5,-15],[4.5,-15],[4.5,-0],[5,-0],[5,0]]);
  intersection(){
    translate([0,-30]) square([20,15]);
    translate([9.5,-15]) difference(){
      circle(d=18,$fn=50);
      circle(d=10,$fn=30);
    } 
  }
    translate([14.5,-15]) square([4,4]);
} 

}
}