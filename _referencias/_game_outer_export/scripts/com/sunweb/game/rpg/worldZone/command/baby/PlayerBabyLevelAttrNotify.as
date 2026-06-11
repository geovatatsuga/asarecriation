package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyLevelAttrNotify extends obf_O_8_1034
   {
      
      public var level:int;
      
      public var exp:int;
      
      public var strength:int;
      
      public var agility:int;
      
      public var wisdom:int;
      
      public var vitality:int;
      
      public var strengthMax:int;
      
      public var agilityMax:int;
      
      public var wisdomMax:int;
      
      public var vitalityMax:int;
      
      public function PlayerBabyLevelAttrNotify()
      {
         super(CommandCodeBaby.PLAYER_BABY_LV_AT_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["level:ubyte","exp:int","strength:int","agility:int","wisdom:int","vitality:int","strengthMax:int","agilityMax:int","wisdomMax:int","vitalityMax:int"];
      }
   }
}

