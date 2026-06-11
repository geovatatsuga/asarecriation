package com.sunweb.game.rpg.worldZone.command.Christmas
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerChristmasDrawRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public function PlayerChristmasDrawRequest()
      {
         super(CommandCodePlayerGame.PLAYER_CHRISTMAS_DRAW_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte"];
      }
   }
}

