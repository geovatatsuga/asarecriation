package com.sunweb.game.rpg.role.action
{
   public class obf_S_c_3330
   {
      
      public static const obf_r_q_3113:String = "stand";
      
      public static const obf_R_z_4156:String = "standx";
      
      public static const obf_0_3_U_524:String = "sit";
      
      public static const obf_h_4_3537:String = "walk";
      
      public static const obf_X_6_4123:String = "sing";
      
      public static const ATTACK:String = "attack";
      
      public static const obf_J_t_4311:String = "melee";
      
      public static const obf_Q_L_2061:String = "range";
      
      public static const MAGIC:String = "magic";
      
      public static const obf_y_Y_2903:String = "stricken";
      
      public static const DIE:String = "die";
      
      public static const RIDE:String = "ride";
      
      public static const obf_G_e_4471:String = "stand_riding";
      
      public static const obf_q_P_4083:String = "stand_not_riding";
      
      public static const obf_X_3_3308:String = "standx_riding";
      
      public static const obf_A_2_3026:String = "standx_not_riding";
      
      public static const obf_0_2_Q_460:String = "walk_riding";
      
      public static const obf_0_2_3_441:String = "walk_not_riding";
      
      public static const obf_0_8_Z_323:String = "range_riding";
      
      public static const obf_g_k_4413:String = "range_not_riding";
      
      private static var rideActionMap:Object = {
         "attack":obf_Q_L_2061,
         "melee":obf_Q_L_2061,
         "range":obf_Q_L_2061,
         "magic":obf_Q_L_2061,
         "walk":obf_h_4_3537
      };
      
      private static var obf_9_R_3865:Object = {
         "attack":obf_Q_L_2061,
         "melee":obf_Q_L_2061,
         "magic":obf_Q_L_2061,
         "standx":obf_r_q_3113
      };
      
      public var name:String;
      
      public var dirNum:int;
      
      public var obf_o_S_1886:Object;
      
      public var actionInfo:Object;
      
      public function obf_S_c_3330()
      {
         super();
      }
      
      public static function obf_k_4_4106(param1:String) : String
      {
         var _loc2_:String = rideActionMap[param1];
         return _loc2_ == null ? obf_r_q_3113 : _loc2_;
      }
      
      public static function getAlterActionName(param1:String) : String
      {
         var _loc2_:String = obf_9_R_3865[param1];
         return _loc2_ == null ? obf_r_q_3113 : _loc2_;
      }
      
      public function clone() : obf_S_c_3330
      {
         var _loc2_:String = null;
         var _loc3_:obf_W_E_4480 = null;
         var _loc1_:obf_S_c_3330 = new obf_S_c_3330();
         _loc1_.name = this.name;
         _loc1_.dirNum = this.dirNum;
         _loc1_.actionInfo = this.actionInfo;
         _loc1_.obf_o_S_1886 = new Object();
         for(_loc2_ in this.obf_o_S_1886)
         {
            _loc3_ = this.obf_o_S_1886[_loc2_];
            _loc1_.obf_o_S_1886[_loc2_] = _loc3_.clone();
         }
         return _loc1_;
      }
      
      public function getAnimation(param1:int) : obf_W_E_4480
      {
         return this.obf_o_S_1886[obf_D_0_1300.directionToName(param1)];
      }
      
      public function setAnimation(param1:int, param2:obf_W_E_4480) : void
      {
         this.obf_o_S_1886[obf_D_0_1300.directionToName(param1)] = param2;
      }
   }
}

