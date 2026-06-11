package com.sunweb.game.rpg.worldZone.command.system
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.CommandCodeWorld;
   
   public class WorldTimeCheckNotify extends obf_O_8_1034
   {
      
      public var serverDate:String;
      
      public var serverTime:String;
      
      public function WorldTimeCheckNotify()
      {
         super(CommandCodeWorld.WORLD_TIME_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["serverDate:string","serverTime:string"];
      }
   }
}

