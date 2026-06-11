package com.sunweb.game.rpg.bless
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class BlessSellInfo extends obf_2_M_853
   {
      
      public var blessCode:String;
      
      public var blessLevel:int;
      
      public var blessPrice:int;
      
      public var buyNum:int;
      
      public function BlessSellInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["blessCode:string","blessLevel:byte","blessPrice:int","buyNum:int"];
      }
   }
}

