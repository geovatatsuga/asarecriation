package com.sunweb.game.rpg.ranking
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.map.clear.CommandCodeMapClear;
   import com.sunweb.game.rpg.worldZone.command.map.clear.MapClearRankingAnswer;
   import com.sunweb.game.rpg.worldZone.command.map.clear.MapClearRankingRequest;
   import com.sunweb.game.rpg.worldZone.command.ranking.CommandCodeRanking;
   import com.sunweb.game.rpg.worldZone.command.ranking.RankingListViewAnswer;
   import com.sunweb.game.rpg.worldZone.command.ranking.RankingListViewRequest;
   
   public class RankingManager
   {
      
      public function RankingManager()
      {
         super();
      }
      
      public static function sendViewRanking(param1:int, param2:String, param3:Array) : void
      {
         var _loc4_:RankingListViewRequest = new RankingListViewRequest();
         _loc4_.funcMenuFullIndex = param3;
         _loc4_.npcId = param2;
         _loc4_.rankingListType = param1;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeRanking.RANKING_LIST_VIEW_ANSWER)
         {
            obf_K_e_3075.rankingUI.getRankList((param1 as RankingListViewAnswer).rankingListType,(param1 as RankingListViewAnswer).rankingList);
         }
      }
      
      public static function sendCommand(param1:String, param2:int) : void
      {
         var _loc3_:MapClearRankingRequest = new MapClearRankingRequest();
         _loc3_.mapId = param1;
         _loc3_.num = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function obf_M_8_2091(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeMapClear.MAP_CLEAR_RANKING_ANSWER)
         {
            obf_K_e_3075.rankingUI.showChallengeRanking((param1 as MapClearRankingAnswer).mapId,(param1 as MapClearRankingAnswer).bestResultList);
         }
      }
   }
}

