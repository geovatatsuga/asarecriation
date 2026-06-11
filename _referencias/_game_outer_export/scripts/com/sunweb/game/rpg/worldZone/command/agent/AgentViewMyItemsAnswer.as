package com.sunweb.game.rpg.worldZone.command.agent
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class AgentViewMyItemsAnswer extends obf_O_8_1034
   {
      
      public var myItemList:Array;
      
      public function AgentViewMyItemsAnswer()
      {
         super(CommandCodeAgent.AGENT_VIEW_MY_ITEMS_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["myItemList:array(com.sunweb.game.rpg.agent.AgentItemInfo)"];
      }
   }
}

