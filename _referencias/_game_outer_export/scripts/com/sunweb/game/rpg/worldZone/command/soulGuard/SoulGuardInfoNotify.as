package com.sunweb.game.rpg.worldZone.command.soulGuard
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class SoulGuardInfoNotify extends obf_O_8_1034
   {
      
      public var soulGuardList:Array;
      
      public function SoulGuardInfoNotify()
      {
         super(CommandCodeSoulGuard.SOUL_GUARD_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["soulGuardList:array(com.sunweb.game.rpg.soulGuard.SoulGuardInfo)"];
      }
   }
}

