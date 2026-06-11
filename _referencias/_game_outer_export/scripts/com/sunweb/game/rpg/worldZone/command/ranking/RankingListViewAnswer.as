package com.sunweb.game.rpg.worldZone.command.ranking
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RankingListViewAnswer extends obf_O_8_1034
   {
      
      public var rankingListType:int;
      
      public var rankingList:Array;
      
      public function RankingListViewAnswer()
      {
         super(CommandCodeRanking.RANKING_LIST_VIEW_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["rankingListType:byte","rankingList:array(com.sunweb.game.rpg.ranking.RankingInfo)"];
      }
   }
}

