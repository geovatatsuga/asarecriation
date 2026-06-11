package com.sunweb.game.rpg.worldZone.command.system
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.worldZone.command.CommandCodeWorld;
   
   public class WorldPVEMapsNotify extends obf_O_8_1034
   {
      
      public var pveMapIds:Array;
      
      public function WorldPVEMapsNotify()
      {
         super(CommandCodeWorld.WORLD_PVE_MAPS_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["pveMapIds:array(string)"];
      }
   }
}

