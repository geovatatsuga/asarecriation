package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerDoClientMacroNotify extends obf_O_8_1034
   {
      
      public var macroList:Array;
      
      public function PlayerDoClientMacroNotify()
      {
         super(CommandCodePlayer.PLAYER_DO_CLIENT_MACRO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["macroList:array(string)"];
      }
   }
}

