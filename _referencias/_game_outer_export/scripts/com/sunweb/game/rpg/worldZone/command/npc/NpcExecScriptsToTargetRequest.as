package com.sunweb.game.rpg.worldZone.command.npc
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class NpcExecScriptsToTargetRequest extends obf_O_8_1034
   {
      
      public var npcId:String;
      
      public var funcMenuFullIndex:Array;
      
      public var targetPlayerId:String;
      
      public function NpcExecScriptsToTargetRequest()
      {
         super(CommandCodeNpc.NPC_EXEC_SCRIPTS_TO_TARGET_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["npcId:string","funcMenuFullIndex:array(byte)","targetPlayerId:string"];
      }
   }
}

