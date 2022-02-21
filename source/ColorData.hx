package;

import lime.utils.Assets;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class ColorData {
      var nameColors:Array<String> = [];
      public var color:Int = -7179779;

      public static function coolColorFile(path:String):Array<ColorData>
      {
		var daList:Array<ColorData> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
      }

      public function new(color:Int)
      {
	      this.color = color;
      }
}
