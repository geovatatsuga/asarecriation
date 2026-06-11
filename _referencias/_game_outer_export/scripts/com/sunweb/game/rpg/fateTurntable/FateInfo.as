package com.sunweb.game.rpg.fateTurntable
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class FateInfo extends obf_2_M_853
   {
      
      public var id:int;
      
      public var level:int;
      
      public function FateInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["id:ubyte","level:ubyte"];
      }
   }
}

