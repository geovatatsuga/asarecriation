package com.sunweb.game.rpg.worldZone.command.system
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.CommandCodeWorld;
   
   public class WorldPingEcho extends obf_O_8_1034
   {
      
      public var timestamp:int;
      
      public function WorldPingEcho()
      {
         super(CommandCodeWorld.WORLD_PING_ECHO);
      }
      
      override public function getFieldList() : Array
      {
         return ["timestamp:int"];
      }
   }
}

