package com.sunweb.game.rpg.agent
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class AgentItemInfo extends obf_2_M_853
   {
      
      public var agentRecId:int;
      
      public var itemId:String;
      
      public var itemCode:String;
      
      public var itemCount:int;
      
      public var price:int;
      
      public var state:int;
      
      public var waitTimeInSec:int;
      
      public function AgentItemInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["agentRecId:int","itemId:string","itemCode:string","itemCount:ubyte","price:int","state:byte","waitTimeInSec:ushort"];
      }
   }
}

