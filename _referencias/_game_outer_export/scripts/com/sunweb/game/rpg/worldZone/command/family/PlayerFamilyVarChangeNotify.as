package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFamilyVarChangeNotify extends obf_O_8_1034
   {
      
      public var boolVars:Object;
      
      public var intVars:Object;
      
      public function PlayerFamilyVarChangeNotify()
      {
         super(CommandCodePlayerFamily.PLAYER_FAMILY_VAR_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["boolVars:map(string,boolean)","intVars:map(string,int)"];
      }
   }
}

