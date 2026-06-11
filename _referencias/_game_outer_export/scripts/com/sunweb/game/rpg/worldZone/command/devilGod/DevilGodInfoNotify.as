package com.sunweb.game.rpg.worldZone.command.devilGod
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class DevilGodInfoNotify extends obf_O_8_1034
   {
      
      public var devilGodLevel:int;
      
      public var devilGodGrow:int;
      
      public var devilGodPower:int;
      
      public function DevilGodInfoNotify()
      {
         super(CommandCodeDevilGod.DEVIL_GOD_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["devilGodLevel:ubyte","devilGodGrow:int","devilGodPower:int"];
      }
   }
}

