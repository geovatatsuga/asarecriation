package com.sunweb.game.rpg.worldZone.command.agent
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class AgentListItemRequest extends obf_O_8_1034
   {
      
      public var npcId:String;
      
      public var funcMenuFullIndex:Array;
      
      public var queryItemSubtype:int;
      
      public var queryItemName:String;
      
      public var pageNo:int;
      
      public function AgentListItemRequest()
      {
         super(CommandCodeAgent.AGENT_LIST_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["npcId:string","funcMenuFullIndex:array(byte)","queryItemSubtype:ushort","queryItemName:string","pageNo:short"];
      }
   }
}

