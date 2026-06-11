package com.sunweb.game.rpg.worldZone.command.totem
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class TotemUpLevelStageAnswer extends obf_O_8_1034
   {
      
      public var infoMap:Object;
      
      public function TotemUpLevelStageAnswer()
      {
         super(CommandCodePlayerTotem.TOTEM_UP_LEVEL_STAGE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["infoMap:map(ubyte,com.sunweb.game.rpg.totem.TotemInfo)"];
      }
   }
}

