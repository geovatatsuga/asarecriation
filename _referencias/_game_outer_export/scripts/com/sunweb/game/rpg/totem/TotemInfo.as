package com.sunweb.game.rpg.totem
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class TotemInfo extends obf_2_M_853
   {
      
      public var type:int;
      
      public var stage:int;
      
      public var level:int;
      
      public function TotemInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","stage:ubyte","level:ubyte"];
      }
   }
}

