package com.sunweb.game.rpg.worldZone.command.wardrobe
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class WardrobeUplevelRequest extends obf_O_8_1034
   {
      
      public function WardrobeUplevelRequest()
      {
         super(CommandCodeWardrobe.WARDRODE_UPLEVEL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

