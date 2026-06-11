package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyBuyAttrMaxAnswer extends obf_O_8_1034
   {
      
      public var strengthMax:int;
      
      public var agilityMax:int;
      
      public var wisdomMax:int;
      
      public var vitalityMax:int;
      
      public function PlayerBabyBuyAttrMaxAnswer()
      {
         super(CommandCodeBaby.PLAYER_BABY_BUY_ATTR_MAX_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["strengthMax:int","agilityMax:int","wisdomMax:int","vitalityMax:int"];
      }
   }
}

