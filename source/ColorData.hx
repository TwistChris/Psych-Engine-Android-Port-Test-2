package;

import lime.utils.Assets;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class ColorData {
      public var color:Int = -7179779;

      public static function coolColorFile(path:String):Array<String>
      {
		nameColors = CoolUtil.coolTextFile(Paths.txt('colors'));
      }

      public function new(color:Int)
      {
	      this.color = color;
      }
}