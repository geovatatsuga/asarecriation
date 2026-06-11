package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFamilyBossCallNotify extends obf_O_8_1034
   {
      
      public var callMapID:String;
      
      public function PlayerFamilyBossCallNotify()
      {
         super(CommandCodePlayerFamily.PLAYER_FAMILY_BOSS_CALL_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["callMapID:string"];
      }
   }
}

