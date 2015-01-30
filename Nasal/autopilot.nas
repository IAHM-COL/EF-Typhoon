### Autopilot Modes


## Initialise Nodes

props.globals.initNode("autopilot/settings/allow-reheat", 0, "BOOL");

## Safety Settings for Autopilot

var startHDG = getprop("orientation/heading-deg");
setprop("autopilot/settings/heading-bug-deg", startHDG);
setprop("autopilot/settings/ind-target-altitude-ft", 4000);
setprop("autopilot/settings/target-agl-ft", 1000);
setprop("autopilot/settings/target-pitch-deg", 0);
setprop("autopilot/settings/target-roll-deg", 0);
setprop("autopilot/settings/target-speed-kt", 350);
setprop("autopilot/settings/target-speed-mach", 1.2);
setprop("autopilot/settings/true-heading-deg", startHDG);
setprop("autopilot/settings/kts-mach-select", "kts");

## Common AP Variables

## Basic Functions
var apCancel = func {
setprop("autopilot/locks/heading", "");
setprop("autopilot/locks/altitude", "");
}

var panic = func {
setprop("autopilot/settings/target-roll-deg", "0");
setprop("autopilot/locks/heading", "roll-hold");
setprop("autopilot/settings/target-pitch-deg", "0");
setprop("autopilot/locks/heading", "pitch-hold");
}

## AP Dialog Functions

var ATselKts = func {
setprop("autopilot/settings/kts-mach-select", "kts");
}

var ATselMach = func {
setprop("autopilot/settings/kts-mach-select", "mach");
}

## Auto Climb

var autoclimb = func {
   var crtAlt = getprop("position/altitude-ft");
   var tgtAlt = getprop("autopilot/settings/target-altitude-ft");
   if (crtAlt = tgtAlt) {
      setprop("autopilot/locks/altitude", "altitude-hold");
	  setprop("autopilot/locks/speed", "");
	  }
   else {
      setprop("autopilot/locks/altitude", "auto-climb");
	  setprop("autopilot/locks/speed", "");
      }
   settimer(autoclimb, 1);
}

var aclmSelect = func {
   var crtAlt = getprop("position/altitude-ft");
   var tgtAlt = getprop("autopilot/settings/target-altitude-ft");
   var reheat = getprop("autopilot/settings/autoclimb/allow-reheat");
   var currentKTS = getprop("velocities/airspeed-kt");
   if ((tgtAlt - crtAlt) > 5000) {
      setprop("autopilot/settings/target-speed-kt", currentKTS);
      setprop("autopilot/locks/speed", "speed-with-reheat");
	  setprop("autopilot/locks/altitude", "auto-climb");
	  autoclimb();
	  }
   else  {
      setprop("autopilot/locks/altitude", "altitude-hold");
	  }
}

var autoTO = func {
   var crtHdg = getprop("orientation/heading-deg");
   var crtAgl = getprop("position/altitude-agl-ft");
   if ( crtAgl <= 10 )  {
      setprop("autopilot/settings/heading-bug-deg", crtHdg);
	  setprop("autopilot/locks/heading", "auto-accel");
	  setprop("autopilot/locks/altitude", "auto-climb");
	  setprop("autopilot/locks/speed", "speed-with-reheat");
	  }
   else
      {
	  }
};