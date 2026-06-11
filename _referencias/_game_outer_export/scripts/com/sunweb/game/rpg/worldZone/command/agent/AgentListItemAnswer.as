package com.sunweb.game.rpg.worldZone.command.agent
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class AgentListItemAnswer extends obf_O_8_1034
   {
      
      public var queryItemSubtype:int;
      
      public var queryItemName:String;
      
      public var pageNo:int;
      
      public var itemList:Array;
      
      public function AgentListItemAnswer()
      {
         super(CommandCodeAgent.AGENT_LIST_ITEM_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["queryItemSubtype:ushort","queryItemName:string","pageNo:short","itemList:array(com.sunweb.game.rpg.agent.AgentItemInfo)"];
      }
   }
}

