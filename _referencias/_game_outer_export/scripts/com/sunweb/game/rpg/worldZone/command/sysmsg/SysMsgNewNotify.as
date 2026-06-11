package com.sunweb.game.rpg.worldZone.command.sysmsg
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class SysMsgNewNotify extends obf_O_8_1034
   {
      
      public function SysMsgNewNotify()
      {
         super(CommandCodeSysMsg.SYSMSG_NEW_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

