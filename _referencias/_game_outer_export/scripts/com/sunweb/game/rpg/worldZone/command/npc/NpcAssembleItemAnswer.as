package com.sunweb.game.rpg.worldZone.command.npc
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class NpcAssembleItemAnswer extends obf_O_8_1034
   {
      
      public var assembleRuleIndex:int;
      
      public var isSucceeded:Boolean;
      
      public function NpcAssembleItemAnswer()
      {
         super(CommandCodeNpc.NPC_ASSEMBLE_ITEM_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["assembleRuleIndex:ushort","isSucceeded:boolean"];
      }
   }
}

