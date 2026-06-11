package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerViewFamilyPostAnswer extends obf_O_8_1034
   {
      
      public var postNameList:Array;
      
      public function PlayerViewFamilyPostAnswer()
      {
         super(CommandCodePlayerFamily.PLAYER_VIEW_FAMILY_POST_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["postNameList:array(string)"];
      }
   }
}

