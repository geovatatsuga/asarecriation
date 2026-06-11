package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerLifeExpChangeNotify extends obf_O_8_1034
   {
      
      public var expChanged:int;
      
      public var expCurrent:int;
      
      public function PlayerLifeExpChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_LIFE_EXP_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["expChanged:int","expCurrent:int"];
      }
   }
}

