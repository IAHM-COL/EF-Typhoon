var CanvasApplication = {

	# constructor
	new: func(x1=0, y1=0, x=300, y=200) {
		var m = { parents: [CanvasApplication] };
## setprop("sim/menubar/visible", 'false');	## commented out for now to keep access to debug-menu
		m.window = canvas.Window.new([x,y],"dialog");
		m.window.setPosition(x1, y1);
		m.canvas = m.window.createCanvas().setColorBackground(0.4,0.4,0.4,1);
		m.root = m.canvas.createGroup();
		m.init();
		return m;
	}, # new
 
 
	init: func() {
#		me.vbox = canvas.VBoxLayout.new();
#		me.window.setLayout(me.vbox);
#		me.hbox = canvas.HBoxLayout.new();
#		me.vbox.addItem(me.hbox);
	}, #end of init
 
}; # end of CanvasApplication
 
var CanvasMenu = {

	new: func(x,y, direction, level, dad, filename='gui/dialogs/menubar.xml') {
		var intx=x;
		var inty=y;

		me.load(filename);
		if (x<0) {
			if (direction=="h") {
				intx=0;
				foreach(var menu; me.menubar.menu) {
					intx += size(menu.name)*12+20;
				}
			} else {
				intx=0;
				foreach(var menu; me.menubar.menu) {
					if ((size(menu.name)*12+20)>intx) {
						intx = size(menu.name)*12+20;
					}
				}
			}
		}
		if (y<0) {
			if (direction=="v") {
				inty=0;
				foreach(var menu; me.menubar.menu) {
					inty += 12+5;
				}
			} else {
				inty=0;
				foreach(var menu; me.menubar.menu) {
					if ((size(menu.name)*12+20)>intx) {
						inty = 12+5;
					}
				}
			}
		}
		var m = {parents: [ CanvasMenu, CanvasApplication.new(x1, y1, intx,inty) ], _filename:filename };
		m.daddy=dad;
		m.blocked='false';
		m.init(direction, level, dad);
		return m;
	},

	init: func(direction, level, dad) {
		me.build(direction, level, dad); 
	},
 
	del: func() {
	},

	getBlocked: func() {
		return me.blocked;
	},

	setBlocked: func(b) {
		me.blocked=b;
	},
 
	load: func(filename) {
		var fgroot_path = getprop("/sim/fg-root");
		var path = fgroot_path ~ '/' ~ filename;
 
		# next, load menubar.xml using read_properties() (see io.nas) :
		var menubar = io.read_properties( path );
		me.menubar = menubar.getValues();
	},
 
	build: func(direction, level, dad) { 
		var maxX=0;
		var maxY=0;
 
		foreach(var menu; me.menubar.menu) {
			print("Found new menu:", menu.name);

			# add some text to our menubar:
			var myMenu = me.root.createChild("text");

			myMenu.setDrawMode(canvas.Text.TEXT + canvas.Text.BOUNDINGBOX);
			myMenu.setText(menu.name);
			myMenu.setTranslation(maxX, maxY);
			myMenu.setAlignment("left-top");
			myMenu.setFontSize(12);
			myMenu.setFont("LiberationFonts/LiberationSans-Regular.ttf");
			myMenu.set("max-width", 380);
			myMenu.setColor(1,1,1);

			print("name=>", menu.name, "<");
			if (direction=="h") {
				maxX += size(menu.name)*12+20;
			}
			if (direction=="v") {
				maxY += 12+5;	#12 for font height+5 as apdding
			}
			#### what if someone sends something else but a v or a h? 

			# set up a mouseover listener for the test object:

			var make_handler = func(superObject, group, menu, event) {
				group.addEventListener(event, func() {
					# whenever the listener is triggered, print a message to the console
					print("menubar ",event," event :", menu.name);
					if (superObject.getBlocked()=='false') {
						if (event=="mouseover") {
							group.setColor(1, 0, 0, 1);
						}
						if (event=="mouseout") {
							group.setColor(1, 1, 1, 1);
						}
						if (event=="click") {
							#### open a new menu only if submenu is a new menu, not an item ####
							var left=10;
							var top=10;
							me.blocked='true';
							var newMenubar = CanvasMenu.new(	x:-1, 
												y:-1,
												x1:left,
												y1:top,
												direction:"v",
												level:1,
												dad:group,
												filename:'gui/menubar.xml');
						}
					}
				});
			}

			make_handler(me, myMenu, menu, "mouseover");
			make_handler(me, myMenu, menu, "mouseout");
			make_handler(me ,myMenu, menu, "click");

			# now check for sub menus
			foreach(var submenu; menu.item) {
				if (submenu['enabled'] != 'false') {  
					print("   Found new submenu item:", submenu.name);
				}
 			} # get out items 
 		} # foreach menu
	}, # build()
 
}; # CanvasMenu
 
# support different kinds of menubars

### horizontal example ################################################################
	var myMenubar = CanvasMenu.new(	x:getprop("/sim/startup/xsize"), 
					x1:0,
					y1:0,
					y:20,
					direction:"h",
					level:0,
					dad:nil,
					filename:'gui/menubar.xml');

### vertical example ################################################################
#	var myMenubar = CanvasMenu.new(	x:-1, 
#					y:-1,
#					x1:0,
#					y1:0,
#					direction:"v",
#					level:0,
#					dad:nil;
#					filename:'gui/menubar.xml');

