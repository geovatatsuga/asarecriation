package com.sunweb.game.rpg.worldZone.command.player.vacantSpace
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class VacantSpaceInfoNotify extends obf_O_8_1034
   {
      
      public var ballInfos:Object;
      
      public function VacantSpaceInfoNotify()
      {
         super(CommandCodeVacantSpace.VACANT_SPACE_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["ballInfos:map(byte,com.sunweb.game.rpg.vacantSpace.VacantSpaceBallInfo)"];
      }
   }
}

