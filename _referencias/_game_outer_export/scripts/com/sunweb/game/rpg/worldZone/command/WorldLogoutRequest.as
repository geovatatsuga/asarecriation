package com.sunweb.game.rpg.worldZone.command
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class WorldLogoutRequest extends obf_O_8_1034
   {
      
      public function WorldLogoutRequest()
      {
         super(CommandCodeWorld.WORLD_LOGOUT_REQ);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

