package com.sunweb.game.rpg.manual
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class MonsterManualInfo extends obf_2_M_853
   {
      
      public var absorbTimes:int;
      
      public var code:String;
      
      public function MonsterManualInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["code:string","absorbTimes:int"];
      }
   }
}

