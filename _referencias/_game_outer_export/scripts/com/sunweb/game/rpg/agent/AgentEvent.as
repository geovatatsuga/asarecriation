package com.sunweb.game.rpg.agent
{
   import com.sunweb.game.rpg.playerUI.AgentItemUI;
   import flash.events.Event;
   
   public class AgentEvent extends Event
   {
      
      public static const CLICK_CONTROL:String = "ClickControl";
      
      public var itemUI:AgentItemUI;
      
      public function AgentEvent(param1:String)
      {
         super(param1,false,false);
      }
   }
}

