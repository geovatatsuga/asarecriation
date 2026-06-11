package com.sunweb.game.rpg.worldZone.command.activity
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ActivityCheckAllNotify extends obf_O_8_1034
   {
      
      public var activities:Object;
      
      public function ActivityCheckAllNotify()
      {
         super(CommandCodeActivity.ACTIVITY_CHECK_ALL_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["activities:map(string,boolean)"];
      }
   }
}

