package com.sunweb.game.rpg.playerUI
{
   import com.hurlant.util.Memory;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.armory.obf_S_M_1257;
   import com.sunweb.game.rpg.clientAction.obf_F_2_2975;
   import com.sunweb.game.rpg.constellation.obf_H_B_2569;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.family.obf_F_9_1495;
   import com.sunweb.game.rpg.farm.FarmManager;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.sound.obf_q_6_3634;
   import com.sunweb.game.rpg.stirp.obf_x_B_2963;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.WorldMapManager;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.obf_e_P_918;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.obf_9_V_1635;
   import cursor.CursorFarmRemove;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import playerUI.ControlBarUIMC;
   
   public class ControlBarUI extends ControlBarUIMC implements IPlayerUI, obf_0_d_4341
   {
      
      public static const TARGET_TODO_ACTION_REMOVE:String = "targetToDoActionRemove";
      
      private var _noviceSprite:Sprite;
      
      private var obf_0_a_3668:Number = 1;
      
      private var obf_0_3_f_136:Number = 1;
      
      public function ControlBarUI()
      {
         super();
         this.initDiversity();
         this.onResize(null);
         cmdSoundSwitch.useHandCursor = true;
         cmdBlessGod.visible = !WorldConfig.getValue("functionSwitch","blessGod");
         cmdRoulette.visible = WorldConfig.getValue("functionSwitch","showRoulette");
         cmdStirp.visible = false;
         this.setSocialVisible(false);
         if(!WorldConfig.getObjectSetting("hideStealButton"))
         {
         }
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         obf_9_V_1635.setSimpleButtonTooltip(cmdRide,DiversityManager.getString("ControlBarUI","cmdRide"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdBag,DiversityManager.getString("ControlBarUI","cmdBag"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdQuest,DiversityManager.getString("ControlBarUI","cmdQuest"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdFamily,DiversityManager.getString("ControlBarUI","cmdFamily"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdPet,DiversityManager.getString("ControlBarUI","cmdPet"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdWing,DiversityManager.getString("ControlBarUI","cmdWing"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdRole,DiversityManager.getString("ControlBarUI","cmdRole"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdSkill,DiversityManager.getString("ControlBarUI","cmdSkill"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdFriend,DiversityManager.getString("ControlBarUI","cmdFriend"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdTeam,DiversityManager.getString("ControlBarUI","cmdTeam"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdBot,DiversityManager.getString("ControlBarUI","cmdBot"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdBlessGod,DiversityManager.getString("ControlBarUI","cmdBlessGod"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdSys,DiversityManager.getString("ControlBarUI","cmdSys"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdRoulette,DiversityManager.getString("ControlBarUI","cmdRoulette"));
         obf_9_V_1635.setSimpleButtonTooltip(cmdStirp,DiversityManager.getString("ControlBarUI","cmdStirp"));
      }
      
      private function addListener() : void
      {
         this.addEventListener(Event.ADDED_TO_STAGE,this.obf_u_J_2545);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         cmdBag.addEventListener(MouseEvent.CLICK,this.clickBag);
         cmdRide.addEventListener(MouseEvent.CLICK,this.obf_R_e_813);
         cmdQuest.addEventListener(MouseEvent.CLICK,this.clickTask);
         cmdFamily.addEventListener(MouseEvent.CLICK,this.obf_0___G_630);
         cmdPet.addEventListener(MouseEvent.CLICK,this.obf_9_Z_3156);
         cmdRole.addEventListener(MouseEvent.CLICK,this.obf_9_T_2400);
         cmdWing.addEventListener(MouseEvent.CLICK,this.obf_y_S_4438);
         cmdSkill.addEventListener(MouseEvent.CLICK,this.obf_Q_E_1415);
         cmdFriend.addEventListener(MouseEvent.CLICK,this.clickFriend);
         cmdTeam.addEventListener(MouseEvent.CLICK,this.clickTeam);
         cmdBot.addEventListener(MouseEvent.CLICK,this.obf_c_1666);
         cmdBlessGod.addEventListener(MouseEvent.CLICK,this.obf_F_K_4523);
         cmdSys.addEventListener(MouseEvent.CLICK,this.obf_0_6_s_718);
         GameContext.gameStage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         cmdSoundSwitch.addEventListener(MouseEvent.CLICK,this.obf_0_3_a_686);
         cmdRoulette.addEventListener(MouseEvent.CLICK,this.obf_0_0_Q_81);
         cmdStirp.addEventListener(MouseEvent.CLICK,this.onClickStirp);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.obf_u_J_2545);
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         cmdBag.removeEventListener(MouseEvent.CLICK,this.clickBag);
         cmdRide.removeEventListener(MouseEvent.CLICK,this.obf_R_e_813);
         cmdQuest.removeEventListener(MouseEvent.CLICK,this.clickTask);
         cmdFamily.removeEventListener(MouseEvent.CLICK,this.obf_0___G_630);
         cmdPet.removeEventListener(MouseEvent.CLICK,this.obf_9_Z_3156);
         cmdRole.removeEventListener(MouseEvent.CLICK,this.obf_9_T_2400);
         cmdWing.removeEventListener(MouseEvent.CLICK,this.obf_y_S_4438);
         cmdSkill.removeEventListener(MouseEvent.CLICK,this.obf_Q_E_1415);
         cmdFriend.removeEventListener(MouseEvent.CLICK,this.clickFriend);
         cmdTeam.removeEventListener(MouseEvent.CLICK,this.clickTeam);
         cmdBot.removeEventListener(MouseEvent.CLICK,this.obf_c_1666);
         cmdBlessGod.removeEventListener(MouseEvent.CLICK,this.obf_F_K_4523);
         cmdSys.removeEventListener(MouseEvent.CLICK,this.obf_0_6_s_718);
         GameContext.gameStage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         cmdSoundSwitch.removeEventListener(MouseEvent.CLICK,this.obf_0_3_a_686);
         cmdRoulette.removeEventListener(MouseEvent.CLICK,this.obf_0_0_Q_81);
         cmdStirp.removeEventListener(MouseEvent.CLICK,this.onClickStirp);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight;
      }
      
      private function obf_u_J_2545(param1:Event) : void
      {
         this.initDiversity();
      }
      
      public function set noviceSprite(param1:Sprite) : void
      {
         this._noviceSprite = param1;
      }
      
      public function get noviceSprite() : Sprite
      {
         return this._noviceSprite;
      }
      
      public function get novicePromptName() : String
      {
         return "SystemBarUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         var _loc2_:DisplayObject = this[param1];
         if(!_loc2_)
         {
            return null;
         }
         return new Point(_loc2_.x,_loc2_.y - 25);
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         return this[param1];
      }
      
      public function setSocialVisible(param1:Boolean) : void
      {
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         var _loc3_:Array = null;
         var _loc4_:IconItemBag = null;
         var _loc2_:String = String.fromCharCode(param1.charCode).toUpperCase();
         if(_loc2_ == "B")
         {
            this.clickBag(null);
         }
         else if(_loc2_ != "I")
         {
            if(_loc2_ == "X")
            {
               this.obf_9_Z_3156(null);
            }
            else if(_loc2_ == "C")
            {
               this.obf_9_T_2400(null);
            }
            else if(_loc2_ == "N")
            {
               this.obf_R_e_813(null);
            }
            else if(_loc2_ == "J")
            {
               this.obf_y_S_4438(null);
            }
            else if(_loc2_ == "V")
            {
               this.obf_Q_E_1415(null);
            }
            else if(_loc2_ == "Y")
            {
               this.clickShop(null);
            }
            else if(_loc2_ == "T")
            {
               this.clickTask(null);
            }
            else if(_loc2_ != "O")
            {
               if(_loc2_ == "G")
               {
                  this.obf_0___G_630(null);
               }
               else if(_loc2_ == "P")
               {
                  this.clickTeam(null);
               }
               else if(_loc2_ == "H")
               {
                  if(Boolean(obf_K_e_3075.gmControlBox) && Boolean(GameContext.localPlayer) && GameContext.localPlayer.fullInfo.isGM)
                  {
                     if(obf_K_e_3075.gmControlBox.visible)
                     {
                        obf_K_e_3075.closeUI(obf_K_e_3075.gmControlBox);
                     }
                     else
                     {
                        obf_K_e_3075.showUI(obf_K_e_3075.gmControlBox);
                     }
                  }
                  if(GameContext.gameFocusManager)
                  {
                     GameContext.gameFocusManager.setFocus(null);
                  }
               }
               else if(_loc2_ == "/")
               {
                  if(obf_K_e_3075.smallMapUI)
                  {
                     obf_K_e_3075.smallMapUI.setRemoteDisplay();
                  }
               }
               else if(_loc2_ == "M")
               {
                  if(obf_K_e_3075.mapUI)
                  {
                     if(obf_K_e_3075.mapUI.visible)
                     {
                        obf_K_e_3075.closeUI(obf_K_e_3075.mapUI);
                     }
                     else
                     {
                        obf_K_e_3075.showUI(obf_K_e_3075.mapUI);
                     }
                  }
               }
               else if(_loc2_ == ",")
               {
                  if(obf_K_e_3075.worldMapUI)
                  {
                     if(obf_K_e_3075.worldMapUI.visible)
                     {
                        obf_K_e_3075.closeUI(obf_K_e_3075.worldMapUI);
                     }
                     else
                     {
                        obf_K_e_3075.showUI(obf_K_e_3075.worldMapUI);
                     }
                  }
               }
               else if(_loc2_ == "U")
               {
                  GameContext.localPlayer.obf_n_4015(!GameContext.localPlayer.fullInfo.isSitting);
               }
               else if(_loc2_ == "Z")
               {
                  if(obf_K_e_3075.rideBoxUI)
                  {
                     _loc3_ = [obf_K_e_3075.playerFullInfoUI.getRideBag()].concat(obf_K_e_3075.rideBoxUI.rideBags);
                     for each(_loc4_ in _loc3_)
                     {
                        if(!_loc4_.isLocked && Boolean(_loc4_.haveIconItem))
                        {
                           _loc4_.haveIconItem.useIcon();
                           break;
                        }
                     }
                  }
               }
               else if(_loc2_ == ".")
               {
                  obf_K_e_3075.obf_f_a_l_s_e_334.startOrStopBot();
               }
               else if(_loc2_ == "\'")
               {
                  return;
               }
            }
         }
         if(param1.keyCode == Keyboard.F2)
         {
            Memory.gc();
            obf_x_0_1295.obf_r_w_3556("Memory gc =======");
         }
      }
      
      private function onMouseOver(param1:Event) : void
      {
         obf_e_P_918.useDefaultCursor();
      }
      
      private function clickRemove(param1:Event) : void
      {
         GameContext.localPlayer.obf_F_S_2208(FarmManager.removeHarvest,[],TARGET_TODO_ACTION_REMOVE);
         obf_e_P_918.setDefaultCursor(new CursorFarmRemove());
      }
      
      private function obf_W_q_1622(param1:Event) : void
      {
         if(!obf_K_e_3075.obf_0_3_j_588)
         {
            return;
         }
         if(obf_K_e_3075.obf_0_3_j_588.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_0_3_j_588);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_0_3_j_588);
         }
      }
      
      private function obf_0_0_Q_81(param1:Event) : void
      {
         if(!obf_K_e_3075.obf_y_P_4288)
         {
            return;
         }
         if(obf_K_e_3075.obf_y_P_4288.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_y_P_4288);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_y_P_4288);
         }
      }
      
      private function obf_0_1_y_206(param1:Event) : void
      {
         if(!obf_K_e_3075.constellationUI)
         {
            return;
         }
         if(obf_K_e_3075.constellationUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.constellationUI);
         }
         else if(obf_H_B_2569.obf_M_4_3195())
         {
            obf_K_e_3075.showUI(obf_K_e_3075.constellationUI);
         }
      }
      
      private function onClickStirp(param1:MouseEvent) : void
      {
         if(obf_K_e_3075.stirpBoxUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.stirpBoxUI);
         }
         else if(obf_x_B_2963.checkOpenStirp())
         {
            obf_K_e_3075.showUI(obf_K_e_3075.stirpBoxUI);
         }
      }
      
      private function obf_9_B_3369(param1:Event) : void
      {
         if(obf_K_e_3075.obf_s_g_3090.visible)
         {
            obf_F_2_2975.obf_O_p_3236("closeui ArmoryUI");
         }
         else if(obf_S_M_1257.obf_a_3592(true))
         {
            obf_F_2_2975.obf_O_p_3236("showui ArmoryUI");
         }
      }
      
      private function obf_V_m_1051(param1:MouseEvent) : void
      {
         if(!obf_K_e_3075.bossFeedUI)
         {
            return;
         }
         if(obf_K_e_3075.bossFeedUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.bossFeedUI);
         }
         else if(obf_F_9_1495.obf_0___q_426(true))
         {
            obf_K_e_3075.showUI(obf_K_e_3075.bossFeedUI);
         }
      }
      
      private function clickTask(param1:Event) : void
      {
         if(!obf_K_e_3075.playerTaskUI)
         {
            return;
         }
         if(obf_K_e_3075.playerTaskUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.playerTaskUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.playerTaskUI);
         }
      }
      
      private function clickBag(param1:Event) : void
      {
         if(!obf_K_e_3075.playerBagUI)
         {
            return;
         }
         if(obf_K_e_3075.playerBagUI.visible)
         {
            obf_F_2_2975.obf_O_p_3236("closeui BagUI");
         }
         else
         {
            obf_F_2_2975.obf_O_p_3236("showui BagUI");
         }
      }
      
      private function obf_R_e_813(param1:Event) : void
      {
         if(!obf_K_e_3075.playerBagUI)
         {
            return;
         }
         obf_F_2_2975.obf_O_p_3236((obf_K_e_3075.rideBoxUI.visible ? "closeui" : "showui") + " RideBoxUI");
      }
      
      private function obf_y_S_4438(param1:Event) : void
      {
         if(!obf_K_e_3075.wingBoxUI)
         {
            return;
         }
         obf_F_2_2975.obf_O_p_3236((obf_K_e_3075.wingBoxUI.visible ? "closeui" : "showui") + " WingBoxUI");
      }
      
      private function obf_9_T_2400(param1:Event) : void
      {
         if(!obf_K_e_3075.playerBoxUI)
         {
            return;
         }
         if(obf_K_e_3075.playerBoxUI.visible)
         {
            obf_F_2_2975.obf_O_p_3236("closeui RoleInfoUI");
         }
         else
         {
            obf_F_2_2975.obf_O_p_3236("showui RoleInfoUI");
         }
      }
      
      private function obf_9_O_1181(param1:Event) : void
      {
      }
      
      private function obf_Q_E_1415(param1:Event) : void
      {
         if(obf_K_e_3075.skillBookUI.visible)
         {
            obf_F_2_2975.obf_O_p_3236("closeui SkillBookUI");
         }
         else
         {
            obf_F_2_2975.obf_O_p_3236("showui SkillBookUI");
         }
      }
      
      private function clickFarm(param1:Event) : void
      {
         if(!obf_K_e_3075.obf_W_a_1063)
         {
            return;
         }
         if(obf_K_e_3075.obf_W_a_1063.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.obf_W_a_1063);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.obf_W_a_1063);
         }
      }
      
      private function clickSocial(param1:Event) : void
      {
      }
      
      private function clickFriend(param1:Event) : void
      {
         if(!obf_K_e_3075.obf_w_f_4556)
         {
            return;
         }
         if(obf_K_e_3075.obf_w_f_4556.visible)
         {
            obf_F_2_2975.obf_O_p_3236("closeui FriendUI");
         }
         else
         {
            obf_F_2_2975.obf_O_p_3236("showui FriendUI");
         }
      }
      
      private function obf_0___G_630(param1:Event) : void
      {
         if(!obf_K_e_3075.familyBoxUI)
         {
            return;
         }
         if(!GameContext.localPlayer.familyInfo)
         {
            if(obf_K_e_3075.familyListUI.visible)
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.familyListUI);
            }
            else
            {
               obf_K_e_3075.showUI(obf_K_e_3075.familyListUI);
            }
         }
         else if(obf_K_e_3075.familyBoxUI.visible)
         {
            obf_F_2_2975.obf_O_p_3236("closeui GuildUI");
         }
         else
         {
            obf_F_2_2975.obf_O_p_3236("showui GuildUI");
         }
      }
      
      private function obf_9_Z_3156(param1:Event) : void
      {
         if(obf_K_e_3075.petBoxContainerUI.visible)
         {
            obf_F_2_2975.obf_O_p_3236("closeui PetBoxContainerUI");
         }
         else
         {
            obf_F_2_2975.obf_O_p_3236("showui PetBoxContainerUI");
         }
      }
      
      private function clickTeam(param1:Event) : void
      {
         if(!obf_K_e_3075.teamManagerUI)
         {
            return;
         }
         if(obf_K_e_3075.teamManagerUI.visible)
         {
            obf_F_2_2975.obf_O_p_3236("closeui TeamUI");
         }
         else
         {
            obf_F_2_2975.obf_O_p_3236("showui TeamUI");
         }
      }
      
      private function obf_c_1666(param1:Event) : void
      {
         if(!obf_K_e_3075.obf_f_a_l_s_e_334)
         {
            return;
         }
         if(obf_K_e_3075.obf_f_a_l_s_e_334.visible)
         {
            obf_F_2_2975.obf_O_p_3236("closeui BotUI");
         }
         else
         {
            obf_F_2_2975.obf_O_p_3236("showui BotUI");
         }
      }
      
      private function obf_F_K_4523(param1:Event) : void
      {
         if(!obf_K_e_3075.playerBlessUI)
         {
            return;
         }
         if(GameContext.localPlayer.fullInfo.beliefGod <= 0)
         {
            WindowManager.showMessageBox(DiversityManager.getString("BlessUI","prompt_NeedBeliefGod"));
            return;
         }
         obf_F_2_2975.obf_O_p_3236((obf_K_e_3075.playerBlessUI.visible ? "closeui" : "showui") + " BlessUI");
      }
      
      private function obf_0_6_s_718(param1:Event) : void
      {
         if(!obf_K_e_3075.systemSettingUI)
         {
            return;
         }
         if(obf_K_e_3075.systemSettingUI.visible)
         {
            obf_F_2_2975.obf_O_p_3236("closeui SystemUI");
         }
         else
         {
            obf_F_2_2975.obf_O_p_3236("showui SystemUI");
         }
      }
      
      private function obf_0_3_a_686(param1:Event) : void
      {
         if(obf_q_6_3634.obf_T_T_4349.volume <= 0)
         {
            obf_q_6_3634.obf_T_T_4349.volume = this.obf_0_a_3668;
            obf_q_6_3634.obf_G_y_2255.volume = this.obf_0_3_f_136;
            obf_q_6_3634.updateMusicVolume();
         }
         else
         {
            this.obf_0_a_3668 = obf_q_6_3634.obf_T_T_4349.volume;
            this.obf_0_3_f_136 = obf_q_6_3634.obf_G_y_2255.volume;
            obf_q_6_3634.obf_T_T_4349.volume = 0;
            obf_q_6_3634.obf_G_y_2255.volume = 0;
            obf_q_6_3634.updateMusicVolume();
         }
      }
      
      private function clickShop(param1:Event) : void
      {
         if(WorldConfig.getValue("functionSwitch","store") == true)
         {
            return;
         }
         if(WorldConfig.getValue("functionSwitch","showNewShop"))
         {
            if(!obf_K_e_3075.newShopBoxUI)
            {
               return;
            }
            if(obf_K_e_3075.newShopBoxUI.visible)
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.newShopBoxUI);
            }
            else
            {
               obf_K_e_3075.showUI(obf_K_e_3075.newShopBoxUI);
            }
         }
         else
         {
            if(!obf_K_e_3075.obf_N_i_3901)
            {
               return;
            }
            if(obf_K_e_3075.obf_N_i_3901.visible)
            {
               obf_F_2_2975.obf_O_p_3236("closeui ShopUI");
            }
            else
            {
               obf_F_2_2975.obf_O_p_3236("showui ShopUI");
            }
         }
      }
      
      private function obf_0_6_F_101(param1:Event) : void
      {
         FarmManager.teleportToFarm(GameContext.localPlayer.fullInfo.mainFarm.farmId + "@" + GameContext.localPlayer.fullInfo.mainFarm.mapId,"");
      }
      
      private function obf_q_R_1761(param1:Event) : void
      {
         obf_K_e_3075.worldMapUI.teleportToMap(WorldMapManager.getLandMainCityCode(GameContext.localPlayer.mapId));
      }
      
      private function obf_6_8_4403(param1:Event) : void
      {
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

