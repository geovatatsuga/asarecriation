package com.sunweb.game.rpg.worldZone.command.fateTurntable
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class StartTurntableRequest extends obf_O_8_1034
   {
      
      public function StartTurntableRequest()
      {
         super(CommandCodeFateTurntable.START_TURNTABLE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

