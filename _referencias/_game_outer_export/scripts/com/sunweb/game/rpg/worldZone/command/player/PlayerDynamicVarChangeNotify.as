package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerDynamicVarChangeNotify extends obf_O_8_1034
   {
      
      public var boolVars:Object;
      
      public var intVars:Object;
      
      public var strVars:Object;
      
      public function PlayerDynamicVarChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_DYNAMIC_VAR_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["boolVars:map(string,boolean)","intVars:map(string,vint)","strVars:map(string,string)"];
      }
   }
}

