package com.sunweb.game.rpg.gameItem
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class GameItemSubtype
   {
      
      public static const EXPENDABLE_FARM_SEED:int = 257;
      
      public static const EXPENDABLE_FARM_BUILDING:int = 258;
      
      public static const obf_W_o_4335:int = 259;
      
      public static const EXPENDABLE_DRUG:int = 260;
      
      public static const obf_z_W_2499:int = 261;
      
      public static const obf_0___8_185:int = 262;
      
      public static const COLLECTION_FARM_PRODUCT:int = 513;
      
      public static const COLLECTION_MATERIAL:int = 514;
      
      public static const COLLECTION_GEM:int = 515;
      
      public static const COLLECTION_QUEST:int = 516;
      
      public static const COLLECTION_OTHER:int = 517;
      
      public static const obf_L_j_4553:int = 518;
      
      public static const EQUIPMENT_WEAPON:int = 1024;
      
      public static const EQUIPMENT_SHIELD:int = 1025;
      
      public static const EQUIPMENT_CLOTHES:int = 1026;
      
      public static const EQUIPMENT_HAT:int = 1027;
      
      public static const EQUIPMENT_WING:int = 1028;
      
      public static const EQUIPMENT_SHOES:int = 1031;
      
      public static const EQUIPMENT_GLOVE:int = 1032;
      
      public static const EQUIPMENT_RING:int = 1033;
      
      public static const EQUIPMENT_AMULET:int = 1034;
      
      public static const EQUIPMENT_ACCESSORY:int = 1035;
      
      public static const obf_e_i_1884:int = 1036;
      
      public static const obf_s_2_3291:int = 1037;
      
      public static const obf_H_m_3421:int = 1038;
      
      public static const obf_7_3856:int = 1039;
      
      public static const EQUIPMENT_FASHION_CLOTHES:int = 1126;
      
      public static const EQUIPMENT_FASHION_HAT:int = 1127;
      
      public static const EQUIPMENT_FASHION_WING:int = 1128;
      
      public static const obf_8_e_4404:int = 1184;
      
      public static const PET_EQUIPMENT_WEAPON:int = 1225;
      
      public static const PET_EQUIPMENT_CLOTHES:int = 1226;
      
      public static const PET_EQUIPMENT_RING:int = 1227;
      
      public static const PET_EQUIPMENT_SOUL:int = 1228;
      
      public static const obf_A_8_4141:int = 1135;
      
      public static const obf_6_F_1556:int = 1136;
      
      public static const obf_u_r_1074:int = 1137;
      
      public static const obf_a_H_4017:int = 1138;
      
      public static const PET_HUMAN:int = 2049;
      
      public static const PET_NATURE:int = 2050;
      
      public static const PET_DEMON:int = 2051;
      
      public static const PET_ELEMENT:int = 2052;
      
      public static const PET_UNDEAD:int = 2053;
      
      public static const PET_GOD:int = 2054;
      
      public static const RIDE_FLY:int = 4097;
      
      public static const RIDE_RIDE:int = 4098;
      
      public static const obf_U_1_4174:int = 8193;
      
      public static const obf_0_7_4_675:int = 32769;
      
      public function GameItemSubtype()
      {
         super();
      }
      
      public static function getSubTypeName(param1:int) : String
      {
         var _loc2_:Object = {
            (EXPENDABLE_FARM_SEED + ""):DiversityManager.getString("ItemSubTypeName","expendable_farm_seed"),
            (EXPENDABLE_FARM_BUILDING + ""):DiversityManager.getString("ItemSubTypeName","expendable_farm_building"),
            (obf_W_o_4335 + ""):DiversityManager.getString("ItemSubTypeName","expendable_farm_article"),
            (EXPENDABLE_DRUG + ""):DiversityManager.getString("ItemSubTypeName","expendable_drug"),
            (obf_z_W_2499 + ""):DiversityManager.getString("ItemSubTypeName","expendable_misc"),
            (obf_0___8_185 + ""):DiversityManager.getString("ItemSubTypeName","expendable_quest"),
            (COLLECTION_FARM_PRODUCT + ""):DiversityManager.getString("ItemSubTypeName","collection_farm_product"),
            (COLLECTION_MATERIAL + ""):DiversityManager.getString("ItemSubTypeName","collection_material"),
            (COLLECTION_GEM + ""):DiversityManager.getString("ItemSubTypeName","collection_gem"),
            (COLLECTION_QUEST + ""):DiversityManager.getString("ItemSubTypeName","collection_quest"),
            (COLLECTION_OTHER + ""):DiversityManager.getString("ItemSubTypeName","collection_other"),
            (obf_L_j_4553 + ""):DiversityManager.getString("ItemSubTypeName","collection_tally"),
            (EQUIPMENT_WEAPON + ""):DiversityManager.getString("ItemSubTypeName","equipment_weapon"),
            (EQUIPMENT_SHIELD + ""):DiversityManager.getString("ItemSubTypeName","equipment_shield"),
            (EQUIPMENT_CLOTHES + ""):DiversityManager.getString("ItemSubTypeName","equipment_clothes"),
            (EQUIPMENT_HAT + ""):DiversityManager.getString("ItemSubTypeName","equipment_hat"),
            (obf_H_m_3421 + ""):DiversityManager.getString("ItemSubTypeName","equipment_banner"),
            (obf_7_3856 + ""):DiversityManager.getString("ItemSubTypeName","equipment_cloak"),
            (EQUIPMENT_WING + ""):DiversityManager.getString("ItemSubTypeName","equipment_wing"),
            (EQUIPMENT_SHOES + ""):DiversityManager.getString("ItemSubTypeName","equipment_shoes"),
            (EQUIPMENT_GLOVE + ""):DiversityManager.getString("ItemSubTypeName","equipment_glove"),
            (EQUIPMENT_RING + ""):DiversityManager.getString("ItemSubTypeName","equipment_ring"),
            (EQUIPMENT_AMULET + ""):DiversityManager.getString("ItemSubTypeName","equipment_amulet"),
            (EQUIPMENT_ACCESSORY + ""):DiversityManager.getString("ItemSubTypeName","equipment_accessory"),
            (obf_e_i_1884 + ""):DiversityManager.getString("ItemSubTypeName","equipment_medal"),
            (obf_s_2_3291 + ""):DiversityManager.getString("ItemSubTypeName","equipment_soul"),
            (EQUIPMENT_FASHION_CLOTHES + ""):DiversityManager.getString("ItemSubTypeName","equipment_fashion_clothes"),
            (EQUIPMENT_FASHION_HAT + ""):DiversityManager.getString("ItemSubTypeName","equipment_fashion_hat"),
            (EQUIPMENT_FASHION_WING + ""):DiversityManager.getString("ItemSubTypeName","equipment_fashion_wing"),
            (obf_8_e_4404 + ""):DiversityManager.getString("ItemSubTypeName","equipment_tally"),
            (PET_EQUIPMENT_WEAPON + ""):DiversityManager.getString("ItemSubTypeName","PET_EQUIPMENT_WEAPON"),
            (PET_EQUIPMENT_SOUL + ""):DiversityManager.getString("ItemSubTypeName","PET_EQUIPMENT_SOUL"),
            (PET_EQUIPMENT_CLOTHES + ""):DiversityManager.getString("ItemSubTypeName","PET_EQUIPMENT_CLOTHES"),
            (PET_EQUIPMENT_RING + ""):DiversityManager.getString("ItemSubTypeName","PET_EQUIPMENT_RING"),
            (PET_HUMAN + ""):DiversityManager.getString("ItemSubTypeName","pet_human"),
            (PET_NATURE + ""):DiversityManager.getString("ItemSubTypeName","pet_nature"),
            (PET_DEMON + ""):DiversityManager.getString("ItemSubTypeName","pet_demon"),
            (PET_ELEMENT + ""):DiversityManager.getString("ItemSubTypeName","pet_element"),
            (PET_UNDEAD + ""):DiversityManager.getString("ItemSubTypeName","pet_undead"),
            (PET_GOD + ""):DiversityManager.getString("ItemSubTypeName","pet_god"),
            (RIDE_FLY + ""):DiversityManager.getString("ItemSubTypeName","ride_fly"),
            (RIDE_RIDE + ""):DiversityManager.getString("ItemSubTypeName","ride_ride"),
            (obf_U_1_4174 + ""):DiversityManager.getString("ItemSubTypeName","genie_genie"),
            (obf_0_7_4_675 + ""):DiversityManager.getString("ItemSubTypeName","devil_devil")
         };
         return _loc2_[param1] || "";
      }
   }
}

