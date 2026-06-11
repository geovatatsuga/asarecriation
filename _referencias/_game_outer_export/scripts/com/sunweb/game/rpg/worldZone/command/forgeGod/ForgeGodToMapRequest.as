package com.sunweb.game.rpg.worldZone.command.forgeGod
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ForgeGodToMapRequest extends obf_O_8_1034
   {
      
      public function ForgeGodToMapRequest()
      {
         super(CommandCodeForgeGod.FORGE_GOD_TO_MAP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

