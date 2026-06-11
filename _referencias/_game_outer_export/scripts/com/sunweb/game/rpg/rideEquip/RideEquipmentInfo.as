package com.sunweb.game.rpg.rideEquip
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class RideEquipmentInfo extends obf_2_M_853
   {
      
      public var kind:int;
      
      public var level:int;
      
      public var soul:int;
      
      public var attrSoul:Array;
      
      public var attr:Array;
      
      public var attrFinal:Array;
      
      public var tempAttSoul:Array;
      
      public var tempAttr:Array;
      
      public var tempAttrFinal:Array;
      
      public function RideEquipmentInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["kind:ubyte","level:ubyte","soul:ubyte","attrSoul:array(ubyte)","attr:array(short)","attrFinal:array(short)"];
      }
   }
}

