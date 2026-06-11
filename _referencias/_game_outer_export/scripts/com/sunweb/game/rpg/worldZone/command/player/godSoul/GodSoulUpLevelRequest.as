package com.sunweb.game.rpg.worldZone.command.player.godSoul
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class GodSoulUpLevelRequest extends obf_O_8_1034
   {
      
      public var soulType:int;
      
      public function GodSoulUpLevelRequest()
      {
         super(CommandPlayerGodSoul.GOD_SOUL_UP_LEVEL_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["soulType:ubyte"];
      }
   }
}

