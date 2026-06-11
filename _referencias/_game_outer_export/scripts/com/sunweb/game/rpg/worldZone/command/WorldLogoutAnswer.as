package com.sunweb.game.rpg.worldZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class WorldLogoutAnswer extends obf_O_8_1034
   {
      
      public function WorldLogoutAnswer()
      {
         super(CommandCodeWorld.WORLD_LOGOUT_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

