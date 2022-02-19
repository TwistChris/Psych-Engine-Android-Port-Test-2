package;

import lime.utils.Assets;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

typedef ColorFile =
{
     var color:Int = -7179779;
}

class ColorData {
      public var color:Int = -7179779;
      public static function coolColorFile(path:String):Array<String>
      {
		var daList:Array<String> = [];
		if(Assets.exists(path)) daList = Assets.getText(path).trim().split('\n');

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
