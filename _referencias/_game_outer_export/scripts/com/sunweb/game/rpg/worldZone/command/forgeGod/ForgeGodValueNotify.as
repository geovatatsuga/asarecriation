package com.sunweb.game.rpg.worldZone.command.forgeGod
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ForgeGodValueNotify extends obf_O_8_1034
   {
      
      public var value:int;
      
      public function ForgeGodValueNotify()
      {
         super(CommandCodeForgeGod.FORGE_GOD_VALUE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["value:int"];
      }
   }
}

