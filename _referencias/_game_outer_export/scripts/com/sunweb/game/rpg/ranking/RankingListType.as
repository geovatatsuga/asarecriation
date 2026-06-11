package com.sunweb.game.rpg.ranking
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class RankingListType
   {
      
      private static var rankArr:Array;
      
      private static var obf_O_C_1481:Array;
      
      public static const ROLE_LEVEL:int = 0;
      
      public static const GOLD:int = 1;
      
      public static const PK_VALUE:int = 2;
      
      public static const obf_p_n_4458:int = 3;
      
      public static const obf_1_s_2043:int = 4;
      
      public static const obf_k_Z_3393:int = 6;
      
      public static const obf_T_b_4228:int = 50;
      
      public static const obf_1_X_3884:int = 51;
      
      public static const obf_b_D_2481:int = 52;
      
      public static const obf_J_I_1570:int = 99;
      
      public static const obf_g_g_3050:int = 100;
      
      public static const obf_B_4646:int = 1000;
      
      public function RankingListType()
      {
         super();
      }
      
      public static function getRankingTypeName(param1:int) : String
      {
         var _loc2_:Object = {
            (ROLE_LEVEL + ""):DiversityManager.getString("RankingUI","type_PlayerLevel"),
            (GOLD + ""):DiversityManager.getString("RankingUI","type_Gold"),
            (PK_VALUE + ""):DiversityManager.getString("RankingUI","type_BadPlayer"),
            (obf_p_n_4458 + ""):DiversityManager.getString("RankingUI","type_Honor"),
            (obf_1_s_2043 + ""):DiversityManager.getString("RankingUI","type_Ladder"),
            (obf_J_I_1570 + ""):DiversityManager.getString("RankingUI","type_army"),
            (obf_T_b_4228 + ""):DiversityManager.getString("RankingUI","type_oneplayer"),
            (obf_1_X_3884 + ""):DiversityManager.getString("RankingUI","type_twoplayer"),
            (obf_b_D_2481 + ""):DiversityManager.getString("RankingUI","type_fiveplayer"),
            (obf_k_Z_3393 + ""):DiversityManager.getString("RankingUI","type_Arena")
         };
         return _loc2_[param1 + ""];
      }
      
      public static function getTankingBigKind(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return DiversityManager.getString("RankingUI","type_player");
            case 1:
               return DiversityManager.getString("RankingUI","type_map");
            case 2:
               return DiversityManager.getString("RankingUI","type_arena");
            case 3:
               return DiversityManager.getString("RankingUI","type_challenge");
            default:
               return "";
         }
      }
      
      public static function getfinallyRanking(param1:String) : Array
      {
         switch(param1)
         {
            case DiversityManager.getString("RankingUI","type_player"):
               return getgetRankingPlayerArr();
            case DiversityManager.getString("RankingUI","type_map"):
               return rankArr;
            case DiversityManager.getString("RankingUI","type_arena"):
               return getRankingArenaArr();
            case DiversityManager.getString("RankingUI","type_challenge"):
               return obf_O_C_1481;
            default:
               return [];
         }
      }
      
      private static function getgetRankingPlayerArr() : Array
      {
         return [{
            "id":ROLE_LEVEL,
            "label":getRankingTypeName(ROLE_LEVEL)
         },{
            "id":GOLD,
            "label":getRankingTypeName(GOLD)
         },{
            "id":PK_VALUE,
            "label":getRankingTypeName(PK_VALUE)
         },{
            "id":obf_p_n_4458,
            "label":getRankingTypeName(obf_p_n_4458)
         },{
            "id":obf_1_s_2043,
            "label":getRankingTypeName(obf_1_s_2043)
         }];
      }
      
      public static function getRankingMapArr(param1:Array) : void
      {
         rankArr = param1;
      }
      
      private static function getRankingArenaArr() : Array
      {
         return [{
            "id":obf_T_b_4228,
            "label":getRankingTypeName(obf_T_b_4228)
         },{
            "id":obf_1_X_3884,
            "label":getRankingTypeName(obf_1_X_3884)
         },{
            "id":obf_b_D_2481,
            "label":getRankingTypeName(obf_b_D_2481)
         }];
      }
      
      public static function getChallengeArr(param1:Array) : void
      {
         obf_O_C_1481 = param1;
      }
   }
}

