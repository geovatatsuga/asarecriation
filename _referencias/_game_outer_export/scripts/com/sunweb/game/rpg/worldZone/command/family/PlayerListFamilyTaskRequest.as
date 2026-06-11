package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerListFamilyTaskRequest extends obf_O_8_1034
   {
      
      public function PlayerListFamilyTaskRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_LIST_FAMILY_TASK_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

