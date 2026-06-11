package com.sunweb.game.rpg.worldZone.command.player.vacantSpace
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.vacantSpace.VacantSpaceBallInfo;
   
   public class VacantSpaceBallUpAnswer extends obf_O_8_1034
   {
      
      public var index:int;
      
      public var ballInfo:VacantSpaceBallInfo;
      
      public function VacantSpaceBallUpAnswer()
      {
         super(CommandCodeVacantSpace.VACANT_SPACE_BALL_UP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["index:byte","ballInfo:com.sunweb.game.rpg.vacantSpace.VacantSpaceBallInfo"];
      }
   }
}

