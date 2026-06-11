package com.sunweb.game.rpg.worldZone.command.success
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class WorldSuccessTimesRequest extends obf_O_8_1034
   {
      
      public function WorldSuccessTimesRequest()
      {
         super(CommandCodePlayerSuccess.WORLD_SUCCESS_TIMES_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

