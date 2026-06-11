package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBuffChangeNotify extends obf_O_8_1034
   {
      
      public var buffsAdded:Array;
      
      public var buffsRemoved:Array;
      
      public function PlayerBuffChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_BUFF_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["buffsAdded:array(com.sunweb.game.rpg.buff.BuffInfo)","buffsRemoved:array(ushort)"];
      }
   }
}

