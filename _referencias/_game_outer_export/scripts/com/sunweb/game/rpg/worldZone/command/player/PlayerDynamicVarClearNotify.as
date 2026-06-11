package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerDynamicVarClearNotify extends obf_O_8_1034
   {
      
      public var boolVars:Array;
      
      public var intVars:Array;
      
      public var strVars:Array;
      
      public function PlayerDynamicVarClearNotify()
      {
         super(CommandCodePlayer.PLAYER_DYNAMIC_VAR_CLEAR_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["boolVars:array(string)","intVars:array(string)","strVars:array(string)"];
      }
   }
}

