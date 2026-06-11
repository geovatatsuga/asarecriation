package com.sunweb.game.rpg.worldZone.command.Christmas
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerChristmasValueNotify extends obf_O_8_1034
   {
      
      public var value:int;
      
      public function PlayerChristmasValueNotify()
      {
         super(CommandCodePlayerGame.PLAYER_CHRISTMAS_VALUE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["value:int"];
      }
   }
}

