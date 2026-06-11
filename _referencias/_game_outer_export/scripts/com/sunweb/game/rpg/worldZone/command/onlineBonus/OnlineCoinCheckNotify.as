package com.sunweb.game.rpg.worldZone.command.onlineBonus
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class OnlineCoinCheckNotify extends obf_O_8_1034
   {
      
      public var onlineSeconds:int;
      
      public var bonusCoin:int;
      
      public var items:Object;
      
      public function OnlineCoinCheckNotify()
      {
         super(CommandCodeOnlineBonus.ONLINE_COIN_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["onlineSeconds:int","bonusCoin:int","items:map(string,ubyte)"];
      }
   }
}

