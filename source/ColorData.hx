package;

import flixel.FlxG;
import lime.utils.Assets;
import lime.utils.Assets as LimeAssets;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import openfl.utils.Assets as OpenFlAssets;
import openfl.utils.Assets;

using StringTools;

class ColorData {
      public var namesColors:Array<String> = [];
      public var color:Int = -7179779;

      public static function coolColorFile(namesColors:ColorData)
      {
		namesColors = CoolUtil.coolTextFile(Paths.txt('colors'));
      }

      public function new(color:Int)
      {
	      this.color = color;
      }
}
