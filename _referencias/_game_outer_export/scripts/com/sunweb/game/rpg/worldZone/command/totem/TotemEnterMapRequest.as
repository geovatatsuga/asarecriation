package com.sunweb.game.rpg.worldZone.command.totem
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class TotemEnterMapRequest extends obf_O_8_1034
   {
      
      public function TotemEnterMapRequest()
      {
         super(CommandCodePlayerTotem.TOTEM_ENTER_MAP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

