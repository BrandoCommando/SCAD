include <Thread_Library.scad>

$fs=0.75;$fa=5;

// What to print

WhatToPrint = 1;
// 1: Lid part
// 2: Hose barb disk part
// 3: Both of them

// Global parameters

ExtDiameter = 32;
TotalHeight = 11.5;
TopWall=1.5;

// Hose barbs parameters

HoseBarbDiskHeight = 1;
HoseBarbTotalHeight = 9;
HoseBarbDiameter = 6;
HoseBarbInnerDiameter = 4;
HoseBarbOffset = 6;

// Thread parameters

ThreadOuterDiameter=27.7; 
ThreadInnerDiameter=26.0; // Used only for cleanup.
ThreadPitch=2.7;
ToothHeight=1.35;
ProfileRatio=0.4;
ThreadAngle=20;

// Conical seals parameters

BottleEdgeInnerDiameter = 22.0;
BottleEdgeExternalDiameter = 24.7;
ConicalSealHeight = 3;


//cubesize=35;

!Nozzle();
if ( WhatToPrint == 1)
	LidWithHoseBarbsPart();
if ( WhatToPrint == 2)
	DiskWithHoseBarbsPart();
if ( WhatToPrint == 3)
	{
	translate ([-ExtDiameter/2-3,0,0]) LidWithHoseBarbsPart();
	translate ([ExtDiameter/2+3,0,0]) DiskWithHoseBarbsPart();
	}

	
module Nozzle()
{
  mentosd=21;
  shafth=40;
  !Lid();
  mirror([0,0,1]) difference() {
    union() {
      cylinder(d=mentosd+4,h=shafth,$fn=50);
      translate([0,0,-1]) cylinder(d1=32,d2=mentosd+4,h=6,$fn=50);
      translate([0,0,shafth]) cylinder(d1=mentosd+4,d2=12,h=16,$fn=50);
    }
    translate([0,0,-1.01]) cylinder(d=mentosd,h=shafth+1.04,$fn=50);
    translate([0,0,shafth]) cylinder(d1=mentosd,d2=6,h=16.04,$fn=30);
    translate([20,0,2]) rotate([0,-90,0]) cylinder(d=2,h=30,$fn=20);
  }
}	
module LidWithHoseBarbsPart()	
{
difference ()
	{
	union ()
		{
		Lid();
		translate([HoseBarbOffset,0,0]) cylinder(r=HoseBarbDiameter/2, h=TotalHeight); // Hose barbs
		translate([-HoseBarbOffset,0,-0]) cylinder(r=HoseBarbDiameter/2, h=TotalHeight);
		}
		//Hose barbs holes
	
	translate([HoseBarbOffset,0,-1]) cylinder(r=HoseBarbInnerDiameter/2, h=TotalHeight+2);
	translate([-HoseBarbOffset,0,-1]) cylinder(r=HoseBarbInnerDiameter/2, h=TotalHeight+2);
	}
}
	
module Lid()
{
difference()
	{
	union()
		{
			
		cylinder( r1=ExtDiameter/2-0.7, r2=ExtDiameter/2, h=1); // Facet
		translate ([0,0,1])
			cylinder( r=ExtDiameter/2, h=TotalHeight-1); // Master part
		}

	*for ( angle = [0:20:360] ) // Reefing on the side
		rotate ([0,0,angle])
			translate ([ExtDiameter/2,0,TotalHeight/2-3])
				cube ([1,2,TotalHeight], center=true);

	translate([0,0,TopWall]) cylinder( r=ThreadInnerDiameter/2, h=TotalHeight);
	translate([0,0,TotalHeight-2.0]) cylinder( r1=ThreadInnerDiameter/2, r2=ThreadOuterDiameter/2+0.5, h=2.1); //Thread facet
	//translate([0,0,TotalHeight-1.5]) cylinder( r1=ThreadOuterDiameter/2, r2=ThreadInnerDiameter/2, h=1.5); //Thread facet
	
	// Most important thing -- thread
	
	translate([0,0,ThreadPitch+TopWall])
		//trapezoidThread
		trapezoidThreadNegativeSpace
		(
			length=TotalHeight,
			pitch=ThreadPitch,
			pitchRadius=ThreadOuterDiameter/2,
			threadHeightToPitch=ToothHeight/ThreadPitch,
			profileRatio=ProfileRatio,
			threadAngle=ThreadAngle, 
			clearance=0.1,
			backlash=0.1
		);
    translate([0,0,-.01]) cylinder(d=21,h=2,$fn=40);
	}

	// Internal conical ring (O-ring and bottle neck edge will be between conical rings)
	*translate([0,0,1.5-0.01])
		difference ()
			{
			cylinder( r1=(BottleEdgeInnerDiameter+ConicalSealHeight/4)/2, r2=(BottleEdgeInnerDiameter-ConicalSealHeight/4)/2, h=ConicalSealHeight);
			translate([0,0,-0.5])
				cylinder( r=(BottleEdgeInnerDiameter-ConicalSealHeight)/2, h=ConicalSealHeight+1);
			}
	// External conical ring 
	translate([0,0,1.5-0.01])
		difference ()
			{
			cylinder( r=ThreadOuterDiameter/2, h=2);			
			translate([0,0,-0.5])
				cylinder( r1=(BottleEdgeExternalDiameter-ConicalSealHeight/4)/2, r2=(BottleEdgeExternalDiameter+ConicalSealHeight/4)/2, h=ConicalSealHeight);

			}
}

module DiskWithHoseBarbsPart ()
{
difference()
	{
	union ()
		{
		cylinder( r1=ExtDiameter/2-0.7, r2= ExtDiameter/2-0.7-0.7*HoseBarbDiskHeight, h=HoseBarbDiskHeight);

		translate([6,0,0]) cylinder(r1=3, r2=3, h=HoseBarbTotalHeight);
		
		translate([-6,0,-0]) cylinder(r=HoseBarbDiameter/2, h=HoseBarbTotalHeight);
		}
	translate([-6,0,-1]) cylinder(r=HoseBarbInnerDiameter/2, h=HoseBarbTotalHeight+2);
	translate([6,0,-1]) cylinder(r=HoseBarbInnerDiameter/2, h=HoseBarbTotalHeight+2);
	}
}