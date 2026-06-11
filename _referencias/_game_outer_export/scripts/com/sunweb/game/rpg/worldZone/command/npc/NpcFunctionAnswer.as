package com.sunweb.game.rpg.worldZone.command.npc
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class NpcFunctionAnswer extends obf_O_8_1034
   {
      
      public var npcFullId:String;
      
      public function NpcFunctionAnswer()
      {
         super(CommandCodeNpc.NPC_Function_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["npcFullId:string"];
      }
   }
}

