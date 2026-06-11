package com.sunweb.game.rpg.godStyle
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class GodStyleRankInfo extends obf_2_M_853
   {
      
      public var name:String;
      
      public var value:int;
      
      public function GodStyleRankInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["name:string","value:int"];
      }
   }
}

