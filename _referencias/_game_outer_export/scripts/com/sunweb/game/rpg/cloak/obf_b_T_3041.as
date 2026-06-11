package com.sunweb.game.rpg.cloak
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.cloak.CommandCodePlayerCloak;
   import com.sunweb.game.rpg.worldZone.command.cloak.PlayerCloakChipNotify;
   import com.sunweb.game.rpg.worldZone.command.cloak.PlayerCloakGetUpAnswer;
   import com.sunweb.game.rpg.worldZone.command.cloak.PlayerCloakGetUpRequest;
   import com.sunweb.game.rpg.worldZone.command.cloak.PlayerCloakGlyphNotify;
   import com.sunweb.game.rpg.worldZone.command.cloak.PlayerCloakGlyphOpenUpRequest;
   import com.sunweb.game.rpg.worldZone.command.cloak.PlayerCloakInChipRequest;
   import com.sunweb.game.rpg.worldZone.command.cloak.PlayerCloakMeltAnswer;
   import com.sunweb.game.rpg.worldZone.command.cloak.PlayerCloakMeltRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_b_T_3041
   {
      
      public static var obf_0_5_W_677:Boolean;
      
      private static var cloakConfig:Object = new Object();
      
      public static var _defenseChipMap:Object = new Object();
      
      public static var obf_J_S_3057:Object = new Object();
      
      public static var obf_k_s_4303:int = 0;
      
      public static var _defenseCloaks:int = 0;
      
      public static var obf_0_4_Z_273:Object = new Object();
      
      public function obf_b_T_3041()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         cloakConfig = param1;
      }
      
      public static function get playerLv() : int
      {
         return JSONUtil.getInt(cloakConfig,["openLevel"]);
      }
      
      public static function get chipCodes() : Object
      {
         return JSONUtil.getObject(cloakConfig,["chipCodes"]);
      }
      
      public static function get cloakAttact() : Object
      {
         return JSONUtil.getObject(cloakConfig,["attact"]);
      }
      
      public static function get cloakDefense() : Object
      {
         return JSONUtil.getObject(cloakConfig,["defense"]);
      }
      
      public static function get cloakMeltNeeds() : Object
      {
         return JSONUtil.getObject(cloakConfig,["meltNeeds"]);
      }
      
      public static function get cloakMeltTo() : Object
      {
         return JSONUtil.getObject(cloakConfig,["meltTo"]);
      }
      
      public static function get cloakGlyphConfig() : Array
      {
         return JSONUtil.getObject(cloakConfig,["glyphConfig"]) as Array;
      }
      
      public static function sendCloakGetUp(param1:int) : void
      {
         var _loc2_:PlayerCloakGetUpRequest = new PlayerCloakGetUpRequest();
         _loc2_.type = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendCloakInChip(param1:int, param2:int) : void
      {
         var _loc3_:PlayerCloakInChipRequest = new PlayerCloakInChipRequest();
         _loc3_.type = param1;
         _loc3_.index = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendCloakMelt(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:PlayerCloakMeltRequest = new PlayerCloakMeltRequest();
         _loc4_.cloakId = param1;
         _loc4_.code1 = param2;
         _loc4_.code2 = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function sendGlyphOpenUp(param1:String) : void
      {
         var _loc2_:PlayerCloakGlyphOpenUpRequest = new PlayerCloakGlyphOpenUpRequest();
         _loc2_.glyphId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerCloak.PLAYER_CLOAK_CHIP_NOTIFY)
         {
            obf_X_p_2517(param1 as PlayerCloakChipNotify);
         }
         else if(param1.code == CommandCodePlayerCloak.PLAYER_CLOAK_GET_UP_ANSWER)
         {
            obf_p_g_3765(param1 as PlayerCloakGetUpAnswer);
         }
         else if(param1.code == CommandCodePlayerCloak.PLAYER_CLOAK_GLYPH_NOTIFY)
         {
            obf_Y_v_1579(param1 as PlayerCloakGlyphNotify);
         }
         else if(param1.code == CommandCodePlayerCloak.PLAYER_CLOAK_MELT_ANSWER)
         {
            obf_U_5_1990(param1 as PlayerCloakMeltAnswer);
         }
      }
      
      private static function obf_X_p_2517(param1:PlayerCloakChipNotify) : void
      {
         obf_J_S_3057 = param1.attactChipMap;
         _defenseChipMap = param1.defenseChipMap;
         obf_K_e_3075.cloakBoxUI.cloakChipNotify(obf_J_S_3057,_defenseChipMap);
      }
      
      private static function obf_p_g_3765(param1:PlayerCloakGetUpAnswer) : void
      {
         obf_k_s_4303 = param1.attactCloaks;
         _defenseCloaks = param1.defenseCloaks;
      }
      
      private static function obf_Y_v_1579(param1:PlayerCloakGlyphNotify) : void
      {
         obf_0_4_Z_273 = param1.glyphInfo;
         obf_K_e_3075.cloakBoxUI.obf_0_4_I_321(obf_0_4_Z_273);
      }
      
      private static function obf_U_5_1990(param1:PlayerCloakMeltAnswer) : void
      {
         obf_0_5_W_677 = param1.isSuccess;
         if(param1.isSuccess)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","prompt_CloakComplete"));
            obf_K_e_3075.cloakBoxUI.chearFusionItem();
         }
         else
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CloakBoxUI","prompt_CloakFail"));
         }
         obf_K_e_3075.cloakBoxUI.showFusionEffect(param1.isSuccess);
      }
   }
}

