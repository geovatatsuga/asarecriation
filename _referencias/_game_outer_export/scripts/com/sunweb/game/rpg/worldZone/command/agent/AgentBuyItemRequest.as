package com.sunweb.game.rpg.worldZone.command.agent
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class AgentBuyItemRequest extends obf_O_8_1034
   {
      
      public var npcId:String;
      
      public var funcMenuFullIndex:Array;
      
      public var agentRecId:int;
      
      public function AgentBuyItemRequest()
      {
         super(CommandCodeAgent.AGENT_BUY_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["npcId:string","funcMenuFullIndex:array(byte)","agentRecId:int"];
      }
   }
}

