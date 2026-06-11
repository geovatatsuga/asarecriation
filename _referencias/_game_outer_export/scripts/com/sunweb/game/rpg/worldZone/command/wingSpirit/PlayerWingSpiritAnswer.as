package com.sunweb.game.rpg.worldZone.command.wingSpirit
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   
   public class PlayerWingSpiritAnswer extends obf_O_8_1034
   {
      
      public var doType:int;
      
      public var isSucceed:Boolean;
      
      public var equipmentInfo:GameItemFullInfo;
      
      public function PlayerWingSpiritAnswer()
      {
         super(CommandCodePlayerWingSpirit.PLAYER_WING_SPIRIT_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["doType:ubyte","isSucceed:boolean","equipmentInfo:com.sunweb.game.rpg.gameItem.GameItemFullInfo"];
      }
   }
}

