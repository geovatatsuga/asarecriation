package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFamilyVarClearNotify extends obf_O_8_1034
   {
      
      public var boolVars:Array;
      
      public var intVars:Array;
      
      public function PlayerFamilyVarClearNotify()
      {
         super(CommandCodePlayerFamily.PLAYER_FAMILY_VAR_CLEAR_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["boolVars:array(string)","intVars:array(string)"];
      }
   }
}

