package;

import flixel.FlxG;
import lime.utils.Assets;
import lime.utils.Assets as LimeAssets;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import openfl.utils.Assets as OpenFlAssets;
import openfl.utils.Assets;

using StringTools;

typedef ColorFile =
{
      var nameColors:Array<String>;
}

class ColorData {
      public var nameColors:Array<String> = [];
      public var color:Int = -7179779;

      public static function createColorFile():ColorFile {
              var colorFile:ColorFile = {
                      nameColors = ColorData.coolColorFile(Paths.txt('colors'));
              };
              return colorFile;
      }

      public function new(color:Int, colorFile:ColorFile)
      {
	      this.color = color;
              colorFile.nameColors = nameColors;
      }
}
