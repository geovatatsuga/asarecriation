package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerGoldChangeNotify extends obf_O_8_1034
   {
      
      public var goldChanged:int;
      
      public var goldCurrent:Number;
      
      public function PlayerGoldChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_GOLD_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["goldChanged:int","goldCurrent:double"];
      }
   }
}

