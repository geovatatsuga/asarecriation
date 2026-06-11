package com.sunweb.game.rpg
{
   import com.adobe.serialization.json.JSON;
   import com.sunweb.game.rpg.loginZone.obf_b_S_2328;
   import com.sunweb.game.rpg.map.Map;
   import com.sunweb.game.rpg.module.obf_h_q_1976;
   import com.sunweb.game.rpg.netRole.obf_U_6_3454;
   import com.sunweb.game.rpg.playerBag.BagItemManager;
   import com.sunweb.game.rpg.playerUI.obf_C_o_3363;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.worldZone.obf_u_d_1452;
   import com.sunweb.game.rpg.worldZone.command.system.WorldClientSaveConfigRequest;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.managers.FocusManager;
   import flash.display.Stage;
   import flash.net.LocalConnection;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Security;
   
   public class GameContext
   {
      
      public static var loginClient:obf_b_S_2328;
      
      public static var worldClient:obf_u_d_1452;
      
      public static var sso:String;
      
      public static var gameStage:Stage;
      
      public static var mainModule:obf_h_q_1976;
      
      public static var infConfigInit:Boolean;
      
      public static var currentMap:Map;
      
      public static var obf_N_G_4080:String;
      
      public static var obf_0_7_r_135:String;
      
      public static var localPlayer:obf_U_6_3454;
      
      public static var autoSelectRole:String;
      
      public static var bagItemManager:BagItemManager;
      
      public static var userConfig:Object;
      
      public static var saveConfigInv:TimeLimiter;
      
      public static var gameFocusManager:FocusManager;
      
      private static var obf_a_j_4111:LocalConnection;
      
      public static var resourceFileURL:String = "";
      
      public static var resourceServerHttpHost:String = "";
      
      public static var loginServerIP:String = "";
      
      public static var loginServerPort:int = 0;
      
      public static var policyServerPort:int = 0;
      
      public function GameContext()
      {
         super();
      }
      
      public static function saveConfig() : void
      {
         saveConfigInv = new TimeLimiter(3000);
      }
      
      public static function saveConfigNow() : void
      {
         var _loc1_:WorldClientSaveConfigRequest = new WorldClientSaveConfigRequest();
         _loc1_.config = com.adobe.serialization.json.JSON.encode(GameContext.userConfig);
         worldClient.sendCommand(_loc1_);
      }
      
      public static function applyUserConfig() : void
      {
         if(!userConfig)
         {
            return;
         }
         if(obf_K_e_3075.obf_f_a_l_s_e_334)
         {
            obf_K_e_3075.obf_f_a_l_s_e_334.useUserConfig();
         }
         PlayerSkillManager.applyAutoSkillUserConfig();
      }
      
      public static function loadPolicyFile(param1:String) : void
      {
         Security.loadPolicyFile("xmlsocket://" + param1 + ":" + policyServerPort);
      }
      
      public static function refreshPage(param1:Object = null) : void
      {
         var par:Object = param1;
         try
         {
            navigateToURL(new URLRequest("javascript:document.location.reload();"),"_top");
         }
         catch(e:Error)
         {
         }
      }
      
      public static function getFullResUrl(param1:String) : String
      {
         if(param1.toLowerCase().indexOf("http:") == 0)
         {
            return param1;
         }
         if(param1.charAt(0) != "/")
         {
            param1 = "/" + param1;
         }
         return resourceServerHttpHost + param1;
      }
      
      public static function isSso() : Boolean
      {
         return !obf_L_l_4100.isEmpty(GameContext.sso);
      }
      
      public static function ssoFailed(param1:*) : void
      {
         if(isSso())
         {
            if(!obf_C_o_3363.openActionURL("ResetGamePage"))
            {
               refreshPage();
            }
         }
      }
      
      public static function obf_A_E_1092() : Boolean
      {
         return true;
      }
   }
}

