package com.sunweb.game.rpg.mate
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class MateRelationInfo extends obf_2_M_853
   {
      
      public var mateName:String;
      
      public var relationType:int;
      
      public var mateValue:int;
      
      public var mateGold:int;
      
      public function MateRelationInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["mateName:string","relationType:byte","mateValue:ushort","mateGold:ushort"];
      }
   }
}

