package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.npc.CommandCodeNpc;
   
   public class NpcEvent
   {
      
      public static const NPC_ASSEMBLE_ITEM_ANSWER:String = CommandCodeNpc.NPC_ASSEMBLE_ITEM_ANSWER.toString(16);
      
      public static const NPC_Function_ANSWER:String = CommandCodeNpc.NPC_Function_ANSWER.toString(16);
      
      public function NpcEvent()
      {
         super();
      }
   }
}

