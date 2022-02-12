package;

import Section.SwagSection;
import Song.SwagSong;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import flixel.util.FlxTimer;
import lime.utils.Assets;
import haxe.Json;
import Boyfriend.Boyfriend;
import Character.Character;
import HealthIcon.HealthIcon;
import flixel.ui.FlxBar;

typedef CharacterMenu = {
    var name:String;
    var characterName:String;
    var portrait:String;
}

class CharacterSelection extends MusicBeatState
{
    var menuItems:Array<String> = [];
    var curSelected:Int = 0;
    var txtDescription:FlxText;
    var shitCharacter:FlxSprite;
	var shitCharacterBetter:Boyfriend;
    var icon:HealthIcon;
    var colo:String;
    var menuBG:FlxSprite;
    public var tagertY:Float = 0;
    var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;
    public static var characterShit:Array<CharacterMenu>;

    private var grpMenu:FlxTypedGroup<Alphabet>;
    private var grpMenuImage:FlxTypedGroup<FlxSprite>;
    var nameIcons:Array<String> = [];
    var nameColors:Array<String> = [];
    var alreadySelected:Bool = false;
    var doesntExist:Bool = false;
    private var iconArray:Array<Boyfriend> = [];
    private var coloArray:Array<FlxColor> = [];

    var names:Array<String> = [];

    var txtOptionTitle:FlxText;

    override function create() 
    {
        menuBG = new FlxSprite().loadGraphic(Paths.image('BG4'));
        menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
        menuBG.updateHitbox();
        menuBG.screenCenter();
        menuBG.antialiasing = true;
        add(menuBG);

        grpMenu = new FlxTypedGroup<Alphabet>();
        add(grpMenu);

        grpMenuImage = new FlxTypedGroup<FlxSprite>();
        add(grpMenuImage);
    
        nameIcons = CoolUtil.coolTextFile(Paths.txt('icons'));

        names = CoolUtil.coolTextFile(Paths.txt('names'));
        
        menuItems = CoolUtil.coolTextFile(Paths.txt('charselect'));

        nameColors = CoolUtil.coolTextFile(Paths.txt('colors'));

        for (i in 0...menuItems.length)
        {
            var songText:Alphabet = new Alphabet(170, (70 * i) + 230, menuItems[i], true, false);
            songText.isMenuItem = true;
            songText.targetY = i;
            grpMenu.add(songText);
            //songText.x += 40;
            //DON'T PUT X IN THE FIRST PARAMETER OF new ALPHABET()!
            //songText.screenCenter(X);
            var icon:Boyfriend = new Boyfriend(0, 0, menuItems[i]);

            icon.scale.set(0.8, 0.8);

            //Using a FlxGroup is too much fuss!
            iconArray.push(icon);
            add(icon);
        }

        for (i in 0...coloArray.length)
        {
             var colo:FlxColor = coloArray[i];

             coloArray.push(colo);
        }

        txtDescription = new FlxText(FlxG.width * 0.075, menuBG.y + 200, 0, "", 32);
        txtDescription.alignment = CENTER;
        txtDescription.setFormat("assets/fonts/vcr.ttf", 32);
        txtDescription.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1.5, 1);
        txtDescription.color = FlxColor.WHITE;
        add(txtDescription);

        //shitCharacter = new FlxSprite(0, 0);
        //shitCharacter.scale.set(0.45, 0.45);
		//shitCharacter.updateHitbox();
		//shitCharacter.screenCenter(X);
                //shitCharacter.x += 500;
                //shitCharacter.y += 230;
		//shitCharacter.antialiasing = true;
		//add(shitCharacter);

        var charSelHeaderText:Alphabet = new Alphabet(0, 50, 'Character Select', true, false);
        charSelHeaderText.screenCenter(X);
        add(charSelHeaderText);

        var arrows:FlxSprite = new FlxSprite().loadGraphic(Paths.image('arrows'));
        arrows.setGraphicSize(Std.int(arrows.width * 1.1));
        arrows.screenCenter();
        arrows.antialiasing = true;
        add(arrows);

        txtOptionTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
        txtOptionTitle.setFormat("assets/fonts/pdark.ttf", 32, FlxColor.WHITE, RIGHT);
        txtOptionTitle.alpha = 0.7;
        add(txtOptionTitle);

        cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

        #if mobileC
        addVirtualPad(FULL, A_B);	
        #end

        super.create();
    }

    override function update(elapsed:Float) 
    {
        txtOptionTitle.text = names[curSelected].toUpperCase();
        txtOptionTitle.x = FlxG.width - (txtOptionTitle.width +10);
        if (txtOptionTitle.text == '')
            {
                trace('');
                txtOptionTitle.text = '';
            }

        if (iconArray[curSelected].animation.curAnim.name == 'idle' && iconArray[curSelected].animation.curAnim.finished && doesntExist)
            iconArray[curSelected].playAnim('idle', true);

        var upP = controls.UI_LEFT_P;
        var downP = controls.UI_RIGHT_P;
        var accepted = controls.ACCEPT;

        if (!alreadySelected)
        {
            if (upP)
                {
                    changeSelection(-1);
                }

            if (downP)
                {
                    changeSelection(1);
                }

            if (accepted)
                {
                    alreadySelected = true;
                    var daSelected:Bool = menuItems[curSelected];
                    PlayState.hasPlayedOnce = true;
                    if (menuItems[curSelected] != 'bf')
                        PlayState.charsel = menuItems;
                        PlayState.bfsel = daSelected;

                    FlxFlicker.flicker(iconArray[curSelected], 0);
                    new FlxTimer().start(1, function(tmr:FlxTimer)
                        {
                            LoadingState.loadAndSwitchState(new MainMenuState());
                        });
                }
            
            if (controls.BACK)
                {
                    FlxG.switchState(new MainMenuState());
                }
        }

        super.update(elapsed);
    }

    function changeSelection(change:Int = 0):Void
        {

            for (i in 0...iconArray.length)
                {
                    iconArray[i].x = 470 - (iconArray[i].x / i+1) * (FlxG.width/2) * (curSelected + i) * (FlxG.width/2) * (curSelected + i);
                }

            curSelected += change;

            if (curSelected >= menuItems.length)
                curSelected = 0;
            if (curSelected < 0)
                curSelected = menuItems.length - 1;

            var otherInt:Int = 0;

            for (i in 0...iconArray.length)
                {
                    iconArray[i].alpha = 1;
                }
            
            iconArray[curSelected].alpha = 1;

            for (i in 0...coloArray.length)
                {
                    coloArray[i].alpha = 1;
                }
            
            coloArray[curSelected].alpha = 1;

            for (item in grpMenu.members)
                {
                    item.targetY = otherInt - curSelected;
                    otherInt++;

                    item.alpha = 0;
                    //item.setGraphicSize(Std.int(item.width * 0.8));

                    if (item.targetY == 0)
                        {
                            // item.setGraphicSize(Std.int(item.width));
                        }
                }
            
            charCheck();
        }

        function charCheck()
            {
                doesntExist = false;
                var daSelected:String = menuItems[curSelected];
                var storedColor:FlxColor = 0xFFFFFF;
                remove(icon);

                //shitCharacter.updateHitbox();
		        //shitCharacter.screenCenter(X);

                doesntExist = true;

                var healthBarBG:FlxSprite = new FlxSprite(0, FlxG.height * 0.9).loadGraphic('assets/shared/images/healthBar.png');
                healthBarBG.screenCenter(X);
		        healthBarBG.scrollFactor.set();
		        healthBarBG.visible = false;
		        add(healthBarBG);

                var healthBar:FlxBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
                    'health', 0, 2);
                healthBar.scrollFactor.set();
                healthBar.createFilledBar(0xFFFF0000, 0xFF66FF33);
                healthBar.visible = false;
                // healthBar
                add(healthBar);
                icon = new HealthIcon(nameIcons[curSelected], true);
                icon.y = healthBar.y - (icon.height / 2);
                icon.screenCenter(X);
                icon.setGraphicSize(-4);
                icon.y -= 20;
                add(icon); 
  
                colo = (nameColors[curSelected]);
            }
}
