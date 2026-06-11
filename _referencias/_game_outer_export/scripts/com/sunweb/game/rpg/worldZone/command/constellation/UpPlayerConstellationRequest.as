package com.sunweb.game.rpg.worldZone.command.constellation
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class UpPlayerConstellationRequest extends obf_O_8_1034
   {
      
      public function UpPlayerConstellationRequest()
      {
         super(CommandCodePlayerConstellation.UP_PLAYER_CONSTELLATION_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

