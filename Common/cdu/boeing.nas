var i = 0;
var pagenum=1;
var pageact=1;

var input = func(v) {
	setprop("/instrumentation/cdu/input", getprop("/instrumentation/cdu/input")~v);
}
	
var key = func(v) {
	var cduDisplay = getprop("/instrumentation/cdu/display");
	var serviceable = getprop("/instrumentation/cdu/serviceable");
	var eicasDisplay = getprop("/instrumentation/eicas/display");
	var cduInput = getprop("/instrumentation/cdu/input");
		
	if (serviceable == 1){
		if (v == "LSK1L"){
			if (cduDisplay == "DEP_ARR_INDEX"){
				cduDisplay = "RTE1_DEP";
			}
			if (cduDisplay == "EICAS_MODES"){
				eicasDisplay = "ENG";
			}
			if (cduDisplay == "EICAS_SYN"){
				eicasDisplay = "ELEC";
			}
			if (cduDisplay == "INIT_REF"){
				cduDisplay = "IDENT";
			}
			if (cduDisplay == "NAV_RAD"){
				setprop("/instrumentation/nav[0]/frequencies/selected-mhz",cduInput);
				cduInput = "";
			}
			if (cduDisplay == "RTE1_1"){
				setprop("/autopilot/route-manager/departure/airport",cduInput);
				cduInput = "";
			}
			if (cduDisplay == "RTE1_LEGS"){
				var wp=pageact-2;
				wp=wp*5;
				wp=wp+1;
				if (cduInput == "DELETE"){
					setprop("/autopilot/route-manager/input","@DELETE"~wp);
					cduInput = "";
				}
				else{
					setprop("/autopilot/route-manager/input","@INSERT"~wp~":"~cduInput);
				}
			}
			if (cduDisplay == "TO_REF"){
				setprop("/instrumentation/fmc/to-flap",cduInput);
				cduInput = "";
			}
			if (cduDisplay == "EFIS_CP") {
				var found="false";
				var done=0;
				if (num(cduInput) != nil) {
					done=cduInput+0;
				}
				if (done >= 22.00) {
					if (done <= 32.00) {
						setprop("/instrumentation/altimeter/setting-inhg", cduInput);
						setprop("/instrumentation/cdu/altitude_inhg", "true");
						found="true";
					}
				}
				if (found == "false") {
					if (done >= 2200) {
						if (done <= 3200) {
							setprop("/instrumentation/altimeter/setting-inhg", cduInput/100);
							setprop("/instrumentation/cdu/altitude_inhg", "true");
							found="true";
						}
					}
				}
				if (found == "false") {
					if (done >= 745) {
						if (done <= 1084) {
							setprop("/instrumentation/altimeter/setting-hpa", cduInput);
							setprop("/instrumentation/cdu/altitude_inhg", "false");
							found="true";
						}
					}
				}
				if (found == "false") {
					if (cduInput=="I") {
						setprop("/instrumentation/cdu/altitude_inhg", "true");
					}
					if (cduInput=="H") {
						setprop("/instrumentation/cdu/altitude_inhg", "false");
					}
					found="true";
				}
				cduInput = "";
			}
		}

		if (v == "LSK1R"){
			if (cduDisplay == "MENU") {
				cduDisplay = "EFIS_CP";
			}
			if (cduDisplay == "EICAS_MODES") {
				eicasDisplay = "FUEL";
			}
			if (cduDisplay == "EICAS_SYN") {
				eicasDisplay = "HYD";
			}
			if (cduDisplay == "NAV_RAD") {
				setprop("/instrumentation/nav[1]/frequencies/selected-mhz",cduInput);
				cduInput = "";
			}
			if (cduDisplay == "RTE1_1") {
				setprop("/autopilot/route-manager/destination/airport",cduInput);
				cduInput = "";
			}
			if (cduDisplay == "RTE1_LEGS") {
				setprop("/autopilot/route-manager/route/wp[1]/altitude-ft",cduInput);
				if (substr(cduInput,0,2) == "FL"){
					setprop("/autopilot/route-manager/route/wp[1]/altitude-ft",substr(cduInput,2)*100);
				}
				cduInput = "";
			}
			if (cduDisplay == "RTE1_2"){
				var wp=pageact-2;
				wp=wp*5;
				wp=wp+1;
				if (cduInput == "DELETE"){
					setprop("/autopilot/route-manager/input","@DELETE"~wp);
					cduInput = "";
				}
				else{
					setprop("/autopilot/route-manager/input","@INSERT"~wp~":"~cduInput);
				}
			}
		}

		if (v == "LSK2L"){
			if (cduDisplay == "EICAS_MODES"){
				eicasDisplay = "STAT";
			}
			if (cduDisplay == "EICAS_SYN"){
				eicasDisplay = "ECS";
			}
			if (cduDisplay == "NAV_RAD") {
				setprop("/instrumentation/nav[0]/radials/selected-deg",cduInput);
				cduInput = "";
			}
			if (cduDisplay == "POS_INIT"){
				setprop("/instrumentation/fmc/ref-airport",cduInput);
				cduInput = "";
			}
			if (cduDisplay == "INIT_REF"){
				cduDisplay = "POS_INIT";
			}
			if (cduDisplay == "RTE1_1"){
				setprop("/autopilot/route-manager/departure/runway",cduInput);
				cduInput = "";;
			}
			if (cduDisplay == "RTE1_LEGS"){
				if (cduInput == "DELETE"){
					setprop("/autopilot/route-manager/input","@DELETE2");
					cduInput = "";
				}
				else{
					setprop("/autopilot/route-manager/input","@INSERT3:"~cduInput);
				}
			}
		}

		if (v == "LSK2R"){
			if (cduDisplay == "DEP_ARR_INDEX") {
				cduDisplay = "RTE1_ARR";
			}
			if (cduDisplay == "EICAS_MODES") {
				eicasDisplay = "GEAR";
			}
			if (cduDisplay == "EICAS_SYN") {
				eicasDisplay = "DRS";
			}
			if (cduDisplay == "NAV_RAD") {
				setprop("/instrumentation/nav[1]/radials/selected-deg",cduInput);
				cduInput = "";
			}
			if (cduDisplay == "MENU") {
				eicasDisplay = "EICAS_MODES";
			}
			if (cduDisplay == "RTE1_LEGS") {
				var wp=pageact-2;
				wp=wp*5;
				wp=wp+2;
				if (cduInput == "DELETE"){
					setprop("/autopilot/route-manager/input","@DELETE"~wp);
					cduInput = "";
				}
				else{
					setprop("/autopilot/route-manager/input","@INSERT"~wp~":"~cduInput);
				}
			}
			if (cduDisplay == "RTE1_1") {
				setprop("/instrumentation/cdu/flight-no", cduInput);
				cduInput = "";
			}
			if (cduDisplay == "RTE1_2"){
				var wp=pageact-2;
				wp=wp*5;
				wp=wp+2;
				if (cduInput == "DELETE"){
					setprop("/autopilot/route-manager/input","@DELETE"~wp);
					cduInput = "";
				}
				else{
					setprop("/autopilot/route-manager/input","@INSERT"~wp~":"~cduInput);
				}
			}
		}

		if (v == "LSK3L"){
			if (cduDisplay == "INIT_REF"){
				cduDisplay = "PERF_INIT";
			}
			if (cduDisplay == "RTE1_LEGS"){
				if (cduInput == "DELETE"){
					setprop("/autopilot/route-manager/input","@DELETE3");
					cduInput = "";
				}
				else{
					setprop("/autopilot/route-manager/input","@INSERT4:"~cduInput);
				}
			}
		}

		if (v == "LSK3R"){
			if (cduDisplay == "RTE1_LEGS"){
				setprop("/autopilot/route-manager/route/wp[3]/altitude-ft",cduInput);
				if (substr(cduInput,0,2) == "FL"){
					setprop("/autopilot/route-manager/route/wp[3]/altitude-ft",substr(cduInput,2)*100);
				}
				cduInput = "";
			}
			if (cduDisplay == "RTE1_2"){
				var wp=pageact-2;
				wp=wp*5;
				wp=wp+3;
print("3R=", wp, " cdu=", cduInput);
				if (cduInput == "DELETE"){
					setprop("/autopilot/route-manager/input","@DELETE"~wp);
					cduInput = "";
				}
				else{
					setprop("/autopilot/route-manager/input","@INSERT"~wp~":"~cduInput);
				}
			}
		}
		if (v == "LSK4L"){
			if (cduDisplay == "INIT_REF"){
				cduDisplay = "THR_LIM";
			}
			if (cduDisplay == "RTE1_LEGS"){
				if (cduInput == "DELETE"){
					setprop("/autopilot/route-manager/input","@DELETE4");
					cduInput = "";
				}
				else{
					setprop("/autopilot/route-manager/input","@INSERT5:"~cduInput);
				}
			}
			if (cduDisplay == "NAV_RAD") {
				setprop("/instrumentation/adf[0]/frequencies/selected-khz",cduInput);
				cduInput = "";
			}
		}

		if (v == "LSK4R"){
			if (cduDisplay == "RTE1_LEGS"){
				setprop("/autopilot/route-manager/route/wp[4]/altitude-ft",cduInput);
				if (substr(cduInput,0,2) == "FL"){
					setprop("/autopilot/route-manager/route/wp[4]/altitude-ft",substr(cduInput,2)*100);
				}
				cduInput = "";
			}
			if (cduDisplay == "RTE1_2"){
				var wp=pageact-2;
				wp=wp*5;
				wp=wp+4;
				if (cduInput == "DELETE"){
					setprop("/autopilot/route-manager/input","@DELETE"~wp);
					cduInput = "";
				}
				else{
					setprop("/autopilot/route-manager/input","@INSERT"~wp~":"~cduInput);
				}
			}
			if (cduDisplay == "NAV_RAD") {
				setprop("/instrumentation/adf[1]/frequencies/selected-khz",cduInput);
				cduInput = "";
			}
		}

		if (v == "LSK5L"){
			if (cduDisplay == "INIT_REF"){
				cduDisplay = "TO_REF";
			}
			if (cduDisplay == "RTE1_LEGS"){
				if (cduInput == "DELETE"){
					setprop("/autopilot/route-manager/input","@DELETE5");
					cduInput = "";
				}
				else{
					setprop("/autopilot/route-manager/input","@INSERT6:"~cduInput);
				}
			}
		}
		if (v == "LSK5R"){
			if (cduDisplay == "RTE1_LEGS"){
				setprop("/autopilot/route-manager/route/wp[5]/altitude-ft",cduInput);
				if (substr(cduInput,0,2) == "FL"){
					setprop("/autopilot/route-manager/route/wp[5]/altitude-ft",substr(cduInput,2)*100);
				}
				cduInput = "";
			}
			if (cduDisplay == "RTE1_2"){
				var wp=pageact-2;
				wp=wp*5;
				wp=wp+5;
				if (cduInput == "DELETE"){
					setprop("/autopilot/route-manager/input","@DELETE"~wp);
					cduInput = "";
				}
				else{
					setprop("/autopilot/route-manager/input","@INSERT"~wp~":"~cduInput);
				}
			}
		}

		if (v == "LSK6L"){
			if (cduDisplay == "INIT_REF"){
				cduDisplay = "APP_REF";
			}
			if (cduDisplay == "APP_REF"){
				cduDisplay = "INIT_REF";
			}
			if ((cduDisplay == "IDENT") or (cduDisplay = "MAINT") or (cduDisplay = "PERF_INIT") or (cduDisplay = "POS_INIT") or (cduDisplay = "POS_REF") or 				(cduDisplay = "THR_LIM") or (cduDisplay = "TO_REF")){
				cduDisplay = "INIT_REF";
			}
		}

		if (v == "LSK6R"){
			if (cduDisplay == "THR_LIM"){
				cduDisplay = "TO_REF";
			}
			else if (cduDisplay == "APP_REF"){
				cduDisplay = "THR_LIM";
			}
			else if ((cduDisplay == "RTE1_1") or (cduDisplay == "RTE1_LEGS")){
				setprop("/autopilot/route-manager/input","@ACTIVATE");
			}
			else if ((cduDisplay == "POS_INIT") or (cduDisplay == "DEP") or (cduDisplay == "RTE1_ARR") or (cduDisplay == "RTE1_DEP")){
				cduDisplay = "RTE1_1";
			}
			else if ((cduDisplay == "IDENT") or (cduDisplay == "TO_REF")){
				cduDisplay = "POS_INIT";
			}
			else if (cduDisplay == "EICAS_SYN"){
				cduDisplay = "EICAS_MODES";
			}
			else if (cduDisplay == "EICAS_MODES"){
				cduDisplay = "EICAS_SYN";
			}
			else if (cduDisplay == "INIT_REF"){
				cduDisplay = "MAINT";
			}
		}
			
		setprop("/instrumentation/cdu/display",cduDisplay);
		if (eicasDisplay != nil){
			setprop("/instrumentation/eicas/display",eicasDisplay);
		}
		setprop("/instrumentation/cdu/input",cduInput);
	}
}
	
var delete = func {
	var length = size(getprop("/instrumentation/cdu/input")) - 1;
	setprop("/instrumentation/cdu/input",substr(getprop("/instrumentation/cdu/input"),0,length));
}

var plusminus = func {	
	var end = size(getprop("/instrumentation/cdu/input"));
	var start = end - 1;
	var lastchar = substr(getprop("/instrumentation/cdu/input"),start,end);
	if (lastchar == "+"){
		me.delete();
		me.input('-');
	}
	if (lastchar == "-"){
		me.delete();
		me.input('+');
	}
	if ((lastchar != "-") and (lastchar != "+")){
		me.input('+');
	}
}

var cdu = func{
	var display = getprop("/instrumentation/cdu/display");
	var serviceable = getprop("/instrumentation/cdu/serviceable");

	title = "";		page = "";
	line1l = "";	line2l = "";	line3l = "";	line4l = "";	line5l = "";	line6l = "";
	line1lt = "";	line2lt = "";	line3lt = "";	line4lt = "";	line5lt = "";	line6lt = "";
	line1c = "";	line2c = "";	line3c = "";	line4c = "";	line5c = "";	line6c = "";
	line1ct = "";	line2ct = "";	line3ct = "";	line4ct = "";	line5ct = "";	line6ct = "";
	line1r = "";	line2r = "";	line3r = "";	line4r = "";	line5r = "";	line6r = "";
	line1rt = "";	line2rt = "";	line3rt = "";	line4rt = "";	line5rt = "";	line6rt = "";

	pagenum=1;
	var counter=0;
	for (var l=1; l<getprop("autopilot/route-manager/route/num"); l=l+1) {
		counter=counter+1;
		if (counter==5) {
			counter=0;
			pagenum=pagenum+1;
		}
	}
	if (counter>0) {
		pagenum=pagenum+1;
	}
		
	if (display == "MENU") {
		title = "MENU";
		line1l = "<FMC";
		line1rt = "EFIS CP";
		line1r = "SELECT>";
		line2l = "<ACARS";
		line2rt = "EICAS CP";
		line2r = "SELECT>";
		line6l = "<ACMS";
		line6r = "CMC>";
	}

	if (display == "ALTN_NAV_RAD") {
		title = "ALTN NAV RADIO";
	}

	if (display == "APP_REF") {
		title = "APPROACH REF";
		line1lt = "GROSS WT";
		line1rt = "FLAPS    VREF";
		if (getprop("/instrumentation/fmc/vspeeds/Vref") != nil){
			line1l = getprop("/instrumentation/fmc/vspeeds/Vref");
		}
		if (getprop("/autopilot/route-manager/destination/airport") != nil){
			line4lt = getprop("/autopilot/route-manager/destination/airport");
		}
		line6l = "<INDEX";
		line6r = "THRUST LIM>";
	}

	if (display == "DEP_ARR_INDEX") {
		title = "DEP/ARR INDEX";
		line1l = "<DEP";
		line1ct = "RTE 1";
		if (getprop("/autopilot/route-manager/departure/airport") != nil){
			line1c = getprop("/autopilot/route-manager/departure/airport");
		}
		line1r = "ARR>";
		if (getprop("/autopilot/route-manager/destination/airport") != nil){
			line2c = getprop("/autopilot/route-manager/destination/airport");
		}
		line2r = "ARR>";
		line3l = "<DEP";
		line3r = "ARR>";
		line4r = "ARR>";
		line6lt ="DEP";
		line6l = "<----";
		line6c = "OTHER";
		line6rt ="ARR";
		line6r = "---->";
	}
	if (display == "EICAS_MODES") {
		title = "EICAS MODES";
		line1l = "<ENG";
		line1r = "FUEL>";
		line2l = "<STAT";
		line2r = "GEAR>";
		line5l = "<CANC";
		line5r = "RCL>";
		line6r = "SYNOPTICS>";
	}
	if (display == "EICAS_SYN") {
		title = "EICAS SYNOPTICS";
		line1l = "<ELEC";
		line1r = "HYD>";
		line2l = "<ECS";
		line2r = "DOORS>";
		line5l = "<CANC";
		line5r = "RCL>";
		line6r = "MODES>";
	}

	if (display == "FIX_INFO") {
		title = "FIX INFO";
		line1l = sprintf("%3.2f", getprop("/instrumentation/nav[0]/frequencies/selected-mhz-fmt"));
		line1r = sprintf("%3.2f", getprop("/instrumentation/nav[1]/frequencies/selected-mhz-fmt"));
		line2l = sprintf("%3.2f", getprop("/instrumentation/nav[0]/radials/selected-deg"));
		line2r = sprintf("%3.2f", getprop("/instrumentation/nav[1]/radials/selected-deg"));
		line6l = "<ERASE FIX";
	}

	if (display == "IDENT") {
		title = "IDENT";
		line1lt = "MODEL";
		if (getprop("/instrumentation/cdu/ident/model") != nil){
			line1l = getprop("/instrumentation/cdu/ident/model");
		}
		line1rt = "ENGINES";
		line2lt = "NAV DATA";
		if (getprop("/instrumentation/cdu/ident/engines") != nil){
			line1r = getprop("/instrumentation/cdu/ident/engines");
		}
		line6l = "<INDEX";
		line6r = "POS INIT>";
	}

	if (display == "INIT_REF") {
		title = "INIT/REF INDEX";
		line1l = "<IDENT";
		line1r = "NAV DATA>";
		line2l = "<POS";
		line3l = "<PERF";
		line4l = "<THRUST LIM";
		line5l = "<TAKEOFF";
		line6l = "<APPROACH";
		line6r = "MAINT>";
	}

	if (display == "MAINT") {
		title = "MAINTENANCE INDEX";
		line1l = "<CROS LOAD";
		line1r = "BITE>";
		line2l = "<PERF FACTORS";
		line3l = "<IRS MONITOR";
		line6l = "<INDEX";
	}

	if (display == "NAV_RAD") {
		title = "NAV RADIO";
		line1lt = "VOR L";
		line1l = sprintf("%3.2f", getprop("/instrumentation/nav[0]/frequencies/selected-mhz-fmt"));
		line1c = "VOR";
		line1rt = "VOR R";
		line1r = sprintf("%3.2f", getprop("/instrumentation/nav[1]/frequencies/selected-mhz-fmt"));
		line2lt = "CRS";
		line2ct = "RADIAL";
		line2rt = "CRS";
		line2l = sprintf("%3.2f", getprop("/instrumentation/nav[0]/radials/selected-deg"));
		line2r = sprintf("%3.2f", getprop("/instrumentation/nav[1]/radials/selected-deg"));
		line4lt = "CRS";
		line4c = "ADF";
		line4rt = "CRS";
		line4l = sprintf("%3.2f", getprop("/instrumentation/adf[0]/frequencies/selected-khz"));
		line4r = sprintf("%3.2f", getprop("/instrumentation/adf[1]/frequencies/selected-khz"));
	}

	if (display == "PERF_INIT") {
		title = "PERF INIT";
		line1lt = "GR WT";
		line1rt = "CRZ ALT";
		line1r = getprop("/autopilot/route-manager/cruise/altitude-ft");
		line2lt = "FUEL";
		line3lt = "ZFW";
		line4lt = "RESERVES";
		line4rt = "CRZ CG";
		line5lt = "COST INDEX";
		line5rt = "STEP SIZE";
		line6l = "<INDEX";
		line6r = "THRUST LIM>";	
		if (getprop("/sim/flight-model") == "jsb") {
			line1l = sprintf("%3.1f", (getprop("/fdm/jsbsim/inertia/weight-lbs")/1000));
			line2l = sprintf("%3.1f", (getprop("/fdm/jsbsim/propulsion/total-fuel-lbs")/1000));
			line3l = sprintf("%3.1f", (getprop("/fdm/jsbsim/inertia/empty-weight-lbs")/1000));
		} elsif (getprop("/sim/flight-model") == "yasim") {
			line1l = sprintf("%3.1f", (getprop("/yasim/gross-weight-lbs")/1000));
			line2l = sprintf("%3.1f", (getprop("/consumables/fuel/total-fuel-lbs")/1000));

			yasim_emptyweight = getprop("/yasim/gross-weight-lbs");
			yasim_emptyweight -= getprop("/consumables/fuel/total-fuel-lbs");
			yasim_weights = props.globals.getNode("/sim").getChildren("weight");
			for (i = 0; i < size(yasim_weights); i += 1) {
				yasim_emptyweight -= yasim_weights[i].getChild("weight-lb").getValue();
			}
			line3l = sprintf("%3.1f", yasim_emptyweight/1000);
		}
	}

	if (display == "POS_INIT") {
		title = "POS INIT";
		line6l = "<INDEX";
		line6r = "ROUTE>";
	}

	if (display == "POS_REF") {
		title = "POS REF";
		line1lt = "FMC POST";
		line1l = getprop("/position/latitude-string")~" "~getprop("/position/longitude-string");
		line1rt = "GS";
		line1r = sprintf("%3.0f", getprop("/velocities/groundspeed-kt"));
		line5l = "<PURGE";
		line5r = "INHIBIT>";
		line6l = "<INDEX";
		line6r = "BRG/DIST>";
	}

	if (display == "RTE1_1") {
		title = "RTE 1";

		page = pageact~"/"~pagenum;

		line1lt = "ORIGIN";
		if (getprop("/autopilot/route-manager/departure/airport") != nil){
			line1l = getprop("/autopilot/route-manager/departure/airport");
		}
		line1rt = "DEST";
		if (getprop("/autopilot/route-manager/destination/airport") != nil){
			line1r = getprop("/autopilot/route-manager/destination/airport");
		}
		line2lt = "RUNWAY";
		if (getprop("/autopilot/route-manager/departure/runway") != nil){
			line2l = getprop("/autopilot/route-manager/departure/runway");
		}
		line2rt = "FLT NO";
		if (getprop("/instrumentation/cdu/flight-no") != nil){
			line2r = getprop("/instrumentation/cdu/flight-no");
		} else {
			line2r = "";
		}
		line3rt = "CO ROUTE";
		line5l = "<RTE COPY";
		line6l = "<RTE 2";
		if (getprop("/autopilot/route-manager/active") == 1){
			line6r = "PERF INIT>";
		} else {
			line6r = "ACTIVATE>";
		}
	}

	if (display == "RTE1_2") {
		title = "RTE 1";

		page = pageact~"/"~pagenum;

		var inx1=(pageact-2)*5+1;
		var inx2=(pageact-2)*5+2;
		var inx3=(pageact-2)*5+3;
		var inx4=(pageact-2)*5+4;
		var inx5=(pageact-2)*5+5;
		var wp1="/autopilot/route-manager/route/wp["~inx1~"]/id";
		var wp2="/autopilot/route-manager/route/wp["~inx2~"]/id";
		var wp3="/autopilot/route-manager/route/wp["~inx3~"]/id";
		var wp4="/autopilot/route-manager/route/wp["~inx4~"]/id";
		var wp5="/autopilot/route-manager/route/wp["~inx5~"]/id";

		line1lt = "VIA";
		line1rt = "TO";
		if (getprop(wp1) != nil){
			line1r = getprop(wp1);
		}
		if (getprop(wp2) != nil){
			line2r = getprop(wp2);
		}
		if (getprop(wp3) != nil){
			line3r = getprop(wp3);
		}
		if (getprop(wp4) != nil){
			line4r = getprop(wp4);
		}
		if (getprop(wp5) != nil){
			line5r = getprop(wp5);
		}
		line6l = "<RTE 2";
		line6r = "ACTIVATE>";
	}

	if (display == "RTE1_ARR") {
		if (getprop("/autopilot/route-manager/destination/airport") != nil){
			title = getprop("/autopilot/route-manager/destination/airport")~" ARRIVALS";
		} else {
			title = "ARRIVALS";
		}
		line1lt = "STARS";
		line1rt = "APPROACHES";
		if (getprop("/autopilot/route-manager/destination/runway") != nil){
			line1r = getprop("/autopilot/route-manager/destination/runway");
		}
		line2lt = "TRANS";
		line3rt = "RUNWAYS";
		line6l = "<INDEX";
		line6r = "ROUTE>";
	}

	if (display == "RTE1_DEP") {
		if (getprop("/autopilot/route-manager/departure/airport") != nil){
			title = getprop("/autopilot/route-manager/departure/airport")~" DEPARTURES";
		} else {
			title = "DEPARTURES";
		}
		line1lt = "SIDS";
		line1rt = "RUNWAYS";
		if (getprop("/autopilot/route-manager/departure/runway") != nil){
			line1r = getprop("/autopilot/route-manager/departure/runway");
		}
		line2lt = "TRANS";
		line6l = "<ERASE";
		line6r = "ROUTE>";
	}



	if (display == "RTE1_LEGS") {
		if (getprop("/autopilot/route-manager/active") == 1){
			title = "ACT RTE 1 LEGS";
		} else {
			title = "RTE 1 LEGS";
		}
print("RTE1_LEGS Here we go!");
print("pageact=", pageact);
print("pagenum=", pagenum);

		page = pageact~"/"~pagenum;

		var inx1=(pageact-2)*5;
		var inx2=(pageact-2)*5+1;
		var inx3=(pageact-2)*5+2;
		var inx4=(pageact-2)*5+3;
		var inx5=(pageact-2)*5+4;
		var wp1="/autopilot/route-manager/route/wp["~inx1~"]/id";
		var wp2="/autopilot/route-manager/route/wp["~inx2~"]/id";
		var wp3="/autopilot/route-manager/route/wp["~inx3~"]/id";
		var wp4="/autopilot/route-manager/route/wp["~inx4~"]/id";
		var wp5="/autopilot/route-manager/route/wp["~inx5~"]/id";
print(wp1);
		if (getprop(wp1) != nil) {
#			line1lt = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5~"]/leg-bearing-true-deg"));
			line1l = getprop(wp1);
#			line2ct = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5~"]/leg-distance-nm"))~" NM";
#			line1r = sprintf("%5.0f", getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5~"]/altitude-ft"));
#			if (getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5~"]/speed-kts") != nil) {
#				line4r = getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5~"]/speed-kts")~"/"~sprintf("%5.0f", getprop("/autopilot/route-manager/route/#wp["~(pageact-2)*5~"]/altitude-ft"));
#			}
 		}
		if (getprop(wp2) != nil) {
#			if (getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+1~"]/leg-bearing-true-deg") != nil){
#				line2lt = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+1~"]/leg-bearing-true-deg"));
#			}
			line2l = getprop(wp2);
#			if (getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+1~"]/leg-distance-nm") != nil){
#				line3ct = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+1~"]/leg-distance-nm"))~" NM";
#			}
#			line2r = sprintf("%5.0f", getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+1~"]/altitude-ft"));
#			if (getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+1~"]/speed-kts") != nil){
#				line4r = getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+1~"]/speed-kts")~"/"~sprintf("%5.0f", getprop("/autopilot/route-manager/#route/wp["~(pageact-2)*5+1~"]/altitude-ft"));
#			}
		}
		if (getprop(wp3) != nil) {
#			if (getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+2~"]/leg-bearing-true-deg") != nil){
#				line3lt = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+2~"]/leg-bearing-true-deg"));
#			}
			line3l = getprop(wp3);
#			if (getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+2~"]/leg-distance-nm") != nil){
#				line4ct = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+2~"]/leg-distance-nm"))~" NM";
#			}
#			line3r = sprintf("%5.0f", getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+2~"]/altitude-ft"));
#			if (getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+2~"]/speed-kts") != nil){
#				line3r = getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+2~"]/speed-kts")~"/"~sprintf("%5.0f", getprop("/autopilot/route-manager/#route/wp["~(pageact-2)*5+2~"]/altitude-ft"));
#			}
		}
		if (getprop(wp4) != nil) {
#			if (getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+3~"]/leg-bearing-true-deg") != nil){
#				line4lt = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+3~"]/leg-bearing-true-deg"));
#			}
			line4l = getprop(wp4);
#			if (getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+3~"]/leg-distance-nm") != nil){
#				line5ct = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+3~"]/leg-distance-nm"))~" NM";
#			}
#			line4r = sprintf("%5.0f", getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+3~"]/altitude-ft"));
#			if (getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+3~"]/speed-kts") != nil){
#				line4r = getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+3~"]/speed-kts")~"/"~sprintf("%5.0f", getprop("/autopilot/route-manager/#route/wp["~(pageact-2)*5+3~"]/altitude-ft"));
#			}
		}
		if (getprop(wp5) != nil) {
#			if (getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+4~"]/leg-bearing-true-deg") != nil){
#				line5lt = sprintf("%3.0f", getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+4~"]/leg-bearing-true-deg"));
#			}
			line5l = getprop(wp5);
#			line5r = sprintf("%5.0f", getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+4~"]/altitude-ft"));
#			if (getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+4~"]/speed-kts") != nil){
#				line4r = getprop("/autopilot/route-manager/route/wp["~(pageact-2)*5+4~"]/speed-kts")~"/"~sprintf("%5.0f", getprop("/autopilot/route-manager/#route/wp["~(pageact-2)*5+4~"]/altitude-ft"));
#			}
		}
		line6l = "<RTE 2 LEGS";
		if (getprop("/autopilot/route-manager/active") == 1){
			line6r = "RTE DATA>";
		} else {
			line6r = "ACTIVATE>";
		}
	}



	if (display == "THR_LIM") {
		title = "THRUST LIM";
		line1lt = "SEL";
		line1ct = "OAT";
		line1c = sprintf("%2.0f", getprop("/environment/temperature-degc"))~" \00B0";
		line1rt = "TO 1 N1";
		line2l = "<TO";
		line2r = "CLB>";
		line3lt = "TO 1";
		line3c = "<SEL> <ARM>";
		line3r = "CLB 1>";
		line4lt = "TO 2";
		line4r = "CLB 2>";
		line6l = "<INDEX";
		line6r = "TAKEOFF>";
	}
	if (display == "TO_REF") {
		title = "TAKEOFF REF";
		line1lt = "FLAP/ACCEL HT";
		line1l = getprop("/instrumentation/fmc/to-flap");
		line1rt = "REF V1";
		if (getprop("/instrumentation/fmc/vspeeds/V1") != nil){
			line1r = sprintf("%3.0f", getprop("/instrumentation/fmc/vspeeds/V1"));
		}
		line2lt = "E/O ACCEL HT";
		line2rt = "REF VR";
		if (getprop("/instrumentation/fmc/vspeeds/VR") != nil){
			line2r = sprintf("%3.0f", getprop("/instrumentation/fmc/vspeeds/VR"));
		}
		line3lt = "THR REDUCTION";
		line3rt = "REF V2";
		if (getprop("/instrumentation/fmc/vspeeds/V2") != nil){
			line3r = sprintf("%3.0f", getprop("/instrumentation/fmc/vspeeds/V2"));
		}
		line4lt = "WIND/SLOPE";
		line4rt = "TRIM   CG";
		line5rt = "POS SHIFT";
		line6l = "<INDEX";
		line6r = "POS INIT>";
	}
	if (display == "EFIS_CP") {
		title = "EFIS CONTROL";
		line1lt = "BARO SET";
		if (getprop("/instrumentation/cdu/altitude_inhg")) {
			line1l = sprintf("%.2f", getprop("/instrumentation/altimeter/setting-inhg"))~" IN";
		} else {
			line1l = sprintf("%.2f", getprop("/instrumentation/altimeter/setting-hpa"))~" HPA";
		}
		line1rt = "MODE";
		line1r = "MAP>";
		line2lt = "<RAD / BARO SEL";
		line2l = "<RAD <> BARO";
		line2r = "PLN>";
		line3lt = "MINS SET";
		line3l = "350 FT";
		line3r = "APP>";
		line4r = "<MINS RESET";
		line4r = "VOR>";
		line5l = "<RANGE INCR"; 
		line5r = "<SEL> CTR>";
		line6lt = "160NM";
		line6l = "<RANGE DECR";
		line6rt = "-------------------------";
		line6r = "OPTIONS>";
	}
		
	if (serviceable != 1){
		title = "";		page = "";
		line1l = "";	line2l = "";	line3l = "";	line4l = "";	line5l = "";	line6l = "";
		line1lt = "";	line2lt = "";	line3lt = "";	line4lt = "";	line5lt = "";	line6lt = "";
		line1c = "";	line2c = "";	line3c = "";	line4c = "";	line5c = "";	line6c = "";
		line1ct = "";	line2ct = "";	line3ct = "";	line4ct = "";	line5ct = "";	line6ct = "";
		line1r = "";	line2r = "";	line3r = "";	line4r = "";	line5r = "";	line6r = "";
		line1rt = "";	line2rt = "";	line3rt = "";	line4rt = "";	line5rt = "";	line6rt = "";
	}
		
	setprop("/instrumentation/cdu/output/title",title);
	setprop("/instrumentation/cdu/output/page",page);
	setprop("/instrumentation/cdu/output/line1/left",line1l);
	setprop("/instrumentation/cdu/output/line2/left",line2l);
	setprop("/instrumentation/cdu/output/line3/left",line3l);
	setprop("/instrumentation/cdu/output/line4/left",line4l);
	setprop("/instrumentation/cdu/output/line5/left",line5l);
	setprop("/instrumentation/cdu/output/line6/left",line6l);
	setprop("/instrumentation/cdu/output/line1/left-title",line1lt);
	setprop("/instrumentation/cdu/output/line2/left-title",line2lt);
	setprop("/instrumentation/cdu/output/line3/left-title",line3lt);
	setprop("/instrumentation/cdu/output/line4/left-title",line4lt);
	setprop("/instrumentation/cdu/output/line5/left-title",line5lt);
	setprop("/instrumentation/cdu/output/line6/left-title",line6lt);
	setprop("/instrumentation/cdu/output/line1/center",line1c);
	setprop("/instrumentation/cdu/output/line2/center",line2c);
	setprop("/instrumentation/cdu/output/line3/center",line3c);
	setprop("/instrumentation/cdu/output/line4/center",line4c);
	setprop("/instrumentation/cdu/output/line5/center",line5c);
	setprop("/instrumentation/cdu/output/line6/center",line6c);
	setprop("/instrumentation/cdu/output/line1/center-title",line1ct);
	setprop("/instrumentation/cdu/output/line2/center-title",line2ct);
	setprop("/instrumentation/cdu/output/line3/center-title",line3ct);
	setprop("/instrumentation/cdu/output/line4/center-title",line4ct);
	setprop("/instrumentation/cdu/output/line5/center-title",line5ct);
	setprop("/instrumentation/cdu/output/line6/center-title",line6ct);
	setprop("/instrumentation/cdu/output/line1/right",line1r);
	setprop("/instrumentation/cdu/output/line2/right",line2r);
	setprop("/instrumentation/cdu/output/line3/right",line3r);
	setprop("/instrumentation/cdu/output/line4/right",line4r);
	setprop("/instrumentation/cdu/output/line5/right",line5r);
	setprop("/instrumentation/cdu/output/line6/right",line6r);
	setprop("/instrumentation/cdu/output/line1/right-title",line1rt);
	setprop("/instrumentation/cdu/output/line2/right-title",line2rt);
	setprop("/instrumentation/cdu/output/line3/right-title",line3rt);
	setprop("/instrumentation/cdu/output/line4/right-title",line4rt);
	setprop("/instrumentation/cdu/output/line5/right-title",line5rt);
	setprop("/instrumentation/cdu/output/line6/right-title",line6rt);
	settimer(cdu,0.2);
}

var changePage=func() {
print("page button ", getprop("/instrumentation/cdu/page"), " on page ", getprop("/instrumentation/cdu/display"));
	if (getprop("/instrumentation/cdu/display")=="RTE1_1" or getprop("/instrumentation/cdu/display")=="RTE1_2") {
		var dir=0;
		if (getprop("/instrumentation/cdu/page")=="PREV") {dir=-1;}
		if (getprop("/instrumentation/cdu/page")=="NEXT") {dir=1;}
		pageact=pageact+dir;
		if (pageact<1) {pageact=1;}
		if (pageact>pagenum) {pageact=pagenum;}
		if (pageact==1) {
			setprop("/instrumentation/cdu/display", "RTE1_1");
		} else {
			setprop("/instrumentation/cdu/display", "RTE1_2");
		}
		setprop("/instrumentation/cdu/page", "");
print("pageact=", pageact);
	}
}

_setlistener("/sim/signals/fdm-initialized", cdu);
var pagekey_listener=setlistener("/instrumentation/cdu/page", changePage);

