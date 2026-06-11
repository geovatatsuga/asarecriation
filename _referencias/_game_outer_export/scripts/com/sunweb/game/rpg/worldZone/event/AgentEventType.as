package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.agent.CommandCodeAgent;
   
   public class AgentEventType
   {
      
      public static const AGENT_LIST_ITEM_ANSWER:String = CommandCodeAgent.AGENT_LIST_ITEM_ANSWER.toString(16);
      
      public static const AGENT_VIEW_MY_ITEMS_ANSWER:String = CommandCodeAgent.AGENT_VIEW_MY_ITEMS_ANSWER.toString(16);
      
      public function AgentEventType()
      {
         super();
      }
   }
}

