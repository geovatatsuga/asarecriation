package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyStudyAnswer extends obf_O_8_1034
   {
      
      public var studyArea:int;
      
      public var studyOver:Object;
      
      public var collegeMap:Object;
      
      public function PlayerBabyStudyAnswer()
      {
         super(CommandCodeBaby.PLAYER_BABY_STUDY_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["studyArea:ubyte","studyOver:map(ubyte,int)","collegeMap:map(ubyte,ubyte)"];
      }
   }
}

