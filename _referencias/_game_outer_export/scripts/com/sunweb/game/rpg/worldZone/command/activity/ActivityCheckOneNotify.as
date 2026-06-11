package com.sunweb.game.rpg.worldZone.command.activity
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ActivityCheckOneNotify extends obf_O_8_1034
   {
      
      public var activityCode:String;
      
      public var isActive:Boolean;
      
      public function ActivityCheckOneNotify()
      {
         super(CommandCodeActivity.ACTIVITY_CHECK_ONE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["activityCode:string","isActive:boolean"];
      }
   }
}

