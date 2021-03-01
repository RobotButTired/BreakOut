package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy24:assets%2FbackGround1.pngy4:sizei191272y4:typey5:IMAGEy2:idR1y7:preloadtgoR0y24:assets%2FbackGround2.pngR2i763972R3R4R5R7R6tgoR0y24:assets%2FbackGround3.pngR2i1108895R3R4R5R8R6tgoR0y24:assets%2FbackGround4.pngR2i1073696R3R4R5R9R6tgoR0y21:assets%2Fparticle.pngR2i787R3R4R5R10R6tgoR0y22:assets%2Fparticle2.pngR2i788R3R4R5R11R6tgoR0y24:assets%2FstartScreen.pngR2i109802R3R4R5R12R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_background1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_background2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_background3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_background4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_particle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_particle2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_startscreen_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:image("Assets/backGround1.png") @:noCompletion #if display private #end class __ASSET__assets_background1_png extends lime.graphics.Image {}
@:keep @:image("Assets/backGround2.png") @:noCompletion #if display private #end class __ASSET__assets_background2_png extends lime.graphics.Image {}
@:keep @:image("Assets/backGround3.png") @:noCompletion #if display private #end class __ASSET__assets_background3_png extends lime.graphics.Image {}
@:keep @:image("Assets/backGround4.png") @:noCompletion #if display private #end class __ASSET__assets_background4_png extends lime.graphics.Image {}
@:keep @:image("Assets/particle.png") @:noCompletion #if display private #end class __ASSET__assets_particle_png extends lime.graphics.Image {}
@:keep @:image("Assets/particle2.png") @:noCompletion #if display private #end class __ASSET__assets_particle2_png extends lime.graphics.Image {}
@:keep @:image("Assets/startScreen.png") @:noCompletion #if display private #end class __ASSET__assets_startscreen_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else



#end

#if (openfl && !flash)

#if html5

#else

#end

#end
#end

#end
