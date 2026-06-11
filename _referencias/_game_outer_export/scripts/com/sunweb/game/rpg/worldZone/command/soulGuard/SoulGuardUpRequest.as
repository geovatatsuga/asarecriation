package com.sunweb.game.rpg.worldZone.command.soulGuard
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class SoulGuardUpRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public function SoulGuardUpRequest()
      {
         super(CommandCodeSoulGuard.SOUL_GUARD_UP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte"];
      }
   }
}

