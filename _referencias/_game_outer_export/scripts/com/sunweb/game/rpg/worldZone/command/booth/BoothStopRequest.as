package com.sunweb.game.rpg.worldZone.command.booth
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BoothStopRequest extends obf_O_8_1034
   {
      
      public function BoothStopRequest()
      {
         super(CommandCodePlayerBooth.BOOTH_STOP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

