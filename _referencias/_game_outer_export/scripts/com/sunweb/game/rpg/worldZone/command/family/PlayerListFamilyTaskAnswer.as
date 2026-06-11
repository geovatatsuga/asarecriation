package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerListFamilyTaskAnswer extends obf_O_8_1034
   {
      
      public var familyTaskList:Array;
      
      public function PlayerListFamilyTaskAnswer()
      {
         super(CommandCodePlayerFamily.PLAYER_LIST_FAMILY_TASK_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["familyTaskList:array(com.sunweb.game.rpg.family.FamilyTaskInfo)"];
      }
   }
}

