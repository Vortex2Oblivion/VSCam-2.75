package funkin.states;

import funkin.backend.FlxAudioHandler;
import flixel.FlxState;

class FunkinState extends FlxState {
	public static var menuSong:String = "";
	var skipMusicCheck:Bool = false;
	
	override function create() {
		super.create();
		//Conductor.reset();
		Paths.clearUnusedMemory();

		Conductor.onStep.add(stepHit);
		Conductor.onBeat.add(beatHit);
		Conductor.onMeasure.add(measureHit);

		musicCheck();
	}
	
	function musicCheck() {
		if (skipMusicCheck || FlxAudioHandler.music.playing) return;

		funkin.backend.CreditsStuff.MenuMusic.loadMusicList();
		menuSong = funkin.backend.CreditsStuff.MenuMusic.gimmeMusicName();
		funkin.backend.CreditsStuff.MenuMusic.menuCredits(this);
		Conductor.inst = FlxAudioHandler.loadMusic(Paths.audioPath(menuSong, 'music'), true);
		Conductor.play();

		if (!funkin.backend.CreditsStuff.MenuMusic.gameInitialized)
			funkin.backend.CreditsStuff.MenuMusic.gameInitialized = true;
	}

	public function stepHit(step:Int):Void {}

	public function beatHit(beat:Int):Void {}
	public function measureHit(measure:Int):Void {}
}
