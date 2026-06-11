package com.sunweb.game.rpg.worldZone.command.Christmas
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerChristmasDrawAnswer extends obf_O_8_1034
   {
      
      public var items:Array;
      
      public function PlayerChristmasDrawAnswer()
      {
         super(CommandCodePlayerGame.PLAYER_CHRISTMAS_DRAW_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["items:array(com.sunweb.game.rpg.gameItem.GameItemBriefInfo)"];
      }
   }
}

