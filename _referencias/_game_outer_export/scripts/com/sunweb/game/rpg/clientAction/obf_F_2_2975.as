package com.sunweb.game.rpg.clientAction
{
   import obf_r_4635.obf_R_6_1363;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.farm.AIFarmHarvest;
   import com.sunweb.game.rpg.farm.FarmManager;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.module.obf_0_K_4070;
   import com.sunweb.game.rpg.netRole.obf_U_6_3454;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.obf_C_o_3363;
   import com.sunweb.game.rpg.playerUI.obf_z_A_3653;
   import com.sunweb.game.rpg.playerUI.fastApplyUI.obf_X_t_4110;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.skill.SkillManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.setTimeout;
   
   public class obf_F_2_2975
   {
      
      private static var mcaroList:Array;
      
      private static var obf_J_N_4029:String;
      
      private static var _urlLoader:URLLoader;
      
      public static const obf_4_d_3813:String = "move";
      
      public static const obf_n_a_3855:String = "skill";
      
      private static var uiMap:Object = {
         "BagUI":obf_K_e_3075.playerBagUI,
         "RideBoxUI":obf_K_e_3075.rideBoxUI,
         "WingBoxUI":obf_K_e_3075.wingBoxUI,
         "PetBoxUI":obf_K_e_3075.petBoxUI,
         "PetBoxContainerUI":obf_K_e_3075.petBoxContainerUI,
         "RoleInfoUI":obf_K_e_3075.playerBoxUI,
         "SkillBookUI":obf_K_e_3075.skillBookUI,
         "TaskUI":obf_K_e_3075.playerTaskUI,
         "ShopUI":obf_K_e_3075.obf_N_i_3901,
         "NewShopUI":obf_K_e_3075.newShopBoxUI,
         "TeamUI":obf_K_e_3075.teamManagerUI,
         "FriendUI":obf_K_e_3075.obf_w_f_4556,
         "GuildUI":obf_K_e_3075.familyBoxUI,
         "MapUI":obf_K_e_3075.mapUI,
         "WorldMapUI":obf_K_e_3075.worldMapUI,
         "BotUI":obf_K_e_3075.obf_f_a_l_s_e_334,
         "BlessUI":obf_K_e_3075.playerBlessUI,
         "SuccessUI":obf_K_e_3075.successUI,
         "SystemUI":obf_K_e_3075.systemSettingUI,
         "ArmoryUI":obf_K_e_3075.obf_s_g_3090,
         "RouletteUI":obf_K_e_3075.obf_y_P_4288
      };
      
      public function obf_F_2_2975()
      {
         super();
      }
      
      public static function obf_S_3_1390() : void
      {
      }
      
      public static function obf_O_p_3236(param1:String) : void
      {
         var macroFun:Function;
         var macro:String = param1;
         var macroMap:Object = {
            "SHOWUI":showUI,
            "CLOSEUI":closeUI,
            "SHOWWELCOME":showWelcome,
            "TARGET":target,
            "ATTACK":attack,
            "USESKILL":useSkill,
            "STARTBOT":startBot,
            "STOPBOT":stopBot,
            "MOVETO":moveTo,
            "MOVETODO":moveToDo,
            "MOVETONPC":moveToNPC,
            "USEITEM":useItem,
            "SAY":say,
            "COLLECTHARVEST":obf_U_E_3190,
            "CHECKBETTEREQUIPMENT":obf_g_m_4580,
            "OPENREMOTEURL":openRemoteUrl,
            "SETTIMEOUT":timeOutMacro,
            "REFRESHMAPNPC":obf_0_0_V_408,
            "OPENURL":openUrl,
            "VARSHOPUI":varShopUI
         };
         var macroPar:Array = macro.split(" ");
         if(!macroPar || macroPar.length == 0)
         {
            return;
         }
         macro = macroPar.shift();
         macro = macro.toUpperCase();
         macroFun = macroMap[macro];
         if(macroFun != null)
         {
            try
            {
               macroFun.apply(null,macroPar);
            }
            catch(e:Error)
            {
            }
         }
      }
      
      private static function showUI(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:obf_z_A_3653 = null;
         var _loc4_:IPlayerUI = null;
         if(param1.indexOf(":") > -1)
         {
            _loc2_ = param1.split(":");
            _loc3_ = uiMap[_loc2_[0]] as obf_z_A_3653;
            _loc4_ = uiMap[_loc2_[1]] as IPlayerUI;
            if(Boolean(_loc3_) && Boolean(_loc4_))
            {
               obf_K_e_3075.closeAllChildUI(_loc3_);
               obf_K_e_3075.showChildUI(_loc3_,_loc4_);
               obf_K_e_3075.showUI(_loc3_);
            }
         }
         else if(param1 == "ShopUI")
         {
            if(Boolean(WorldConfig.getValue("functionSwitch","showNewShop")) && Boolean(obf_K_e_3075.newShopBoxUI))
            {
               obf_K_e_3075.showUI(obf_K_e_3075.newShopBoxUI);
            }
            else
            {
               obf_K_e_3075.showUI(obf_K_e_3075.obf_N_i_3901);
            }
         }
         else
         {
            obf_K_e_3075.showUI(uiMap[param1]);
         }
      }
      
      private static function closeUI(param1:String) : void
      {
         obf_K_e_3075.closeUI(uiMap[param1]);
      }
      
      private static function showWelcome(param1:String) : void
      {
         WindowManager.showModalWindow(new obf_0_K_4070(param1,""));
      }
      
      private static function target(param1:String) : void
      {
         MapManager.instance.seleteRecentTarget(param1);
      }
      
      private static function attack(param1:String = "") : void
      {
         if(!obf_L_l_4100.isEmpty(param1))
         {
            MapManager.instance.seleteRecentTarget(param1);
         }
         if(GameContext.localPlayer)
         {
            PlayerSkillManager.useDefaultAttackSkill();
         }
      }
      
      private static function useSkill(param1:String, param2:String = "") : void
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         if(!obf_L_l_4100.isEmpty(param2))
         {
            MapManager.instance.seleteRecentTarget(param2);
         }
         if(GameContext.localPlayer)
         {
            _loc3_ = "";
            _loc4_ = PlayerSkillManager.getAllSkills();
            for(_loc5_ in _loc4_)
            {
               if(SkillManager.getSkillName(_loc5_) == param1)
               {
                  _loc3_ = _loc5_;
                  break;
               }
            }
            if(obf_L_l_4100.isEmpty(_loc3_))
            {
               _loc6_ = PlayerSkillManager.getCommonSkills();
               for each(_loc7_ in _loc6_)
               {
                  if(SkillManager.getSkillName(_loc7_) == param1)
                  {
                     _loc3_ = _loc7_;
                     break;
                  }
               }
            }
            if(!obf_L_l_4100.isEmpty(_loc3_))
            {
               GameContext.localPlayer.sendSkill(_loc3_,GameContext.localPlayer.obf_0_6_a_430,null);
            }
         }
      }
      
      private static function startBot(param1:String = "") : void
      {
         obf_R_6_1363.setExcludedCodeList([]);
         obf_R_6_1363.startBot(param1);
      }
      
      private static function stopBot() : void
      {
         obf_R_6_1363.stopBot();
      }
      
      private static function moveTo(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:Point = null;
         var _loc7_:Array = null;
         if(GameContext.localPlayer)
         {
            _loc2_ = 0;
            if(param1.indexOf(":") > -1)
            {
               _loc7_ = param1.split(":");
               param1 = _loc7_[0];
               _loc2_ = int(_loc7_[1]);
            }
            _loc3_ = param1.split("@");
            _loc4_ = GameContext.currentMap.mapId;
            if(_loc3_.length >= 2)
            {
               _loc4_ = _loc3_[1];
            }
            _loc5_ = String(_loc3_[0]).split(",");
            _loc6_ = new Point();
            _loc6_.x = _loc5_[0];
            if(_loc5_.length >= 2)
            {
               _loc6_.y = _loc5_[1];
            }
            if(_loc2_ > 0)
            {
               _loc6_.x += -_loc2_ + Math.random() * (_loc2_ * 2);
               _loc6_.y += -_loc2_ + Math.random() * (_loc2_ * 2);
            }
            GameContext.localPlayer.obf_0_8_r_450(_loc4_,obf_U_6_3454.obf_L_K_2966,_loc6_);
         }
      }
      
      private static function moveToDo(param1:String, param2:String, ... rest) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:Point = null;
         var _loc9_:Array = null;
         if(GameContext.localPlayer)
         {
            _loc4_ = 0;
            if(param1.indexOf(":") > -1)
            {
               _loc9_ = param1.split(":");
               param1 = _loc9_[0];
               _loc4_ = int(_loc9_[1]);
            }
            _loc5_ = param1.split("@");
            _loc6_ = GameContext.currentMap.mapId;
            if(_loc5_.length >= 2)
            {
               _loc6_ = _loc5_[1];
            }
            _loc7_ = String(_loc5_[0]).split(",");
            _loc8_ = new Point();
            _loc8_.x = _loc7_[0];
            if(_loc7_.length >= 2)
            {
               _loc8_.y = _loc7_[1];
            }
            if(_loc4_ > 0)
            {
               _loc8_.x += -_loc4_ + Math.random() * (_loc4_ * 2);
               _loc8_.y += -_loc4_ + Math.random() * (_loc4_ * 2);
            }
            param2 += " " + rest.join(" ");
            GameContext.localPlayer.obf_0_8_r_450(_loc6_,obf_U_6_3454.obf_Z_n_2536,{
               "target":_loc8_,
               "macro":param2
            });
         }
      }
      
      private static function moveToNPC(param1:String) : void
      {
         var _loc2_:Array = param1.split("@");
         if(_loc2_.length < 2)
         {
            return;
         }
         GameContext.localPlayer.obf_0_8_r_450(_loc2_[1],obf_U_6_3454.obf_H_n_3781,_loc2_[0]);
      }
      
      private static function useItem(param1:String) : void
      {
         if(!obf_K_e_3075.playerBagUI)
         {
            return;
         }
         var _loc2_:IconItemBag = obf_K_e_3075.playerBagUI.getIconItemBagByCode(param1);
         if(!_loc2_)
         {
            _loc2_ = obf_K_e_3075.playerBagUI.getIconItemBagByItemName(param1);
         }
         if(_loc2_)
         {
            _loc2_.useIconItem();
         }
      }
      
      private static function say(param1:String) : void
      {
         if(obf_K_e_3075.obf_e_q_2572)
         {
            obf_K_e_3075.obf_e_q_2572.enterContent(param1);
         }
      }
      
      private static function obf_U_E_3190(param1:String) : void
      {
         var _loc4_:AIFarmHarvest = null;
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < 50)
         {
            _loc4_ = MapManager.instance.getRecentFarmHarvest(param1,_loc2_);
            if(!_loc4_)
            {
               return;
            }
            if(_loc4_.canCollect(false))
            {
               FarmManager.obf_U_E_3190(_loc4_);
               return;
            }
            _loc2_.push(_loc4_.id);
            _loc3_++;
         }
      }
      
      private static function obf_g_m_4580() : void
      {
         obf_X_t_4110.obf_j_6_2682();
      }
      
      private static function openRemoteUrl(param1:String) : void
      {
         obf_C_o_3363.openActionURL(param1);
      }
      
      private static function timeOutMacro(... rest) : void
      {
         var _loc2_:int = int(rest.shift());
         if(_loc2_ > 0)
         {
            setTimeout(obf_O_p_3236,_loc2_,rest.join(" "));
         }
      }
      
      private static function obf_0_0_V_408() : void
      {
         MapManager.instance.obf_5_G_1974();
      }
      
      private static function openUrl(param1:String) : void
      {
         _urlLoader = new URLLoader();
         _urlLoader.addEventListener(Event.COMPLETE,obf_i_O_2744);
         _urlLoader.addEventListener(IOErrorEvent.IO_ERROR,obf_0_v_3463);
         _urlLoader.load(new URLRequest(obf_C_o_3363.replaceUrlVarString(param1)));
      }
      
      private static function obf_i_O_2744(param1:Event) : void
      {
         var _loc2_:String = _urlLoader.data;
         navigateToURL(new URLRequest(_loc2_));
      }
      
      private static function obf_0_v_3463(param1:IOErrorEvent) : void
      {
      }
      
      private static function varShopUI(param1:String) : void
      {
         if(obf_K_e_3075.varShopBoxUI.visible)
         {
            obf_K_e_3075.varShopBoxUI.init(param1);
         }
         else
         {
            obf_K_e_3075.varShopBoxUI.init(param1);
            obf_K_e_3075.showUI(obf_K_e_3075.varShopBoxUI);
         }
      }
   }
}

