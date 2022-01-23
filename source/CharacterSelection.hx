package;

import openfl.display.Preloader.DefaultPreloader;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import flixel.ui.FlxVirtualPad;
import flixel.effects.FlxFlicker;

using StringTools;

class CharacterSelection extends MusicBeatState
{


    var bflist:Array<String> = ['BOYFRIEND', 'BETA_BOYFRIEND', 'BLUE_BOYFRIEND', 'MEAN_BOYFRIEND'];

	var curSelected:Int = 0;


	var BG:FlxSprite;


	var arrowsz_left:FlxSprite;
	var arrowsz_right:FlxSprite;

	var characters:FlxSprite;

	var curselected_text:FlxText;

	var selected:Bool = false;

	var icon:FlxSprite;


	override function create()
	{

        //bg
		BG = new FlxSprite(0, 0).loadGraphic('assets/preload/images/charSelect/BG1.png');

		//characterselect_text
		var characterselect_text:Alphabet = new Alphabet(0, 0, "character select", true, false);
		characterselect_text.screenCenter();
		characterselect_text.y = 50;


		//curselected_text
		curselected_text = new FlxText(0, 10, bflist[0], 24);
		curselected_text.alpha = 0.5;
		curselected_text.x = (FlxG.width) - (curselected_text.width) - 25;



		// arrowsz
		arrowsz_left = new FlxSprite(0, 0).loadGraphic('assets/preload/images/charSelect/arrowsz_left.png');

		arrowsz_right = new FlxSprite(arrowsz_left.width, 0).loadGraphic('assets/preload/images/charSelect/arrowsz_right.png');



		// characters
		characters = new FlxSprite(0, 0);
		characters.frames = Paths.getSparrowAtlas('shared/images/characters' + bf list[0]);
		characters.antialiasing = true;
		
                characters.animation.addByPrefix('BF idle', 'BF idle dance', 12);
		characters.animation.addByPrefix('BF idle', 'BF idle dance', 12);
		characters.animation.addByPrefix('BF idle', 'BF idle dance', 12);
		characters.animation.addByPrefix('BF idle', 'BF idle dance', 12);

                characters.animation.addByPrefix('BF HEY', 'BF HEY!!!', 24);
		characters.animation.addByPrefix('BF HEY', 'BF HEY!!!', 24);
		characters.animation.addByPrefix('BF HEY', 'BF HEY!!!', 24);
		characters.animation.addByPrefix('BF HEY', 'BF HEY!!!', 24);

		
		characters.updateHitbox();
		
		characters.setGraphicSize(Std.int(275));
		
		characters.x = (FlxG.width / 2) - (characters.width / 2);
		characters.y = (FlxG.height / 2) - (characters.height / 2);








		icon = new FlxSprite(0, 0).loadGraphic('assets/preload/images/charSelect/frame1.png');


		icon.screenCenter();

		icon.y = FlxG.height - 200;

		//trace(BG.height);


        add(BG);

		add(arrowsz_left);
		add(arrowsz_right);

		add(curselected_text);
        add(characterselect_text);
		add(characters);


		add(icon);

		changeSelection(0);

                #if mobileC		
                addVirtualPad(NONE, A_B);		
                #end

		super.create();
	}



	override function update(elapsed:Float)
	{
		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.switchState(new MainMenuState());
		}

		if (controls.ACCEPT){
			switch curSelected{
				case 0:
					characters.animation.play('BF HEY');
				case 1:
					characters.animation.play('BF HEY');
				case 2:
					characters.animation.play('BF HEY');
                                case 3:
					characters.animation.play('BF HEY');
				default:
					characters.animation.play('BF HEY');

			}
			
			
			selected = true;
			PlayState.bfsel = curSelected;

			
			FlxG.sound.play(Paths.sound('confirmMenu'));

			FlxFlicker.flicker(characters, 1.1, 0.04);

			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new MainMenuState());
			});		
		
	}


		for (touch in FlxG.touches.list){
			if (touch.overlaps(arrowsz_right) && touch.justReleased && !selected){
				changeSelection(1);
			}
	
			if (touch.overlaps(arrowsz_left) && touch.justReleased && !selected){
				changeSelection(-1);
			}
		}

		if (controls.BACK)
			{
				FlxG.switchState(new MainMenuState());
			}

		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
		{
			curSelected += change;
	
			if (curSelected < 0)
				curSelected = bflist.length - 1;
			if (curSelected >= bflist.length)
				curSelected = 0;
			trace(curSelected);
	
			curselected_text.text = bflist[curSelected];

			icon.loadGraphic('assets/preload/images/charSelect/frame' + (curSelected + 1) + '.png');


			switch curSelected{
				case 0:
					characters.animation.play('BF idle');
					BG.loadGraphic('assets/preload/images/charSelect/BG2.png');
                                case 1:
					characters.animation.play('BF idle');
					BG.loadGraphic('assets/preload/images/charSelect/BG1.png');
				case 2:
					characters.animation.play('BF idle');
					BG.loadGraphic('assets/preload/images/charSelect/BG2.png');
				case 3:
					characters.animation.play('BF idle');
					BG.loadGraphic('assets/preload/images/charSelect/BG3.png');
				default:
					characters.animation.play('BF idle');
					BG.loadGraphic('assets/preload/images/charSelect/BG2.png');

			}

	
		}
}
