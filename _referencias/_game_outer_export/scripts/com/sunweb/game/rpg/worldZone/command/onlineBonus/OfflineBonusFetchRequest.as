package com.sunweb.game.rpg.worldZone.command.onlineBonus
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class OfflineBonusFetchRequest extends obf_O_8_1034
   {
      
      public var expMul:int;
      
      public function OfflineBonusFetchRequest()
      {
         super(CommandCodeOnlineBonus.OFFLINE_BONUS_FETCH_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["expMul:byte"];
      }
   }
}

