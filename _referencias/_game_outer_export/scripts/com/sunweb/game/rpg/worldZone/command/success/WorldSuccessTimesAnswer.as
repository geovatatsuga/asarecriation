package com.sunweb.game.rpg.worldZone.command.success
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class WorldSuccessTimesAnswer extends obf_O_8_1034
   {
      
      public var successTimes:Object;
      
      public function WorldSuccessTimesAnswer()
      {
         super(CommandCodePlayerSuccess.WORLD_SUCCESS_TIMES_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["successTimes:map(ushort,int)"];
      }
   }
}

