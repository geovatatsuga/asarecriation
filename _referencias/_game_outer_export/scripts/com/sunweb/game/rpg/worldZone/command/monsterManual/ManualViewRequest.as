package com.sunweb.game.rpg.worldZone.command.monsterManual
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ManualViewRequest extends obf_O_8_1034
   {
      
      public function ManualViewRequest()
      {
         super(CommandCodeMonsterManual.MANUAL_VIEW_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

