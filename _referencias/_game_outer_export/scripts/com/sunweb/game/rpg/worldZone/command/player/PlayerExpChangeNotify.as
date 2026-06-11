package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerExpChangeNotify extends obf_O_8_1034
   {
      
      public var expChanged:Number;
      
      public var expCurrent:Number;
      
      public function PlayerExpChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_EXP_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["expChanged:double","expCurrent:double"];
      }
   }
}

