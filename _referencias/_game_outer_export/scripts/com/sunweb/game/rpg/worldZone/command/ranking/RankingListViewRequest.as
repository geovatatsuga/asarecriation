package com.sunweb.game.rpg.worldZone.command.ranking
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RankingListViewRequest extends obf_O_8_1034
   {
      
      public var npcId:String;
      
      public var funcMenuFullIndex:Array;
      
      public var rankingListType:int;
      
      public function RankingListViewRequest()
      {
         super(CommandCodeRanking.RANKING_LIST_VIEW_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["npcId:string","funcMenuFullIndex:array(byte)","rankingListType:byte"];
      }
   }
}

