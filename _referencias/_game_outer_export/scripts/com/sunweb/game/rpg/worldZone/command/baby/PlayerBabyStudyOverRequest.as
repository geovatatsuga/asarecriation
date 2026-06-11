package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyStudyOverRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public var area:int;
      
      public function PlayerBabyStudyOverRequest()
      {
         super(CommandCodeBaby.PLAYER_BABY_STUDY_OVER_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","area:ubyte"];
      }
   }
}

