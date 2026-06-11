package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerTitleListCheckNotify extends obf_O_8_1034
   {
      
      public var titleList:Array;
      
      public function PlayerTitleListCheckNotify()
      {
         super(CommandCodePlayer.PLAYER_TITLE_LIST_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["titleList:array(short)"];
      }
   }
}

