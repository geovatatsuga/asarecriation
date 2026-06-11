package com.sunweb.game.rpg.worldZone.command.totem
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class TotemUpLevelStageRequest extends obf_O_8_1034
   {
      
      public var totemType:int;
      
      public var type:int;
      
      public function TotemUpLevelStageRequest()
      {
         super(CommandCodePlayerTotem.TOTEM_UP_LEVEL_STAGE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["totemType:ubyte","type:ubyte"];
      }
   }
}

