package com.sunweb.game.rpg.worldZone.command.constellation
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PrayPlayerConstellationRequest extends obf_O_8_1034
   {
      
      public function PrayPlayerConstellationRequest()
      {
         super(CommandCodePlayerConstellation.PRAY_PLAYER_CONSTELLATION_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

