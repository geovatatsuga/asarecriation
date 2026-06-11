package com.sunweb.game.rpg.worldZone.command.bless
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BlessStopRequest extends obf_O_8_1034
   {
      
      public function BlessStopRequest()
      {
         super(CommandCodeBless.BLESS_STOP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

