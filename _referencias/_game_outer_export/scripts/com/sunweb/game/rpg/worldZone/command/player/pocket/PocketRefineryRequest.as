package com.sunweb.game.rpg.worldZone.command.player.pocket
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PocketRefineryRequest extends obf_O_8_1034
   {
      
      public function PocketRefineryRequest()
      {
         super(CommandPlayerPocket.POCKET_REFINERY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

