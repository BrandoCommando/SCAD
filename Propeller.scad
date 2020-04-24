difference(){
  cylinder(d=8,h=6,$fn=40);
  translate([0,0,-.01]) cylinder(d=2,h=6.02,$fn=20);
}
translate([0,0,3]) for(r=[0:2]) rotate([0,0,r*120])
   rotate([15,0]) translate([0,2]) linear_extrude(1) polygon([[0,-1],[10,1.4],[20,2],[30,1],[40,-4],[40,-8],[8,-8],[0,-4]]);