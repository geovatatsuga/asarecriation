package com.sunweb.game.rpg.worldZone.command.player.vacantSpace
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class VacantSpaceBallUpRequest extends obf_O_8_1034
   {
      
      public var index:int;
      
      public function VacantSpaceBallUpRequest()
      {
         super(CommandCodeVacantSpace.VACANT_SPACE_BALL_UP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["index:byte"];
      }
   }
}

