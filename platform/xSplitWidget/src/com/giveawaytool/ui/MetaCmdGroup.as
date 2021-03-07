package com.giveawaytool.ui {
	import com.giveawaytool.MainGame;
	import com.lachhh.io.Callback;
	import com.lachhh.utils.Utils;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCmdGroup {
		public var cmds:Array = new Array();
		public var isCmdExecuting:Boolean = false;
		public var cmdExecuting:MetaCmd ;
		
		
		public function addCommandToQueue(cmd:MetaCmd):void {
			cmds.push(cmd);
		}
		
		public function clear():void {
			Utils.ClearArray(cmds);
			isCmdExecuting = false;
		}
		
		public function tryToExecuteFirstCmd():void {
			if(isCmdExecuting) return ;
			if(cmds.length <= 0) return ;
			isCmdExecuting = true;
			cmdExecuting = cmds.shift();
			cmdExecuting.callbackOnEnd = new Callback(endCmd, this, [cmdExecuting]);
			cmdExecuting.execute(MainGame.logicListenToMain.metaDonationConfig);
			
		}
		
		public function endCmd(cmd:MetaCmd):void {
			if(cmdExecuting != cmd) return ;
			isCmdExecuting = false;
			cmdExecuting = null;
			tryToExecuteFirstCmd();
		}
	}
}
