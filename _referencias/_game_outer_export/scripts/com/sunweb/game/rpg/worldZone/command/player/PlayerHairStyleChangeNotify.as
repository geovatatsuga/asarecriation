package com.sunweb.game.rpg.worldZone.command.player
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerHairStyleChangeNotify extends obf_O_8_1034
   {
      
      public var hairStyleIndex:int;
      
      public function PlayerHairStyleChangeNotify()
      {
         super(CommandCodePlayer.PLAYER_HAIR_STYLE_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["hairStyleIndex:ubyte"];
      }
   }
}

