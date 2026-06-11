package com.sunweb.game.rpg.equ
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   
   public class EquipmentKind
   {
      
      public static const WEAPON:int = 0;
      
      public static const SHIELD:int = 1;
      
      public static const CLOTHES:int = 2;
      
      public static const HAT:int = 3;
      
      public static const WING:int = 4;
      
      public static const HAIR:int = 5;
      
      public static const FACE:int = 6;
      
      public static const SHOES:int = 7;
      
      public static const GLOVE:int = 8;
      
      public static const RING:int = 9;
      
      public static const AMULET:int = 10;
      
      public static const ACCESSORY:int = 11;
      
      public static const obf_s_Y_1219:int = 12;
      
      public static const obf_m_S_4609:int = 13;
      
      public static const obf_8_L_1856:int = 14;
      
      public static const obf_i_3_4546:int = 15;
      
      public static const obf_d_p_4239:int = 21;
      
      public static const obf_h_W_4446:int = 22;
      
      public static const obf_v_a_2182:int = 23;
      
      public static const FASHION_START_ID:int = 100;
      
      public static const FASHION_CLOTHES:int = 102;
      
      public static const FASHION_HAT:int = 103;
      
      public static const FASHION_WING:int = 104;
      
      public static const obf_u_U_4032:int = 110;
      
      public static const obf_A_8_4141:int = 111;
      
      public static const obf_6_F_1556:int = 112;
      
      public static const obf_u_r_1074:int = 113;
      
      public static const obf_a_H_4017:int = 114;
      
      public static const obf_e_Q_4273:int = 200;
      
      public static const obf_e_n_4302:int = 201;
      
      public static const obf_5_V_4088:int = 202;
      
      public static const obf_0_4_J_654:int = 203;
      
      public static const obf_Q_g_1533:int = 204;
      
      public function EquipmentKind()
      {
         super();
      }
      
      public static function getViewKindString(param1:int) : String
      {
         var _loc2_:Object = new Object();
         _loc2_[WEAPON] = "weapon";
         _loc2_[SHIELD] = "shield";
         _loc2_[CLOTHES] = "clothes";
         _loc2_[HAT] = "hat";
         _loc2_[WING] = "wing";
         _loc2_[obf_8_L_1856] = "banner";
         _loc2_[obf_i_3_4546] = "cloak";
         _loc2_[FASHION_CLOTHES] = "clothes";
         _loc2_[FASHION_HAT] = "hat";
         _loc2_[FASHION_WING] = "wing";
         return _loc2_[param1];
      }
      
      public static function getKindName(param1:int) : String
      {
         var _loc2_:Array = [DiversityManager.getString("EquipmentKindName","weapon"),DiversityManager.getString("EquipmentKindName","shield"),DiversityManager.getString("EquipmentKindName","clothes"),DiversityManager.getString("EquipmentKindName","hat"),DiversityManager.getString("EquipmentKindName","wing"),DiversityManager.getString("EquipmentKindName","hair"),DiversityManager.getString("EquipmentKindName","face"),DiversityManager.getString("EquipmentKindName","shoes"),DiversityManager.getString("EquipmentKindName","glove"),DiversityManager.getString("EquipmentKindName","ring"),DiversityManager.getString("EquipmentKindName","amulet"),DiversityManager.getString("EquipmentKindName","accessory"),DiversityManager.getString("EquipmentKindName","medal"),DiversityManager.getString("EquipmentKindName","soul"),DiversityManager.getString("EquipmentKindName","banner"),DiversityManager.getString("EquipmentKindName","cloak")];
         var _loc3_:String = "";
         if(param1 > obf_e_Q_4273)
         {
            param1 -= obf_e_Q_4273;
            _loc3_ = DiversityManager.getString("EquipmentKindName","petEquipment");
         }
         else if(param1 > FASHION_START_ID)
         {
            param1 -= FASHION_START_ID;
            _loc3_ = DiversityManager.getString("EquipmentKindName","fashion");
         }
         if(param1 >= 0 && param1 < _loc2_.length)
         {
            _loc3_ += _loc2_[param1];
         }
         return _loc3_;
      }
   }
}

