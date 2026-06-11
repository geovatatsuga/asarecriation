package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.family.FamilyMyInfo;
   
   public class PlayerFamilyMyInfoCheckNotify extends obf_O_8_1034
   {
      
      public var myInfo:FamilyMyInfo;
      
      public function PlayerFamilyMyInfoCheckNotify()
      {
         super(CommandCodePlayerFamily.PLAYER_FAMILY_MY_INFO_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["myInfo:com.sunweb.game.rpg.family.FamilyMyInfo"];
      }
   }
}

