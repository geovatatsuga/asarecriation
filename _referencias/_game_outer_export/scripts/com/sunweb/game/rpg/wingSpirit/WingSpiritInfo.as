package com.sunweb.game.rpg.wingSpirit
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class WingSpiritInfo extends obf_2_M_853
   {
      
      public var spiritType:int;
      
      public var spirit:int;
      
      public var attrType:int;
      
      public var attrValue:Number;
      
      public function WingSpiritInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["spiritType:ubyte","spirit:int","attrType:ushort","attrValue:float"];
      }
   }
}

