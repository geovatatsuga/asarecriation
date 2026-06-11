package com.sunweb.game.rpg.worldZone.command.constellation
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LuckChangeConstellationRequest extends obf_O_8_1034
   {
      
      public function LuckChangeConstellationRequest()
      {
         super(CommandCodePlayerConstellation.LUCK_CHANGE_CONSTELLATION_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

