package com.sunweb.game.rpg.settingConfig
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.utils.obf_A_x_3023;
   
   public class RoleAttributesModifierEnum
   {
      
      public static const ALL_ATTR_ADD_VALUE:int = 90;
      
      public static const STRENGTH_ADD_VALUE:int = 100;
      
      public static const STRENGTH_ADD_RATE:int = 101;
      
      public static const WISDOM_ADD_VALUE:int = 110;
      
      public static const WISDOM_ADD_RATE:int = 111;
      
      public static const AGILITY_ADD_VALUE:int = 120;
      
      public static const AGILITY_ADD_RATE:int = 121;
      
      public static const VITALITY_ADD_VALUE:int = 130;
      
      public static const VITALITY_ADD_RATE:int = 131;
      
      public static const PHYSICAL_ATTACK_ADD_BASE_VALUE:int = 140;
      
      public static const PHYSICAL_ATTACK_ADD_RATE:int = 141;
      
      public static const PHYSICAL_ATTACK_ADD_EXTRA_VALUE:int = 142;
      
      public static const MAGIC_ATTACK_ADD_BASE_VALUE:int = 150;
      
      public static const MAGIC_ATTACK_ADD_RATE:int = 151;
      
      public static const MAGIC_ATTACK_ADD_EXTRA_VALUE:int = 152;
      
      public static const PHYSICAL_DEFENSE_ADD_BASE_VALUE:int = 160;
      
      public static const PHYSICAL_DEFENSE_ADD_RATE:int = 161;
      
      public static const PHYSICAL_DEFENSE_ADD_EXTRA_VALUE:int = 162;
      
      public static const MAGIC_DEFENSE_ADD_BASE_VALUE:int = 170;
      
      public static const MAGIC_DEFENSE_ADD_RATE:int = 171;
      
      public static const MAGIC_DEFENSE_ADD_EXTRA_VALUE:int = 172;
      
      public static const PHYSICAL_REDUCE_RATE_ADD_VALUE:int = 180;
      
      public static const PHYSICAL_REDUCE_ADD_VALUE:int = 181;
      
      public static const MAGIC_REDUCE_RATE_ADD_VALUE:int = 190;
      
      public static const MAGIC_REDUCE_ADD_VALUE:int = 191;
      
      public static const HP_MAX_ADD_BASE_VALUE:int = 200;
      
      public static const HP_MAX_ADD_RATE:int = 201;
      
      public static const HP_MAX_ADD_EXTRA_VALUE:int = 202;
      
      public static const MP_MAX_ADD_BASE_VALUE:int = 210;
      
      public static const MP_MAX_ADD_RATE:int = 211;
      
      public static const MP_MAX_ADD_EXTRA_VALUE:int = 212;
      
      public static const SP_MAX_ADD_BASE_VALUE:int = 220;
      
      public static const SP_MAX_ADD_RATE:int = 221;
      
      public static const SP_MAX_ADD_EXTRA_VALUE:int = 222;
      
      public static const HIT_VALUE_ADD_VALUE:int = 230;
      
      public static const HIT_RATE_ADD_VALUE:int = 231;
      
      public static const DODGE_VALUE_ADD_VALUE:int = 240;
      
      public static const DODGE_RATE_ADD_VALUE:int = 241;
      
      public static const CRIT_VALUE_ADD_VALUE:int = 250;
      
      public static const CRIT_RATE_ADD_VALUE:int = 251;
      
      public static const LUCKY_ATTACK_ADD_VALUE:int = 260;
      
      public static const LUCKY_DEFENSE_ADD_VALUE:int = 261;
      
      public static const CRIT_DAMAGE_MUL_ADD_VALUE:int = 270;
      
      public static const TOUGH_VALUE_ADD_VALUE:int = 280;
      
      public static const PIERCE_ATTACK_ADD_VALUE:int = 290;
      
      public static const PIERCE_DEFENSE_ADD_VALUE:int = 291;
      
      public static const CAST_SPEED_ADD_RATE:int = 300;
      
      public static const SING_SPEED_ADD_RATE:int = 310;
      
      public static const SING_TIME_REDUCEMS_ADD_VALUE:int = 311;
      
      public static const WALK_SPEED_ADD_VALUE:int = 320;
      
      public static const WALK_SPEED_ADD_RATE:int = 321;
      
      public static const WALK_SPEED_SET_TO:int = 322;
      
      public static const HP_HEAL_VALUE_ADD_VALUE:int = 330;
      
      public static const MP_HEAL_VALUE_ADD_VALUE:int = 340;
      
      public static const SP_HEAL_VALUE_ADD_VALUE:int = 350;
      
      public static const CURE_VALUE_ADD_VALUE:int = 360;
      
      public static const CURE_VALUE_ADD_RATE:int = 361;
      
      public static const CURE_VALUE_ADD_EXTRA_VALUE:int = 362;
      
      public static const WEAKNESS_TYPE_SET_TO:int = 370;
      
      public static const ROLE_EXP_MUL_ADD_VALUE:int = 380;
      
      public static const PET_EXP_MUL_ADD_VALUE:int = 390;
      
      public static const ITEM_DROP_CHANCE_MUL_ADD_VALUE:int = 400;
      
      public static const PHYSICAL_REDUCE_TO_HP_RATE_ADD_VALUE:int = 410;
      
      public static const MAGIC_REDUCE_TO_HP_RATE_ADD_VALUE:int = 420;
      
      public static const PHYSICAL_REDUCE_TO_MP_RATE_ADD_VALUE:int = 430;
      
      public static const MAGIC_REDUCE_TO_MP_RATE_ADD_VALUE:int = 440;
      
      public static const ELEMENT1_ATTACK_ADD_BASE_VALUE:int = 450;
      
      public static const ELEMENT1_ATTACK_ADD_RATE:int = 451;
      
      public static const ELEMENT1_ATTACK_ADD_EXTRA_VALUE:int = 452;
      
      public static const ELEMENT2_ATTACK_ADD_BASE_VALUE:int = 460;
      
      public static const ELEMENT2_ATTACK_ADD_RATE:int = 461;
      
      public static const ELEMENT2_ATTACK_ADD_EXTRA_VALUE:int = 462;
      
      public static const ELEMENT3_ATTACK_ADD_BASE_VALUE:int = 470;
      
      public static const ELEMENT3_ATTACK_ADD_RATE:int = 471;
      
      public static const ELEMENT3_ATTACK_ADD_EXTRA_VALUE:int = 472;
      
      public static const ELEMENT4_ATTACK_ADD_BASE_VALUE:int = 480;
      
      public static const ELEMENT4_ATTACK_ADD_RATE:int = 481;
      
      public static const ELEMENT4_ATTACK_ADD_EXTRA_VALUE:int = 482;
      
      public static const ELEMENT5_ATTACK_ADD_BASE_VALUE:int = 490;
      
      public static const ELEMENT5_ATTACK_ADD_RATE:int = 491;
      
      public static const ELEMENT5_ATTACK_ADD_EXTRA_VALUE:int = 492;
      
      public static const ELEMENT1_DEFENSE_ADD_BASE_VALUE:int = 500;
      
      public static const ELEMENT1_DEFENSE_ADD_RATE:int = 501;
      
      public static const ELEMENT1_DEFENSE_ADD_EXTRA_VALUE:int = 502;
      
      public static const ELEMENT2_DEFENSE_ADD_BASE_VALUE:int = 510;
      
      public static const ELEMENT2_DEFENSE_ADD_RATE:int = 511;
      
      public static const ELEMENT2_DEFENSE_ADD_EXTRA_VALUE:int = 512;
      
      public static const ELEMENT3_DEFENSE_ADD_BASE_VALUE:int = 520;
      
      public static const ELEMENT3_DEFENSE_ADD_RATE:int = 521;
      
      public static const ELEMENT3_DEFENSE_ADD_EXTRA_VALUE:int = 522;
      
      public static const ELEMENT4_DEFENSE_ADD_BASE_VALUE:int = 530;
      
      public static const ELEMENT4_DEFENSE_ADD_RATE:int = 531;
      
      public static const ELEMENT4_DEFENSE_ADD_EXTRA_VALUE:int = 532;
      
      public static const ELEMENT5_DEFENSE_ADD_BASE_VALUE:int = 540;
      
      public static const ELEMENT5_DEFENSE_ADD_RATE:int = 541;
      
      public static const ELEMENT5_DEFENSE_ADD_EXTRA_VALUE:int = 542;
      
      public static const ALL_APT_ADD_VALUE:int = 1000;
      
      public static const ALL_APT_ADD_RATE:int = 1001;
      
      public static const STRENGTH_APT_ADD_VALUE:int = 1010;
      
      public static const STRENGTH_APT_ADD_RATE:int = 1011;
      
      public static const WISDOM_APT_ADD_VALUE:int = 1020;
      
      public static const WISDOM_APT_ADD_RATE:int = 1021;
      
      public static const AGILITY_APT_ADD_VALUE:int = 1030;
      
      public static const AGILITY_APT_ADD_RATE:int = 1031;
      
      public static const VITALITY_APT_ADD_VALUE:int = 1040;
      
      public static const VITALITY_APT_ADD_RATE:int = 1041;
      
      public static const LVUP_ATTR_PT_ADD_VALUE:int = 1050;
      
      public static const GROWTH_RATE_ADD_VALUE:int = 1060;
      
      public static const LEARN_SKILL_CHANCE_MUL_ADD_VALUE:int = 1070;
      
      public static const SUBDUE_MUL_ADD_VALUE:int = 1080;
      
      public static const DAMAGE_ABSORB_RATIO_ADD_VALUE:int = 1090;
      
      public static const DAMAGE_ABSORB_MUL_ADD_VALUE:int = 1100;
      
      public function RoleAttributesModifierEnum()
      {
         super();
      }
      
      public static function getAttributesName(param1:int) : String
      {
         var _loc2_:Object = new Object();
         _loc2_[ALL_ATTR_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","ALL_ATTR_ADD_VALUE");
         _loc2_[STRENGTH_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","STRENGTH_ADD_VALUE");
         _loc2_[STRENGTH_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","STRENGTH_ADD_RATE");
         _loc2_[WISDOM_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","WISDOM_ADD_VALUE");
         _loc2_[WISDOM_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","WISDOM_ADD_RATE");
         _loc2_[AGILITY_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","AGILITY_ADD_VALUE");
         _loc2_[AGILITY_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","AGILITY_ADD_RATE");
         _loc2_[VITALITY_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","VITALITY_ADD_VALUE");
         _loc2_[VITALITY_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","VITALITY_ADD_RATE");
         _loc2_[PHYSICAL_ATTACK_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","PHYSICAL_ATTACK_ADD_BASE_VALUE");
         _loc2_[PHYSICAL_ATTACK_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","PHYSICAL_ATTACK_ADD_RATE");
         _loc2_[PHYSICAL_ATTACK_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","PHYSICAL_ATTACK_ADD_EXTRA_VALUE");
         _loc2_[MAGIC_ATTACK_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","MAGIC_ATTACK_ADD_BASE_VALUE");
         _loc2_[MAGIC_ATTACK_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","MAGIC_ATTACK_ADD_RATE");
         _loc2_[MAGIC_ATTACK_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","MAGIC_ATTACK_ADD_EXTRA_VALUE");
         _loc2_[PHYSICAL_DEFENSE_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","PHYSICAL_DEFENSE_ADD_BASE_VALUE");
         _loc2_[PHYSICAL_DEFENSE_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","PHYSICAL_DEFENSE_ADD_RATE");
         _loc2_[PHYSICAL_DEFENSE_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","PHYSICAL_DEFENSE_ADD_EXTRA_VALUE");
         _loc2_[MAGIC_DEFENSE_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","MAGIC_DEFENSE_ADD_BASE_VALUE");
         _loc2_[MAGIC_DEFENSE_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","MAGIC_DEFENSE_ADD_RATE");
         _loc2_[MAGIC_DEFENSE_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","MAGIC_DEFENSE_ADD_EXTRA_VALUE");
         _loc2_[PHYSICAL_REDUCE_RATE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","PHYSICAL_REDUCE_RATE_ADD_VALUE");
         _loc2_[MAGIC_REDUCE_RATE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","MAGIC_REDUCE_RATE_ADD_VALUE");
         _loc2_[HP_MAX_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","HP_MAX_ADD_BASE_VALUE");
         _loc2_[HP_MAX_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","HP_MAX_ADD_RATE");
         _loc2_[HP_MAX_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","HP_MAX_ADD_EXTRA_VALUE");
         _loc2_[MP_MAX_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","MP_MAX_ADD_BASE_VALUE");
         _loc2_[MP_MAX_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","MP_MAX_ADD_RATE");
         _loc2_[MP_MAX_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","MP_MAX_ADD_EXTRA_VALUE");
         _loc2_[SP_MAX_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","SP_MAX_ADD_BASE_VALUE");
         _loc2_[SP_MAX_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","SP_MAX_ADD_RATE");
         _loc2_[SP_MAX_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","SP_MAX_ADD_EXTRA_VALUE");
         _loc2_[HIT_VALUE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","HIT_VALUE_ADD_VALUE");
         _loc2_[HIT_RATE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","HIT_RATE_ADD_VALUE");
         _loc2_[DODGE_VALUE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","DODGE_VALUE_ADD_VALUE");
         _loc2_[DODGE_RATE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","DODGE_RATE_ADD_VALUE");
         _loc2_[CRIT_VALUE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","CRIT_VALUE_ADD_VALUE");
         _loc2_[CRIT_RATE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","CRIT_RATE_ADD_VALUE");
         _loc2_[LUCKY_ATTACK_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","LUCKY_ATTACK_ADD_VALUE");
         _loc2_[LUCKY_DEFENSE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","LUCKY_DEFENSE_ADD_VALUE");
         _loc2_[CRIT_DAMAGE_MUL_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","CRIT_DAMAGE_MUL_ADD_VALUE");
         _loc2_[TOUGH_VALUE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","TOUGH_VALUE_ADD_VALUE");
         _loc2_[PIERCE_ATTACK_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","PIERCE_ATTACK_ADD_VALUE");
         _loc2_[PIERCE_DEFENSE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","PIERCE_DEFENSE_ADD_VALUE");
         _loc2_[CAST_SPEED_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","CAST_SPEED_ADD_RATE");
         _loc2_[SING_SPEED_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","SING_SPEED_ADD_RATE");
         _loc2_[SING_TIME_REDUCEMS_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","SING_TIME_REDUCEMS_ADD_VALUE");
         _loc2_[WALK_SPEED_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","WALK_SPEED_ADD_VALUE");
         _loc2_[WALK_SPEED_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","WALK_SPEED_ADD_RATE");
         _loc2_[WALK_SPEED_SET_TO] = DiversityManager.getString("EquipmentAttribute","WALK_SPEED_SET_TO");
         _loc2_[HP_HEAL_VALUE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","HP_HEAL_VALUE_ADD_VALUE");
         _loc2_[MP_HEAL_VALUE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","MP_HEAL_VALUE_ADD_VALUE");
         _loc2_[SP_HEAL_VALUE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","SP_HEAL_VALUE_ADD_VALUE");
         _loc2_[CURE_VALUE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","CURE_VALUE_ADD_VALUE");
         _loc2_[CURE_VALUE_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","CURE_VALUE_ADD_RATE");
         _loc2_[CURE_VALUE_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","CURE_VALUE_ADD_EXTRA_VALUE");
         _loc2_[WEAKNESS_TYPE_SET_TO] = DiversityManager.getString("EquipmentAttribute","WEAKNESS_TYPE_SET_TO");
         _loc2_[PHYSICAL_REDUCE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","PHYSICAL_REDUCE_ADD_VALUE");
         _loc2_[MAGIC_REDUCE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","MAGIC_REDUCE_ADD_VALUE");
         _loc2_[ROLE_EXP_MUL_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","ROLE_EXP_MUL_ADD_VALUE");
         _loc2_[PET_EXP_MUL_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","PET_EXP_MUL_ADD_VALUE");
         _loc2_[ITEM_DROP_CHANCE_MUL_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","ITEM_DROP_CHANCE_MUL_ADD_VALUE");
         _loc2_[PHYSICAL_REDUCE_TO_HP_RATE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","PHYSICAL_REDUCE_TO_HP_RATE_ADD_VALUE");
         _loc2_[MAGIC_REDUCE_TO_HP_RATE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","MAGIC_REDUCE_TO_HP_RATE_ADD_VALUE");
         _loc2_[PHYSICAL_REDUCE_TO_MP_RATE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","PHYSICAL_REDUCE_TO_MP_RATE_ADD_VALUE");
         _loc2_[MAGIC_REDUCE_TO_MP_RATE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","MAGIC_REDUCE_TO_MP_RATE_ADD_VALUE");
         _loc2_[ELEMENT1_ATTACK_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT1_ATTACK_ADD_BASE_VALUE");
         _loc2_[ELEMENT1_ATTACK_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","ELEMENT1_ATTACK_ADD_RATE");
         _loc2_[ELEMENT1_ATTACK_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT1_ATTACK_ADD_EXTRA_VALUE");
         _loc2_[ELEMENT2_ATTACK_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT2_ATTACK_ADD_BASE_VALUE");
         _loc2_[ELEMENT2_ATTACK_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","ELEMENT2_ATTACK_ADD_RATE");
         _loc2_[ELEMENT2_ATTACK_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT2_ATTACK_ADD_EXTRA_VALUE");
         _loc2_[ELEMENT3_ATTACK_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT3_ATTACK_ADD_BASE_VALUE");
         _loc2_[ELEMENT3_ATTACK_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","ELEMENT3_ATTACK_ADD_RATE");
         _loc2_[ELEMENT3_ATTACK_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT3_ATTACK_ADD_EXTRA_VALUE");
         _loc2_[ELEMENT4_ATTACK_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT4_ATTACK_ADD_BASE_VALUE");
         _loc2_[ELEMENT4_ATTACK_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","ELEMENT4_ATTACK_ADD_RATE");
         _loc2_[ELEMENT4_ATTACK_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT4_ATTACK_ADD_EXTRA_VALUE");
         _loc2_[ELEMENT5_ATTACK_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT5_ATTACK_ADD_BASE_VALUE");
         _loc2_[ELEMENT5_ATTACK_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","ELEMENT5_ATTACK_ADD_RATE");
         _loc2_[ELEMENT5_ATTACK_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT5_ATTACK_ADD_EXTRA_VALUE");
         _loc2_[ELEMENT1_DEFENSE_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT1_DEFENSE_ADD_BASE_VALUE");
         _loc2_[ELEMENT1_DEFENSE_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","ELEMENT1_DEFENSE_ADD_RATE");
         _loc2_[ELEMENT1_DEFENSE_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT1_DEFENSE_ADD_EXTRA_VALUE");
         _loc2_[ELEMENT2_DEFENSE_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT2_DEFENSE_ADD_BASE_VALUE");
         _loc2_[ELEMENT2_DEFENSE_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","ELEMENT2_DEFENSE_ADD_RATE");
         _loc2_[ELEMENT2_DEFENSE_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT2_DEFENSE_ADD_EXTRA_VALUE");
         _loc2_[ELEMENT3_DEFENSE_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT3_DEFENSE_ADD_BASE_VALUE");
         _loc2_[ELEMENT3_DEFENSE_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","ELEMENT3_DEFENSE_ADD_RATE");
         _loc2_[ELEMENT3_DEFENSE_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT3_DEFENSE_ADD_EXTRA_VALUE");
         _loc2_[ELEMENT4_DEFENSE_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT4_DEFENSE_ADD_BASE_VALUE");
         _loc2_[ELEMENT4_DEFENSE_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","ELEMENT4_DEFENSE_ADD_RATE");
         _loc2_[ELEMENT4_DEFENSE_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT4_DEFENSE_ADD_EXTRA_VALUE");
         _loc2_[ELEMENT5_DEFENSE_ADD_BASE_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT5_DEFENSE_ADD_BASE_VALUE");
         _loc2_[ELEMENT5_DEFENSE_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","ELEMENT5_DEFENSE_ADD_RATE");
         _loc2_[ELEMENT5_DEFENSE_ADD_EXTRA_VALUE] = DiversityManager.getString("EquipmentAttribute","ELEMENT5_DEFENSE_ADD_EXTRA_VALUE");
         _loc2_[ALL_APT_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","ALL_APT_ADD_VALUE");
         _loc2_[ALL_APT_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","ALL_APT_ADD_RATE");
         _loc2_[STRENGTH_APT_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","STRENGTH_APT_ADD_VALUE");
         _loc2_[STRENGTH_APT_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","STRENGTH_APT_ADD_RATE");
         _loc2_[WISDOM_APT_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","WISDOM_APT_ADD_VALUE");
         _loc2_[WISDOM_APT_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","WISDOM_APT_ADD_RATE");
         _loc2_[AGILITY_APT_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","AGILITY_APT_ADD_VALUE");
         _loc2_[AGILITY_APT_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","AGILITY_APT_ADD_RATE");
         _loc2_[VITALITY_APT_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","VITALITY_APT_ADD_VALUE");
         _loc2_[VITALITY_APT_ADD_RATE] = DiversityManager.getString("EquipmentAttribute","VITALITY_APT_ADD_RATE");
         _loc2_[LVUP_ATTR_PT_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","LVUP_ATTR_PT_ADD_VALUE");
         _loc2_[GROWTH_RATE_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","GROWTH_RATE_ADD_VALUE");
         _loc2_[LEARN_SKILL_CHANCE_MUL_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","LEARN_SKILL_CHANCE_MUL_ADD_VALUE");
         _loc2_[SUBDUE_MUL_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","SUBDUE_MUL_ADD_VALUE");
         _loc2_[DAMAGE_ABSORB_RATIO_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","DAMAGE_ABSORB_RATIO_ADD_VALUE");
         _loc2_[DAMAGE_ABSORB_MUL_ADD_VALUE] = DiversityManager.getString("EquipmentAttribute","DAMAGE_ABSORB_MUL_ADD_VALUE");
         return _loc2_[param1];
      }
      
      public static function getAttributesValueString(param1:int, param2:Number, param3:Boolean = false, param4:Boolean = false) : String
      {
         var _loc5_:String = "";
         if(!param4)
         {
            if(param2 < 0)
            {
               _loc5_ = "-";
            }
            else
            {
               _loc5_ = "+";
            }
         }
         var _loc6_:Array = [STRENGTH_ADD_RATE,WISDOM_ADD_RATE,AGILITY_ADD_RATE,VITALITY_ADD_RATE,PHYSICAL_ATTACK_ADD_RATE,MAGIC_ATTACK_ADD_RATE,PHYSICAL_DEFENSE_ADD_RATE,MAGIC_DEFENSE_ADD_RATE,PHYSICAL_REDUCE_RATE_ADD_VALUE,MAGIC_REDUCE_RATE_ADD_VALUE,HP_MAX_ADD_RATE,MP_MAX_ADD_RATE,SP_MAX_ADD_RATE,HIT_RATE_ADD_VALUE,DODGE_RATE_ADD_VALUE,CRIT_RATE_ADD_VALUE,CRIT_DAMAGE_MUL_ADD_VALUE,CAST_SPEED_ADD_RATE,SING_SPEED_ADD_RATE,WALK_SPEED_ADD_RATE,CURE_VALUE_ADD_RATE,ROLE_EXP_MUL_ADD_VALUE,PET_EXP_MUL_ADD_VALUE,ITEM_DROP_CHANCE_MUL_ADD_VALUE,PHYSICAL_REDUCE_TO_HP_RATE_ADD_VALUE,MAGIC_REDUCE_TO_HP_RATE_ADD_VALUE,PHYSICAL_REDUCE_TO_MP_RATE_ADD_VALUE,MAGIC_REDUCE_TO_MP_RATE_ADD_VALUE,ELEMENT1_ATTACK_ADD_RATE,ELEMENT2_ATTACK_ADD_RATE,ELEMENT3_ATTACK_ADD_RATE,ELEMENT4_ATTACK_ADD_RATE,ELEMENT5_ATTACK_ADD_RATE,ELEMENT1_DEFENSE_ADD_RATE,ELEMENT2_DEFENSE_ADD_RATE,ELEMENT3_DEFENSE_ADD_RATE,ELEMENT4_DEFENSE_ADD_RATE,ELEMENT5_DEFENSE_ADD_RATE,ALL_APT_ADD_RATE,STRENGTH_APT_ADD_RATE,WISDOM_APT_ADD_RATE,AGILITY_APT_ADD_RATE
         ,VITALITY_APT_ADD_RATE];
         var _loc7_:Array = [SING_TIME_REDUCEMS_ADD_VALUE];
         if(_loc6_.indexOf(param1) > -1)
         {
            _loc5_ += obf_A_x_3023.getRateString(param2);
         }
         else if(_loc7_.indexOf(param1) > -1)
         {
            _loc5_ += DiversityManager.getString("TimePrompt","S",[Number(Math.round(param2) / 1000).toFixed(1)]);
         }
         else
         {
            _loc5_ += Math.round(param2) + "";
         }
         return _loc5_;
      }
   }
}

