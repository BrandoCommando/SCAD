sections=7;
dias=[20,18,15,14,15,18,20];
heights=[20,20,20,20,14,14,20];
sfn=24;

intersection(){
  sphere(d=100,$fn=100);
  translate([-50,-50]) cube([100,100,50]);
}
translate([0,0,36]) rotate([10,0]) section(0) section(1) section(2) section(3) section(4) section(5) section(6) ball();

module ball()
{
  scale([1,1,1.2]) translate([0,0,28]) sphere(d=60,$fn=60);
}
module section(i,$fn=sfn)
{
   translate([0,0,i>0?heights[i-1]:0]) rotate([5,0]) {
     sphere(d=dias[i],$fn=$fn);
     cylinder(d1=dias[i], d2=dias[i<6?i+1:0], h=heights[i], $fn=$fn);
     if($children>0)
       children(0);
   }
}