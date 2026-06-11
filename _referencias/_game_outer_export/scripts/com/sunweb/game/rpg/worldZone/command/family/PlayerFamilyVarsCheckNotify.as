package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.script.DynamicVars;
   
   public class PlayerFamilyVarsCheckNotify extends obf_O_8_1034
   {
      
      public var familyVars:DynamicVars;
      
      public function PlayerFamilyVarsCheckNotify()
      {
         super(CommandCodePlayerFamily.PLAYER_FAMILY_VARS_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["familyVars:com.sunweb.game.rpg.script.DynamicVars"];
      }
   }
}

