package com.sunweb.game.rpg.worldZone.command.mate
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerMateVarClearNotify extends obf_O_8_1034
   {
      
      public var boolVars:Array;
      
      public var intVars:Array;
      
      public function PlayerMateVarClearNotify()
      {
         super(CommandCodePlayerMate.PLAYER_MATE_VAR_CLEAR_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["boolVars:array(string)","intVars:array(string)"];
      }
   }
}

