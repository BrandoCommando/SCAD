module brick(l=10,w=20,h=10,g=0.5) {
difference() {
cube([l,w,h]);
linear_extrude(height=h) polygon(points=[[0,0],[0,g],[g,0]]);
linear_extrude(height=h) polygon(points=[[l-g,0],[l,0],[l,g]]);
translate([0,w,0])
rotate([90,0,0]) linear_extrude(height=w) polygon([[0,0],[0,g],[g,0]]);
translate([l,0,0]) rotate([0,270,0]) linear_extrude(height=l) polygon([[0,0],[0,g],[g,0]]);
translate([l,0,h])
mirror([0,0,1]) rotate([0,270,0]) linear_extrude(height=l) polygon([[0,0],[0,g],[g,0]]);
translate([0,w,h-g])
rotate([90,0,0])
linear_extrude(height=w)
polygon([[0,0],[0,g],[g,g]]);
translate([l,w,0])
mirror([0,1,0]) mirror([1,0,0]) { linear_extrude(height=h) polygon(points=[[0,0],[0,g],[g,0]]);
linear_extrude(height=h) polygon(points=[[l-g,0],[l,0],[l,g]]);
translate([0,w,0])
rotate([90,0,0]) linear_extrude(height=w) polygon([[0,0],[0,g],[g,0]]);
translate([l,0,0]) rotate([0,270,0]) linear_extrude(height=l) polygon([[0,0],[0,g],[g,0]]);
translate([l,0,h])
mirror([0,0,1]) rotate([0,270,0]) linear_extrude(height=l) polygon([[0,0],[0,g],[g,0]]);
translate([0,w,h-g])
rotate([90,0,0])
linear_extrude(height=w)
polygon([[0,0],[0,g],[g,g]]);
}
}
}
brick(); translate([0,20,0]) brick();
translate([10,0,0]) brick(w=10,h=10); translate([10,10,0]) brick(); translate([10,30,0]) brick();
translate([20,0,0]) brick(); translate([20,20,0]) brick();
translate([30,0,0]) brick(w=10); translate([30,10,0]) brick(); translate([30,30,0]) brick();
/*/
//*/