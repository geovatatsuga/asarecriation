package com.sunweb.game.rpg.gameItem
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import flash.display.DisplayObject;
   import img.ItemRankIconBlue;
   import img.ItemRankIconGreen;
   import img.ItemRankIconHoliness;
   import img.ItemRankIconOrange;
   import img.ItemRankIconPurple;
   import img.ItemRankIconYellow;
   
   public class GameItemRank
   {
      
      public static const NOMAL:int = 0;
      
      public static const MAGIC:int = 1;
      
      public static const FANTASY:int = 2;
      
      public static const LEGEND:int = 3;
      
      public static const EPIC:int = 4;
      
      public static const obf_f_l_943:int = 5;
      
      public static const obf_C_G_3598:int = 6;
      
      public function GameItemRank()
      {
         super();
      }
      
      public static function getRankName(param1:int, param2:Boolean = false) : String
      {
         if(!param2 && param1 == 0)
         {
            return "";
         }
         return DiversityManager.getString("ItemRankName",param1 + "");
      }
      
      public static function getRankColor(param1:int) : int
      {
         if(param1 == NOMAL)
         {
            return obf_0_3_0_538.ITEM_RANK_NOMAL;
         }
         if(param1 == MAGIC)
         {
            return obf_0_3_0_538.obf_o_2_4266;
         }
         if(param1 == FANTASY)
         {
            return obf_0_3_0_538.obf_W_x_3750;
         }
         if(param1 == LEGEND)
         {
            return obf_0_3_0_538.obf_I_Z_1269;
         }
         if(param1 == EPIC)
         {
            return obf_0_3_0_538.obf_T_N_2235;
         }
         if(param1 == obf_f_l_943)
         {
            return obf_0_3_0_538.obf_P_E_4108;
         }
         if(param1 == obf_C_G_3598)
         {
            return obf_0_3_0_538.obf_H_U_3664;
         }
         return obf_0_3_0_538.ITEM_RANK_NOMAL;
      }
      
      public static function getRankIcon(param1:int) : DisplayObject
      {
         if(param1 != NOMAL)
         {
            if(param1 == MAGIC)
            {
               return new ItemRankIconGreen();
            }
            if(param1 == FANTASY)
            {
               return new ItemRankIconBlue();
            }
            if(param1 == LEGEND)
            {
               return new ItemRankIconYellow();
            }
            if(param1 == EPIC)
            {
               return new ItemRankIconPurple();
            }
            if(param1 == obf_f_l_943)
            {
               return new ItemRankIconOrange();
            }
            if(param1 == obf_C_G_3598)
            {
               return new ItemRankIconHoliness();
            }
         }
         return null;
      }
   }
}

