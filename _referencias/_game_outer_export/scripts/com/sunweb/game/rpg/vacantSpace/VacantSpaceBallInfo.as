package com.sunweb.game.rpg.vacantSpace
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class VacantSpaceBallInfo extends obf_2_M_853
   {
      
      public var index:int;
      
      public var level:int;
      
      public var attrValue:int;
      
      public function VacantSpaceBallInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["index:byte","level:byte","attrValue:int"];
      }
   }
}

