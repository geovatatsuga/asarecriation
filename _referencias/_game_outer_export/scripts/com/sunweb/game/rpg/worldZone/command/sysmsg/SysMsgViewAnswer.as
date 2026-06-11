package com.sunweb.game.rpg.worldZone.command.sysmsg
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class SysMsgViewAnswer extends obf_O_8_1034
   {
      
      public var pageIndex:int;
      
      public var msgList:Array;
      
      public function SysMsgViewAnswer()
      {
         super(CommandCodeSysMsg.SYSMSG_VIEW_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["pageIndex:byte","msgList:array(com.sunweb.game.rpg.sysmsg.SysMsgInfo)"];
      }
   }
}

