package com.sunweb.game.rpg.worldZone.command.makeChip
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FreeGetBadKeyRequest extends obf_O_8_1034
   {
      
      public function FreeGetBadKeyRequest()
      {
         super(CommandCodeMakeChip.FREE_GET_BAD_KEY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

