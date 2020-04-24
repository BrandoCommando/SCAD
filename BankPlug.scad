cylinder(d=34.6,h=8,$fn=70);
cylinder(d=40,h=1,$fn=80);
translate([0,0,1]) cylinder(d1=38,d2=35,h=1,$fn=80);
translate([0,0,6.5]) rotate_extrude($fn=70) translate([17,0]) circle(d=3,$fn=20);
