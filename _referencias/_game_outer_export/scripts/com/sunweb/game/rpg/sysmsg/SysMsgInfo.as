package com.sunweb.game.rpg.sysmsg
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class SysMsgInfo extends obf_2_M_853
   {
      
      public var msgTime:String;
      
      public var msgContent:String;
      
      public function SysMsgInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["msgTime:string","msgContent:string"];
      }
   }
}

