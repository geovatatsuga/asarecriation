package com.sunweb.game.rpg.playerBag
{
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   
   public class PlayerBagIndex
   {
      
      public static const PLAYER_DEPOT:int = 0;
      
      public static const PLAYER_MAIN_BAG:int = 1;
      
      public static const PLAYER_PET_BAG:int = 2;
      
      public static const PLAYER_RIDE_BAG:int = 3;
      
      public static const obf_5_R_2566:int = 4;
      
      public static const obf_d_C_2762:int = 5;
      
      public static const obf_6_c_1642:int = 6;
      
      public static const obf_w_y_3760:int = 7;
      
      public static const obf_G_r_1422:int = 8;
      
      public static const obf_S_A_4615:int = 9;
      
      public function PlayerBagIndex()
      {
         super();
      }
      
      public static function getBags(param1:int) : Array
      {
         var _loc2_:IIconItemUI = null;
         if(param1 == PlayerBagIndex.PLAYER_MAIN_BAG)
         {
            return obf_K_e_3075.playerBagUI.allBags;
         }
         if(param1 == PlayerBagIndex.PLAYER_PET_BAG)
         {
            return obf_K_e_3075.petBoxUI.getPetIconItemBags();
         }
         if(param1 == PlayerBagIndex.PLAYER_RIDE_BAG)
         {
            return obf_K_e_3075.rideBoxUI.rideBags;
         }
         if(param1 == PlayerBagIndex.PLAYER_DEPOT)
         {
            return obf_K_e_3075.depotBagUI.getIconItemBags();
         }
         if(param1 == PlayerBagIndex.obf_6_c_1642)
         {
            return obf_K_e_3075.depotTwoBagUI.getIconItemBags();
         }
         if(param1 == PlayerBagIndex.obf_G_r_1422)
         {
            return obf_K_e_3075.depotThreeBagUI.getIconItemBags();
         }
         if(param1 == PlayerBagIndex.obf_5_R_2566)
         {
            return obf_K_e_3075.genieBoxUI.getGenieBags();
         }
         if(param1 == PlayerBagIndex.obf_w_y_3760)
         {
            return obf_K_e_3075.playerDevilUI.getDevilBags();
         }
         if(param1 == PlayerBagIndex.obf_S_A_4615)
         {
            return obf_K_e_3075.tempBagUI.getIconItemBags();
         }
         return null;
      }
   }
}

