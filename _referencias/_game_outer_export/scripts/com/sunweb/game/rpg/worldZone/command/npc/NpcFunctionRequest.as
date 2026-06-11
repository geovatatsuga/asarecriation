package com.sunweb.game.rpg.worldZone.command.npc
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class NpcFunctionRequest extends obf_O_8_1034
   {
      
      public var npcId:String;
      
      public var funcMenuFullIndex:Array;
      
      public function NpcFunctionRequest()
      {
         super(CommandCodeNpc.NPC_FUNCTION_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["npcId:string","funcMenuFullIndex:array(byte)"];
      }
   }
}

