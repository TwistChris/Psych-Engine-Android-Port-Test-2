package;

import lime.utils.Assets;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class ColorData {
      var nameColors:Array<String> = [];
      public var color:Int = -7179779;

      public static function coolColorFile():Array<ColorData>
      {
		var colorList:Array<String> = Assets.getText(path).trim().split('\n');
      }

      public function new(color:Int)
      {
	      this.color = color;
      }
}
