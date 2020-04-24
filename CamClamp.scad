tw=10;
ext=40;
lift=tw+2;
rotate([0,90])
{
  *union(){
  cube([30,tw,9]);
  translate([30,0,-2]) cube([4,tw,11]);
  rotate([90,0,180]) linear_extrude(tw) polygon([[0,0],[0,15],[19,15]]);
  *cube([4,tw,19]);
  translate([-1*ext+1,0,-2]) cube([11,tw+lift+16,17]);
translate([5-ext,0,13]) cube([ext,tw,3.5]);
  translate([8-ext,0]) {
  translate([0,0,18]) cube([4,26+lift,2]);
  translate([0,0,13]) cube([4,tw,6]);
  translate([0,0,14.5]) cube([4,26+lift,2]);
    translate([-3,2,16.5]) rotate([90,0]) linear_extrude(2) polygon([[0,0],[0,11],[11,0]]);
  }
}
translate([ext*-1+1,0,13]) {
  difference(){
    cube([4,tw,60]);
    *translate([-.01,10,50]) rotate([0,90,0]) cylinder(d=4,h=5,$fn=30);
  }
  translate([0,0,60]) cube([4,lift,17]);
  translate([0,lift]) translate([-1,-3,60]) {
    //intersection()
    {
      //translate([-8,0]) cube([20,30,20]);
      rotate([0,5,55]) difference(){
        translate([-2,-2,0]) cube([6,28,17]);
        translate([0,0,.5]) for(x=[3,23.1],y=[2,14]) translate([-5,x,y]) rotate([0,90]) cylinder(d=2,h=15,$fn=20);
      }
    }
  }
}
translate([-1*ext+1,0,12]) {
  *cube([30,4,4]);
  translate([0,-30,0]) cube([4,39,4]);
  *translate([-26,0]) cube([30,4,4]);
}
}
