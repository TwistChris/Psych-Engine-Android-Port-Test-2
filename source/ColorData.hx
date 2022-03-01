package;

import flixel.FlxG;
import lime.utils.Assets;
import lime.utils.Assets as LimeAssets;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import openfl.utils.Assets as OpenFlAssets;
import openfl.utils.Assets;

using StringTools;

public static function coolColorFile(path:String)
	{
		var daList:Array<String> = [];
		if(Assets.exists(path)) daList = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}


class ColorData {
      public var color:Int = 0xFFFFFFFF;

      public function new(color:Int)
      {
	      this.color = color;
      }
}
