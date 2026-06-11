package com.sunweb.game.rpg.worldZone.command.soulGuard
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.soulGuard.SoulGuardInfo;
   
   public class SoulBlessUpAnswer extends obf_O_8_1034
   {
      
      public var info:SoulGuardInfo;
      
      public function SoulBlessUpAnswer()
      {
         super(CommandCodeSoulGuard.SOUL_BLESS_UP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["info:com.sunweb.game.rpg.soulGuard.SoulGuardInfo"];
      }
   }
}

