package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyStudyRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public var area:int;
      
      public function PlayerBabyStudyRequest()
      {
         super(CommandCodeBaby.PLAYER_BABY_STUDY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","area:ubyte"];
      }
   }
}

