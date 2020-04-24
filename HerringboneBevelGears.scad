// Spiel zwischen Zahnflanken
spiel = 0.05;
// Hoehe des Zahnkopfes ueber dem Teilkegel; Angabe fuer die Aussenseite des Kegels
modul = 2;
// Anzahl der Radzaehne am Rad
zahnzahl_rad = 53;
// Anzahl der Radzaehne am Ritzel
zahnzahl_ritzel = 13;
// Winkel zwischen den Achsen von Rad und Ritzel
achsenwinkel = 90;
// Breite der Zaehne von der Aussenseite in Richtung Kegelspitze, Standardwert = 90 grad
zahnbreite = 10;
// Durchmesser der Mittelbohrung des Rades
bohrung_rad = 4;
// Durchmesser der Mittelbohrung des Ritzels
bohrung_ritzel = 4;
// Eingriffswinkel, Standardwert = 20 grad gemaess DIN 867
eingriffswinkel = 20;
// Schraegungswinkel, Standardwert = 0 grad
schraegungswinkel=30;
// Zusammen gebaut oder zum Drucken getrennt
zusammen_gebaut = 2;

/* Bibliothek fuer Evolventen-Zahnraeder

Autor:		Dr Joerg Janssen
Stand:		15. Juni 2016
Version:	1.3
Lizenz:		GNU non-commercial license

Erlaubte Module nach DIN 780:
0.05 0.06 0.08 0.10 0.12 0.16
0.20 0.25 0.3  0.4  0.5  0.6
0.7  0.8  0.9  1    1.25 1.5
2    2.5  3    4    5    6
8    10   12   16   20   25
32   40   50   60

*/


/* [Hidden] */
pi = 3.14159267;
rad = 57.29578;
$fn = 96;


/*  Kugelevolventen-Funktion
    Gibt die Polarkoordinaten einer Kugelevolvente aus
    theta0 = Winkel des Kegels, an dessen Schnittkante zum Grosskugel die Evolvente abrollt
    theta = Winkel zur Kegelachse, fuer den der Azimutwinkel der Evolvente berechnet werden soll */
function kugelev(theta0,theta) = 1/sin(theta0)*acos(cos(theta)/cos(theta0))-acos(tan(theta0)/tan(theta));

/*  Wandelt Kugelkoordinaten in kartesische um
    Format: radius, theta, phi; theta = Winkel zu z-Achse, phi = Winkel zur x-Achse auf xy-Ebene */
function kugel_zu_kart(vect) = [
	vect[0]*sin(vect[1])*cos(vect[2]),  
	vect[0]*sin(vect[1])*sin(vect[2]),
	vect[0]*cos(vect[1])
];

/*	prueft, ob eine Zahl gerade ist
	= 1, wenn ja
	= 0, wenn die Zahl nicht gerade ist */
function istgerade(zahl) =
	(zahl == floor(zahl/2)*2) ? 1 : 0;
	
/*  Kegelrad
    modul = Hoehe des Zahnkopfes ueber dem Teilkegel; Angabe fuer die Aussenseite des Kegels
    zahnzahl = Anzahl der Radzaehne
    teilkegelwinkel = (Halb)winkel des Kegels, auf dem das jeweils andere Hohlrad abrollt
    zahnbreite = Breite der Zaehne von der Aussenseite in Richtung Kegelspitze
    bohrung = Durchmesser der Mittelbohrung
    eingriffswinkel = Eingriffswinkel, Standardwert = 20 grad gemaess DIN 867
	schraegungswinkel = Schraegungswinkel, Standardwert = 0 grad */
module kegelrad(modul, zahnzahl, teilkegelwinkel, zahnbreite, bohrung, eingriffswinkel = 20, schraegungswinkel=0) {

	// Dimensions-Berechnungen
	d_aussen = modul * zahnzahl;									// Teilkegeldurchmesser auf der Kegelgrundflaeche,
																	// entspricht der Sehne im Kugelschnitt
	r_aussen = d_aussen / 2;										// Teilkegelradius auf der Kegelgrundflaeche 
	rg_aussen = r_aussen/sin(teilkegelwinkel);						// Grosskegelradius fuer Zahn-Aussenseite, entspricht der Laenge der Kegelflanke;
	rg_innen = rg_aussen - zahnbreite;								// Grosskegelradius fuer Zahn-Innenseite	
	r_innen = r_aussen*rg_innen/rg_aussen;
	alpha_stirn = atan(tan(eingriffswinkel)/cos(schraegungswinkel));// Schraegungswinkel im Stirnschnitt
	delta_b = asin(cos(alpha_stirn)*sin(teilkegelwinkel));			// Grundkegelwinkel		
	da_aussen = (modul <1)? d_aussen + (modul * 2.2) * cos(teilkegelwinkel): d_aussen + modul * 2 * cos(teilkegelwinkel);
	ra_aussen = da_aussen / 2;
	delta_a = asin(ra_aussen/rg_aussen);
	c = modul / 6;													// Kopfspiel
	df_aussen = d_aussen - (modul +c) * 2 * cos(teilkegelwinkel);
	rf_aussen = df_aussen / 2;
	delta_f = asin(rf_aussen/rg_aussen);
	rkf = rg_aussen*sin(delta_f);									// Radius des Kegelfusses
	hoehe_f = rg_aussen*cos(delta_f);								// Hoehe des Kegels vom Fusskegel
	
	echo("Teilkegeldurchmesser auf der Kegelgrundflaeche = ", d_aussen);
	
	// Groessen fuer Komplementaer-Kegelstumpf
	hoehe_k = (rg_aussen-zahnbreite)/cos(teilkegelwinkel);			// Hoehe des Komplementaerkegels fuer richtige Zahnlaenge
	rk = (rg_aussen-zahnbreite)/sin(teilkegelwinkel);				// Fussradius des Komplementaerkegels
	rfk = rk*hoehe_k*tan(delta_f)/(rk+hoehe_k*tan(delta_f));		// Kopfradius des Zylinders fuer 
																	// Komplementaer-Kegelstumpf
	hoehe_fk = rk*hoehe_k/(hoehe_k*tan(delta_f)+rk);				// Hoehe des Komplementaer-Kegelstumpfs

	echo("Hoehe Kegelrad = ", hoehe_f-hoehe_fk);
	
	phi_r = kugelev(delta_b, teilkegelwinkel);						// Winkel zum Punkt der Evolvente auf Teilkegel
		
	// Torsionswinkel gamma aus Schraegungswinkel
	gamma_g = 2*atan(zahnbreite*tan(schraegungswinkel)/(2*rg_aussen-zahnbreite));
	gamma = 2*asin(rg_aussen/r_aussen*sin(gamma_g/2));
	
	schritt = (delta_a - delta_b)/16;
	tau = 360/zahnzahl;												// Teilungswinkel
	start = (delta_b > delta_f) ? delta_b : delta_f;
	spiegelpunkt = (180*(1-spiel))/zahnzahl+2*phi_r;

	// Zeichnung
	rotate([0,0,phi_r+90*(1-spiel)/zahnzahl]){						// Zahn auf x-Achse zentrieren;
																	// macht Ausrichtung mit anderen Raedern einfacher
		translate([0,0,hoehe_f]) rotate(a=[0,180,0]){
			union(){
				translate([0,0,hoehe_f]) rotate(a=[0,180,0]){								// Kegelstumpf							
					difference(){
						linear_extrude(height=hoehe_f-hoehe_fk, scale=rfk/rkf) circle(rkf*1.001); // 1 promille Ueberlappung mit Zahnfuss
						translate([0,0,-1]){
							cylinder(h = hoehe_f-hoehe_fk+2, r = bohrung/2);				// Bohrung
						}
					}	
				}
				for (rot = [0:tau:360]){
					rotate (rot) {															// "Zahnzahl-mal" kopieren und drehen
						hull() union(){
							if (delta_b > delta_f){
								// Zahnfuss
								flankenpunkt_unten = 1*spiegelpunkt;
								flankenpunkt_oben = kugelev(delta_f, start);
								polyhedron(
									points = [
										kugel_zu_kart([rg_aussen, start*1.001, flankenpunkt_unten]),	// 1 promille ueberlappung mit Zahn
										kugel_zu_kart([rg_innen, start*1.001, flankenpunkt_unten+gamma]),
										kugel_zu_kart([rg_innen, start*1.001, spiegelpunkt-flankenpunkt_unten+gamma]),
										kugel_zu_kart([rg_aussen, start*1.001, spiegelpunkt-flankenpunkt_unten]),								
										kugel_zu_kart([rg_aussen, delta_f, flankenpunkt_unten]),
										kugel_zu_kart([rg_innen, delta_f, flankenpunkt_unten+gamma]),
										kugel_zu_kart([rg_innen, delta_f, spiegelpunkt-flankenpunkt_unten+gamma]),
										kugel_zu_kart([rg_aussen, delta_f, spiegelpunkt-flankenpunkt_unten])								
									],
									faces = [[0,1,2],[0,2,3],[0,4,1],[1,4,5],[1,5,2],[2,5,6],[2,6,3],[3,6,7],[0,3,7],[0,7,4],[4,6,5],[4,7,6]],
									convexity =1
								);
							}
							// Zahn
							for (delta = [start:schritt:delta_a-schritt]){
								flankenpunkt_unten = kugelev(delta_b, delta);
								flankenpunkt_oben = kugelev(delta_b, delta+schritt);
								polyhedron(
									points = [
										kugel_zu_kart([rg_aussen, delta, flankenpunkt_unten]),
										kugel_zu_kart([rg_innen, delta, flankenpunkt_unten+gamma]),
										kugel_zu_kart([rg_innen, delta, spiegelpunkt-flankenpunkt_unten+gamma]),
										kugel_zu_kart([rg_aussen, delta, spiegelpunkt-flankenpunkt_unten]),								
										kugel_zu_kart([rg_aussen, delta+schritt, flankenpunkt_oben]),
										kugel_zu_kart([rg_innen, delta+schritt, flankenpunkt_oben+gamma]),
										kugel_zu_kart([rg_innen, delta+schritt, spiegelpunkt-flankenpunkt_oben+gamma]),
										kugel_zu_kart([rg_aussen, delta+schritt, spiegelpunkt-flankenpunkt_oben])									
									],
									faces = [[0,1,2],[0,2,3],[0,4,1],[1,4,5],[1,5,2],[2,5,6],[2,6,3],[3,6,7],[0,3,7],[0,7,4],[4,6,5],[4,7,6]],
									convexity =1
								);
							}
						}
					}
				}	
			}
		}
	}
}

/*  Pfeil-Kegelrad; verwendet das Modul "kegelrad"
    modul = Hoehe des Zahnkopfes ueber dem Teilkreis
    zahnzahl = Anzahl der Radzaehne
    hoehe = Hoehe des Zahnrads
    bohrung = Durchmesser der Mittelbohrung
    eingriffswinkel = Eingriffswinkel, Standardwert = 20 grad gemaess DIN 867
    schraegungswinkel = Schraegungswinkel, Standardwert = 0 grad */
module pfeilkegelrad(modul, zahnzahl, teilkegelwinkel, zahnbreite, bohrung, eingriffswinkel = 20, schraegungswinkel=0,big=1){

	// Dimensions-Berechnungen
	
	zahnbreite = zahnbreite / 2;
	
	d_aussen = modul * zahnzahl;								// Teilkegeldurchmesser auf der Kegelgrundflaeche,
																// entspricht der Sehne im Kugelschnitt
	r_aussen = d_aussen / 2;									// Teilkegelradius auf der Kegelgrundflaeche 
	rg_aussen = r_aussen/sin(teilkegelwinkel);					// Grosskegelradius, entspricht der Laenge der Kegelflanke;
	c = modul / 6;												// Kopfspiel
	df_aussen = d_aussen - (modul +c) * 2 * cos(teilkegelwinkel);
	rf_aussen = df_aussen / 2;
	delta_f = asin(rf_aussen/rg_aussen);
	hoehe_f = rg_aussen*cos(delta_f);							// Hoehe des Kegels vom Fusskegel

	// Torsionswinkel gamma aus Schraegungswinkel
	gamma_g = 2*atan(zahnbreite*tan(schraegungswinkel)/(2*rg_aussen-zahnbreite));
	gamma = 2*asin(rg_aussen/r_aussen*sin(gamma_g/2));
	
	echo("Teilkegeldurchmesser auf der Kegelgrundflaeche = ", d_aussen);
	
	// Groessen fuer Komplementaer-Kegelstumpf
	hoehe_k = (rg_aussen-zahnbreite)/cos(teilkegelwinkel);		// Hoehe des Komplementaerkegels fuer richtige Zahnlaenge
	rk = (rg_aussen-zahnbreite)/sin(teilkegelwinkel);			// Fussradius des Komplementaerkegels
	rfk = rk*hoehe_k*tan(delta_f)/(rk+hoehe_k*tan(delta_f));	// Kopfradius des Zylinders fuer 
																// Komplementaer-Kegelstumpf
	hoehe_fk = rk*hoehe_k/(hoehe_k*tan(delta_f)+rk);			// Hoehe des Komplementaer-Kegelstumpfs
	
	modul_innen = modul*(1-zahnbreite/rg_aussen);

  difference() {
		union(){
      if(!big) cylinder(d=10,h=16.8,$fn=50);
      kegelrad(modul, zahnzahl, teilkegelwinkel, zahnbreite, bohrung, eingriffswinkel, schraegungswinkel);		// untere Haelfte
      translate([0,0,hoehe_f-hoehe_fk])
        rotate(a=-gamma,v=[0,0,1])
          kegelrad(modul_innen, zahnzahl, teilkegelwinkel, zahnbreite, bohrung, eingriffswinkel, -schraegungswinkel);	// obere Haelfte
      if(!big)
      translate([-4,2,9.8]) cube([8,5,7]);
    }
    if(!big)
    {
      translate([0,0,-.01]) linear_extrude(30) difference() {
        circle(d=5.4,h=30,$fn=30);
        translate([-3,2]) square([6,1]);
      }
      translate([-3,3,9.8]) cube([6,3,10]);
      translate([0,0,13]) rotate([-90,0]) cylinder(d=3,h=20,$fn=20);
    }
  }
}


/*	Pfeil-Kegelradpaar mit beliebigem Achsenwinkel; verwendet das Modul "pfeilkegelrad"
    modul = Hoehe des Zahnkopfes ueber dem Teilkegel; Angabe fuer die Aussenseite des Kegels
    zahnzahl_rad = Anzahl der Radzaehne am Rad
    zahnzahl_ritzel = Anzahl der Radzaehne am Ritzel
	achsenwinkel = Winkel zwischen den Achsen von Rad und Ritzel
    zahnbreite = Breite der Zaehne von der Aussenseite in Richtung Kegelspitze
    bohrung_rad = Durchmesser der Mittelbohrung des Rads
    bohrung_ritzel = Durchmesser der Mittelbohrungen des Ritzels
    eingriffswinkel = Eingriffswinkel, Standardwert = 20 grad gemaess DIN 867
    schraegungswinkel = Schraegungswinkel, Standardwert = 0 grad */
module pfeilkegelradpaar(modul, zahnzahl_rad, zahnzahl_ritzel, achsenwinkel=90, zahnbreite, bohrung_rad, bohrung_ritzel, eingriffswinkel = 20, schraegungswinkel=10, zusammen_gebaut=1){
 
	r_rad = modul*zahnzahl_rad/2;							// Teilkegelradius des Rads
	delta_rad = atan(sin(achsenwinkel)/(zahnzahl_ritzel/zahnzahl_rad+cos(achsenwinkel)));	// Kegelwinkel des Rads
	delta_ritzel = atan(sin(achsenwinkel)/(zahnzahl_rad/zahnzahl_ritzel+cos(achsenwinkel)));// Kegelwingel des Ritzels
	rg = r_rad/sin(delta_rad);								// Radius der Grosskugel
	c = modul / 6;											// Kopfspiel
	df_ritzel = 4*pi*rg*delta_ritzel/360 - 2 * (modul + c);	// Fusskegeldurchmesser auf der Grosskugel 
	rf_ritzel = df_ritzel / 2;								// Fusskegelradius auf der Grosskugel
	delta_f_ritzel = rf_ritzel/(2*pi*rg) * 360;				// Kopfkegelwinkel
	rkf_ritzel = rg*sin(delta_f_ritzel);					// Radius des Kegelfusses
	hoehe_f_ritzel = rg*cos(delta_f_ritzel);				// Hoehe des Kegels vom Fusskegel
	
	echo("Kegelwinkel Rad = ", delta_rad);
	echo("Kegelwinkel Ritzel = ", delta_ritzel);
 
	df_rad = 4*pi*rg*delta_rad/360 - 2 * (modul + c);		// Fusskegeldurchmesser auf der Grosskugel 
	rf_rad = df_rad / 2;									// Fusskegelradius auf der Grosskugel
	delta_f_rad = rf_rad/(2*pi*rg) * 360;					// Kopfkegelwinkel
	rkf_rad = rg*sin(delta_f_rad);							// Radius des Kegelfusses
	hoehe_f_rad = rg*cos(delta_f_rad);						// Hoehe des Kegels vom Fusskegel

	echo("Hoehe Rad = ", hoehe_f_rad);
	echo("Hoehe Ritzel = ", hoehe_f_ritzel);
	
	drehen = istgerade(zahnzahl_ritzel);
	
	// Rad
	if(zusammen_gebaut >= 1) difference() {
    union() {
      cylinder(d=hex_head_diameter(inches(5/16))+8,h=9.99,$fn=80);
    rotate([0,0,180*(1-spiel)/zahnzahl_rad*drehen])
      pfeilkegelrad(modul, zahnzahl_rad, delta_rad, zahnbreite, bohrung_rad, eingriffswinkel, schraegungswinkel);
    mirror([0,0,1]) 
      cylinder(d=zahnzahl_rad*2,h=4,$fn=100);
    }
    translate([0,0,-4.01]) cylinder(d=inches(5/16)+.4,h=20,$fn=40);
    translate([0,0,2]) cylinder(d=hex_head_diameter(inches(5/16))+.4,h=8,$fn=6);
    for(r=[0:360/5:359]) rotate([0,0,r]) translate([zahnzahl_rad/2,0,-5]) cylinder(d=25.4,h=20,$fn=50);
  }
	
	// Ritzel
	//rotate([0,-90,0])
  if(zusammen_gebaut <= 1) intersection() { translate([0,0,1.5]) cylinder(d=100,h=20,$fn=80);
    if (zusammen_gebaut == 1)
		translate([-hoehe_f_ritzel*cos(90-achsenwinkel),0,hoehe_f_rad-hoehe_f_ritzel*sin(90-achsenwinkel)])
			rotate([0,achsenwinkel,0])
				pfeilkegelrad(modul, zahnzahl_ritzel, delta_ritzel, zahnbreite, bohrung_ritzel, eingriffswinkel, -schraegungswinkel, big=0);
	else
  {
		//translate([rkf_ritzel*2+modul+rkf_rad,0,0])
			pfeilkegelrad(modul, zahnzahl_ritzel, delta_ritzel, zahnbreite, bohrung_ritzel, eingriffswinkel, -schraegungswinkel, big=0);
  }
}

}

pfeilkegelradpaar(modul, zahnzahl_rad, zahnzahl_ritzel, achsenwinkel, zahnbreite, bohrung_rad, bohrung_ritzel, eingriffswinkel, schraegungswinkel, zusammen_gebaut);

function inches(mm) = 25.4 * mm;
function hex_head_diameter(bolt_diameter) = (bolt_diameter==5?9.1:((bolt_diameter*(bolt_diameter<inches(5/16)?1.75:(bolt_diameter<inches(3/8)?1.6:1.5)))/cos(30)));
function next_prime(num) = num<=3?3:(num<=5?5:(num<=7?7:(num<=11?11:(num<=13?13:(num<=17?17:(num<=19?19:(num<=23?23:(num<=29?29:(num<=31?31:(num<=37?37:(num<=41?41:(num<=43?43:(num<=47?47:(num<=53?53:(num<=59?59:(num<=61?61:(num<=67?67:(num<=71?71:(num<=73?73:(num<=79?79:(num<=83?83:(num<=89?89:97))))))))))))))))))))));