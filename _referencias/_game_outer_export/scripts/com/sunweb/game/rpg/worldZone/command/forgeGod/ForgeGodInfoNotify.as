package com.sunweb.game.rpg.worldZone.command.forgeGod
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ForgeGodInfoNotify extends obf_O_8_1034
   {
      
      public var level:int;
      
      public var value:int;
      
      public function ForgeGodInfoNotify()
      {
         super(CommandCodeForgeGod.FORGE_GOD_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["level:int","value:int"];
      }
   }
}

