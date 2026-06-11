package com.sunweb.game.rpg.worldZone.command.agent
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class AgentCancelItemRequest extends obf_O_8_1034
   {
      
      public var npcId:String;
      
      public var funcMenuFullIndex:Array;
      
      public var agentRecId:int;
      
      public function AgentCancelItemRequest()
      {
         super(CommandCodeAgent.AGENT_CANCEL_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["npcId:string","funcMenuFullIndex:array(byte)","agentRecId:int"];
      }
   }
}

