package com.sunweb.game.rpg.worldZone.command.country
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerWillsNotify extends obf_O_8_1034
   {
      
      public var wills:int;
      
      public function PlayerWillsNotify()
      {
         super(CommandCodePlayerCountry.PLAYER_WILLS_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["wills:int"];
      }
   }
}

