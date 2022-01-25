package;

import Section.SwagSection;
import Song.SwagSong;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
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

class CharMenu extends MusicBeatState
{
    var menuItems:Array<String> = ['bf', 'beta', 'blue', 'mean'];
    var curSelected:Int = 0;
    var txtDescription:FlxText;
    var shitCharacter:FlxSprite;
	var shitCharacterBetter:Boyfriend;
    var icon:HealthIcon;
    var menuBG:FlxSprite;
    public var tagertY:Float = 0;
    var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;
    public static var characterShit:Array<CharacterMenu>;

    private var grpMenu:FlxTypedGroup<Alphabet>;
    private var grpMenuImage:FlxTypedGroup<FlxSprite>;
    var alreadySelected:Bool = false;
    var doesntExist:Bool = false;
    private var iconArray:Array<Boyfriend> = [];

    var names:Array<String> = [
        "Boyfriend",
        "Boyfriend Beta",
        "Boyfriend Blue",
        "Boyfriend Mean"
    ];

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

            icon.sprTracker = songText;
            icon.scale.set(0.8, 0.8);

            //Using a FlxGroup is too much fuss!
            iconArray.push(icon);
            add(icon);
        }

        txtDescription = new FlxText(FlxG.width * 0.075, menuBG.y + 200, 0, "", 32);
        txtDescription.alignment = CENTER;
        txtDescription.setFormat(Paths.font("vcr.ttf"), 36);
        txtDescription.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1.5, 1);
        txtDescription.color = FlxColor.WHITE;
        add(txtDescription);

        //shitCharacter = new FlxSprite(0, -20);
        //shitCharacter.scale.set(0.45, 0.45);
		//shitCharacter.updateHitbox();
		//shitCharacter.screenCenter(XY);
		//shitCharacter.antialiasing = true;
		//shitCharacter.y += 30;
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

        changeSelection();

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

        var upP = controls.LEFT_P;
        var downP = controls.RIGHT_P;
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

            if (accepted){
                    switch (daSelected){
                    case "bf":
                        menuBG.color = 0x87ceeb;
                    case "beta":
                        menuBG.color = 0x87ceeb;
                    case "blue":
                        menuBG.color = 0x87ceeb;
                    case "mean":
                        menuBG.color = 0x87ceeb;
                    default:
                        menuBG.color = 0x87ceeb;
 

                    alreadySelected = true;
                    PlayState.bfsel = daSelected;


     
                    FlxG.sound.play(Paths.sound('confirmMenu'));

                    new FlxTimer().start(1, function(tmr:FlxTimer)
                        {
                            LoadingState.loadAndSwitchState(new PlayState());
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
            curSelected += change;

            if (curSelected < 0)
                curSelected = menuItems.length - 1;
            if (curSelected >= menuItems.length)
                curSelected = 0;

            var otherInt:Int = 0;

            for (i in 0...iconArray.length)
                {
                    iconArray[i].alpha = 1;
                }
            
            iconArray[curSelected].alpha = 1;

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

                switch (daSelected)
                {
                    case "bf":
                        menuBG.loadGraphic('BG1');
                        menuBG.color = 0x87ceeb;
                    case "beta":
                        menuBG.loadGraphic('BG2');
                        menuBG.color = 0xFFFFFF;
                    case "blue":
                        menuBG.loadGraphic('BG3');
				        menuBG.color = 0xFF00FF;
                    case "mean":
                        menuBG.loadGraphic('BG1');
				        menuBG.color = 0xFF00FF;
                    default:
                        menuBG.loadGraphic('BG4');
				        menuBG.color = 0xFFFFFF;
                }

                //shitCharacter.updateHitbox();
		        //shitCharacter.screenCenter(XY);

                doesntExist = true;
                
            }
}
