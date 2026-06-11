package com.sunweb.game.rpg.worldZone.command.sysmsg
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class SysMsgViewRequest extends obf_O_8_1034
   {
      
      public var pageIndex:int;
      
      public function SysMsgViewRequest()
      {
         super(CommandCodeSysMsg.SYSMSG_VIEW_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["pageIndex:byte"];
      }
   }
}

