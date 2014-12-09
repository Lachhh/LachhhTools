package com.lachhh.flash.debug {
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.text.Font;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class UIFontLoopkup extends UIBase {
		
		public var tf:TextField = new TextField();
		public function UIFontLoopkup() {
			super(0);
			//flash.text.Font.registerFont(NexaBold);
			//POur checker toute les 
			for each ( var s:Font in flash.text.Font.enumerateFonts( true ))
			{
			     if (s.fontName.substring(0,4) == "Nexa")
			          trace(s.fontName + ", " + s.fontStyle + ", " + s.fontType);
			}
			destroy();
		}
	}
}
