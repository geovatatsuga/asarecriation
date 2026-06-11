package com.sunweb.game.rpg.soulGuard
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class SoulGuardInfo extends obf_2_M_853
   {
      
      public var type:int;
      
      public var guardLevel:int;
      
      public var blessLevel:int;
      
      public function SoulGuardInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","guardLevel:ubyte","blessLevel:ubyte"];
      }
   }
}

