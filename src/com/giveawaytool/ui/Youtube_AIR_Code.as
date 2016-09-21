package  
com.giveawaytool.ui{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.system.*;


public class Youtube_AIR_Code extends MovieClip 
{
    public var YT_Loader : Loader;
    public var my_VIDEO_ID : String = "4WArVMN5Q2s"; //# the YouTube ID

    public function Youtube_AIR_Code () 
    {
        Security.loadPolicyFile("http://www.youtube.com/crossdomain.xml");

        YT_Loader = new Loader();
        YT_Loader.contentLoaderInfo.addEventListener(Event.COMPLETE, YT_Ready );
        YT_Loader.load( new URLRequest("http://www.youtube.com/v/" + my_VIDEO_ID) );

    }

    function YT_Ready (e:Event) : void
    {
        trace("YouTube SWF :: [status] :: Loading Completed");

        //addChild(YT_Loader);

        //# Wait for Youtube Player to initialise
        YT_Loader.content.addEventListener("onReady", on_YT_PlayerLoaded );

    }

    private function on_YT_PlayerLoaded (e:Event) : void
    {
        //# Check Original Width/Height - Scale it proportionally               
        trace( "YT_Loader content Width  : " + YT_Loader.content.width );
        trace( "YT_Loader content Height : " + YT_Loader.content.height );

        //# Testing changed size and position
        YT_Loader.width = 320; YT_Loader.height = 240;
        YT_Loader.x = 30; YT_Loader.y = 100;

        addChild(YT_Loader); //# can add to stage only

    }

} //# End Public Class

}