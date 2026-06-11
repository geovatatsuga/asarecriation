package com.sunweb.game.rpg.worldZone.command.soulGuard
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.soulGuard.SoulGuardInfo;
   
   public class SoulGuardUpAnswer extends obf_O_8_1034
   {
      
      public var isSuccess:Boolean;
      
      public var info:SoulGuardInfo;
      
      public function SoulGuardUpAnswer()
      {
         super(CommandCodeSoulGuard.SOUL_GUARD_UP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["isSuccess:boolean","info:com.sunweb.game.rpg.soulGuard.SoulGuardInfo"];
      }
   }
}

