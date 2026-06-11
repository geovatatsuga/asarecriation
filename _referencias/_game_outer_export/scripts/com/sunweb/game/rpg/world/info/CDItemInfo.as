package com.sunweb.game.rpg.world.info
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class CDItemInfo extends obf_2_M_853
   {
      
      public var code:String;
      
      public var cdTimeLeftInMS:int;
      
      public function CDItemInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["code:string","cdTimeLeftInMS:int"];
      }
   }
}

