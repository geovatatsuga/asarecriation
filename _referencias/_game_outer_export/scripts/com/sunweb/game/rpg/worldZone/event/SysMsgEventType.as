package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.sysmsg.CommandCodeSysMsg;
   
   public class SysMsgEventType
   {
      
      public static const SYSMSG_NEW_NOTIFY:String = CommandCodeSysMsg.SYSMSG_NEW_NOTIFY.toString(16);
      
      public static const SYSMSG_VIEW_ANSWER:String = CommandCodeSysMsg.SYSMSG_VIEW_ANSWER.toString(16);
      
      public function SysMsgEventType()
      {
         super();
      }
   }
}

