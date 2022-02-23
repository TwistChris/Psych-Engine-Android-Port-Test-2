package;

import lime.utils.Assets;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class ColorData {
      var nameColors:Array<String> = [];
      public var color:Int = -7179779;
      public var colorfolder:Array<String> = [];

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

      public static function okk(nameColors:Array<String>)
      {
              CoolUtil.coolTextFile(Paths.txt('colors'));
      }

      public function new(color:Int, colorfolder:Array<String>)
      {
	      this.color = color;
              this.colorfolder = colorfolder;
      }
}
