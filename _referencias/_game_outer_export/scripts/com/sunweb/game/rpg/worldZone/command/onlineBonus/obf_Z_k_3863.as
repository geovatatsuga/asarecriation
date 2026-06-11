package com.sunweb.game.rpg.worldZone.command.onlineBonus
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class obf_Z_k_3863 extends obf_O_8_1034
   {
      
      public var consecutiveLoginDays:int;
      
      public var boonItemCode:String;
      
      public function obf_Z_k_3863()
      {
         super(CommandCodeOnlineBonus.obf_0_8_k_656);
      }
      
      override public function getFieldList() : Array
      {
         return ["consecutiveLoginDays:int","boonItemCode:string"];
      }
   }
}

