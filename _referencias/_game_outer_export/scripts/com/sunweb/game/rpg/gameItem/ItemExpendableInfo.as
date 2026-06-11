package com.sunweb.game.rpg.gameItem
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class ItemExpendableInfo extends obf_2_M_853
   {
      
      public var usePlace:String;
      
      public function ItemExpendableInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["usePlace:string"];
      }
   }
}

