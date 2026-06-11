package com.sunweb.game.rpg.playingCard
{
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import flash.display.DisplayObject;
   import img.cardIconBlue;
   import img.cardIconGreen;
   import img.cardIconOrange;
   import img.cardIconPurple;
   import img.cardIconWhite;
   import img.cardIconYellow;
   
   public class CardFaceKind
   {
      
      public static const F_WHITE:int = 0;
      
      public static const F_GREEN:int = 1;
      
      public static const F_BLUE:int = 2;
      
      public static const F_YELLOW:int = 3;
      
      public static const F_PURPLE:int = 4;
      
      public static const F_ORANGE:int = 5;
      
      public function CardFaceKind()
      {
         super();
      }
      
      public static function getCardColor(param1:int) : int
      {
         if(param1 == F_WHITE)
         {
            return obf_0_3_0_538.ITEM_RANK_NOMAL;
         }
         if(param1 == F_GREEN)
         {
            return obf_0_3_0_538.obf_o_2_4266;
         }
         if(param1 == F_BLUE)
         {
            return obf_0_3_0_538.obf_W_x_3750;
         }
         if(param1 == F_YELLOW)
         {
            return obf_0_3_0_538.obf_I_Z_1269;
         }
         if(param1 == F_PURPLE)
         {
            return obf_0_3_0_538.obf_T_N_2235;
         }
         if(param1 == F_ORANGE)
         {
            return obf_0_3_0_538.obf_P_E_4108;
         }
         return obf_0_3_0_538.ITEM_RANK_NOMAL;
      }
      
      public static function getCardIcon(param1:int) : DisplayObject
      {
         if(param1 != F_WHITE)
         {
            if(param1 == F_GREEN)
            {
               return new cardIconGreen();
            }
            if(param1 == F_BLUE)
            {
               return new cardIconBlue();
            }
            if(param1 == F_YELLOW)
            {
               return new cardIconYellow();
            }
            if(param1 == F_PURPLE)
            {
               return new cardIconPurple();
            }
            if(param1 == F_ORANGE)
            {
               return new cardIconOrange();
            }
         }
         return new cardIconWhite();
      }
   }
}

