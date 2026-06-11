package com.sunweb.game.rpg.worldZone.command.agent
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class AgentSellItemRequest extends obf_O_8_1034
   {
      
      public var npcId:String;
      
      public var funcMenuFullIndex:Array;
      
      public var bagIndex:int;
      
      public var itemIndex:int;
      
      public var price:int;
      
      public function AgentSellItemRequest()
      {
         super(CommandCodeAgent.AGENT_SELL_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["npcId:string","funcMenuFullIndex:array(byte)","bagIndex:byte","itemIndex:ubyte","price:int"];
      }
   }
}

