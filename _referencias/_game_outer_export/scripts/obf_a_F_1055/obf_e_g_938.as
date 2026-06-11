package obf_a_F_1055
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.JSONUtil;
   import flash.utils.setTimeout;
   
   public class obf_e_g_938 extends obf_0_6_b_250
   {
      
      private var obf_w_F_1319:Object;
      
      private var _talkIndex:int;
      
      private var _menuConfig:Object;
      
      private var _menuIndex:Array;
      
      public function obf_e_g_938(param1:Object, param2:int, param3:Array = null)
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         super();
         this.obf_w_F_1319 = param1;
         this._talkIndex = param2;
         this._menuConfig = this.obf_w_F_1319;
         this._menuIndex = [];
         if(Boolean(param3) && param3.length > 0)
         {
            this._menuIndex = param3;
            this._menuConfig = this.getMenuObj(this._menuIndex);
            if(!this._menuConfig)
            {
               obf_x_0_1295.obf_r_w_3556("obf_N_P_C________21" + param1.label + "obf_____4790" + param3 + "obf___4950！");
            }
         }
         var _loc6_:String = "";
         var _loc7_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(JSONUtil.getStr(this._menuConfig,["limit","numberLimitFlag"]));
         if(JSONUtil.getInt(this._menuConfig,["limit","numberLimitPerDay"]) > 0)
         {
            _loc5_ = JSONUtil.getInt(this._menuConfig,["limit","numberLimitPerDay"]);
            _loc4_ = _loc5_ - JSONUtil.getInt(_loc7_,["numOfDay"]);
         }
         else if(JSONUtil.getInt(this._menuConfig,["limit","numberLimitPerWeek"]) > 0)
         {
            _loc5_ = JSONUtil.getInt(this._menuConfig,["limit","numberLimitPerWeek"]);
            _loc4_ = _loc5_ - JSONUtil.getInt(_loc7_,["numOfWeek"]);
         }
         else if(JSONUtil.getInt(this._menuConfig,["limit","numberLimitPerMonth"]) > 0)
         {
            _loc5_ = JSONUtil.getInt(this._menuConfig,["limit","numberLimitPerMonth"]);
            _loc4_ = _loc5_ - JSONUtil.getInt(_loc7_,["numOfMonth"]);
         }
         if(_loc5_ > 0)
         {
            _loc6_ = DiversityManager.getString("NpcTalkUI","menuCounter",[_loc4_,_loc5_]);
         }
         var _loc8_:String = (this._menuConfig != null ? this._menuConfig.label : DiversityManager.getString("CommonPrompt","unknow")) + _loc6_;
         _loc8_ = obf_K_e_3075.getSwitchString(_loc8_);
         txtLabel.text = _loc8_;
      }
      
      public function get menuConfig() : Object
      {
         return this._menuConfig;
      }
      
      override public function obf_5_y_948() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:Boolean = false;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         super.obf_5_y_948();
         if(!this._menuConfig || !obf_i_7_4475)
         {
            return;
         }
         if(Boolean(this.obf_w_F_1319.condition) && !ConditionScript.checkCondition(this.obf_w_F_1319.condition,null,true))
         {
            return;
         }
         obf_i_7_4475.clearContent();
         if(this._menuConfig.type == obf_m_9_1680.obf_n_Z_785)
         {
            obf_i_7_4475.setTalkContent(this._menuConfig.talk);
            obf_i_7_4475.addMenus(this.getChildMenus(this._menuIndex));
         }
         else if(this._menuConfig.type == obf_m_9_1680.obf_x_4654)
         {
            if(this._menuConfig.action == obf_K_i_1311.obf_1_J_2800)
            {
               _loc1_ = this._menuIndex.concat();
               if(_loc1_.length <= 1)
               {
                  obf_i_7_4475.refreshMenu();
               }
               else
               {
                  _loc1_.pop();
                  _loc1_.pop();
                  obf_i_7_4475.setTalkContent(this.getMenuObj(_loc1_).talk);
                  obf_i_7_4475.addMenus(this.getChildMenus(_loc1_));
               }
            }
            else if(this._menuConfig.action == obf_K_i_1311.obf_5_4_2527)
            {
               obf_i_7_4475.refreshMenu();
            }
            else if(this._menuConfig.action == obf_K_i_1311.obf_w_E_3247)
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
            }
            else
            {
               obf_K_i_1311.obf_c_e_781(this._menuConfig.action,obf_i_7_4475,obf_i_7_4475.npcId,[this._talkIndex].concat(this._menuIndex));
            }
         }
         else if(this._menuConfig.type == obf_m_9_1680.obf_e_Z_4056)
         {
            if(Boolean(this._menuConfig.condition) && !ConditionScript.checkCondition(this._menuConfig.condition,null,true))
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
               return;
            }
            if(!this.obf_Q_4688(this._menuConfig,true))
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
               return;
            }
            if(this._menuConfig.functionIndex == obf_Z_2951.obf_0_8_E_432)
            {
               _loc5_ = WorldConfig.getObjectSetting("mapHonorShopLsit") as Array;
               _loc6_ = false;
               if(_loc5_)
               {
                  _loc7_ = 0;
                  while(_loc7_ < _loc5_.length)
                  {
                     if(JSONUtil.getStr(this._menuConfig.functionPara,["type"]) == _loc5_[_loc7_])
                     {
                        _loc6_ = true;
                        if(obf_K_e_3075.armyShopUI)
                        {
                           obf_K_e_3075.armyShopUI.showArmyShop(obf_i_7_4475.npcId,_loc5_[_loc7_]);
                           break;
                        }
                     }
                     _loc7_++;
                  }
               }
               if(!_loc6_ && Boolean(obf_K_e_3075.assembleBoxUI))
               {
                  obf_K_e_3075.assembleBoxUI.show(obf_i_7_4475.npcId,JSONUtil.getStr(this._menuConfig.functionPara,["type"]),[this._talkIndex].concat(this._menuIndex));
               }
            }
            else if(this._menuConfig.functionIndex == obf_Z_2951.obf_P_l_2676)
            {
               if(obf_K_e_3075.depotBagUI)
               {
                  obf_K_e_3075.depotBagUI.showDepotBag(obf_i_7_4475.npcId,[this._talkIndex].concat(this._menuIndex));
               }
            }
            else if(this._menuConfig.functionIndex == obf_Z_2951.obf_W_B_4079)
            {
               if(obf_K_e_3075.depotTwoBagUI)
               {
                  obf_K_e_3075.depotTwoBagUI.showDepotBag(obf_i_7_4475.npcId,[this._talkIndex].concat(this._menuIndex));
               }
            }
            else if(this._menuConfig.functionIndex == obf_Z_2951.obf_0_7_8_252)
            {
               if(obf_K_e_3075.depotThreeBagUI)
               {
                  obf_K_e_3075.depotThreeBagUI.showDepotBag(obf_i_7_4475.npcId,[this._talkIndex].concat(this._menuIndex));
               }
            }
            else if(this._menuConfig.functionIndex == obf_Z_2951.obf_z_y_1097)
            {
               if(obf_K_e_3075.rankingUI)
               {
                  obf_K_e_3075.rankingUI.showRanking(obf_i_7_4475.npcId,[this._talkIndex].concat(this._menuIndex));
               }
            }
            else if(this._menuConfig.functionIndex == obf_Z_2951.obf_w_i_t_h_3114)
            {
               if(obf_K_e_3075.obf_l_H_2916)
               {
                  obf_K_e_3075.obf_l_H_2916.showAgent(obf_i_7_4475.npcId,[this._talkIndex].concat(this._menuIndex));
               }
            }
            else if(this._menuConfig.functionIndex == obf_Z_2951.obf_T_H_3037)
            {
               if(obf_K_e_3075.npcShopUI)
               {
                  obf_K_e_3075.npcShopUI.showNpcShop(obf_i_7_4475.npcId,JSONUtil.getObject(this._menuConfig,["functionPara","kindList"]) as Array,[this._talkIndex].concat(this._menuIndex));
               }
            }
            else if(this._menuConfig.functionIndex == obf_Z_2951.obf_0_7_G_573)
            {
               WindowManager.showInputBox(DiversityManager.getString("FamilyBoxUI","prompt_InputDisabelSpeaker"),null,{
                  "npcId":obf_i_7_4475.npcId,
                  "menuIndex":[this._talkIndex].concat(this._menuIndex)
               },0,false,obf_K_i_1311.confirmDisableSpeak);
            }
            else if(this._menuConfig.functionIndex == obf_Z_2951.obf_J_Z_2967)
            {
               if(obf_K_e_3075.varShopBoxUI.visible)
               {
                  obf_K_e_3075.varShopBoxUI.init(JSONUtil.getStr(this._menuConfig,["functionPara","varShopId"]));
               }
               else
               {
                  obf_K_e_3075.varShopBoxUI.init(JSONUtil.getStr(this._menuConfig,["functionPara","varShopId"]));
                  obf_K_e_3075.showUI(obf_K_e_3075.varShopBoxUI);
               }
            }
            else
            {
               obf_K_i_1311.sendMenuAction(obf_i_7_4475.npcId,[this._talkIndex].concat(this._menuIndex));
            }
            _loc2_ = WorldConfig.getObjectSetting("scriptNpcList") as Array;
            _loc3_ = false;
            for each(_loc4_ in _loc2_)
            {
               if(obf_i_7_4475.npcId == _loc4_ || obf_i_7_4475.npcId + "@" + obf_i_7_4475.npcMapId == _loc4_)
               {
                  _loc3_ = true;
                  break;
               }
            }
            if(_loc3_)
            {
               setTimeout(this.obf_3_0_2046,500);
            }
            else
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
            }
         }
      }
      
      private function obf_3_0_2046() : void
      {
         var _loc1_:Array = this._menuIndex.concat();
         if(_loc1_.length <= 1)
         {
            obf_i_7_4475.refreshMenu();
         }
         else
         {
            _loc1_.pop();
            _loc1_.pop();
            obf_i_7_4475.setTalkContent(this.getMenuObj(_loc1_).talk);
            obf_i_7_4475.addMenus(this.getChildMenus(_loc1_));
         }
      }
      
      public function obf_Q_4688(param1:Object, param2:Boolean = false) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(param1.functionIndex == obf_Z_2951.obf_P_5_3794 && Boolean(param1.functionPara))
         {
            for(_loc3_ in param1.functionPara)
            {
               if(_loc3_ == "costItems")
               {
                  if(!ConditionScript.itemsInBag(param1.functionPara[_loc3_]))
                  {
                     if(param2)
                     {
                        obf_K_e_3075.showTipInfo(ConditionScript.getConditionHTML("itemsInBag",param1.functionPara[_loc3_],true));
                     }
                     return false;
                  }
               }
               else if(_loc3_ == "costOther")
               {
                  for(_loc4_ in param1.functionPara[_loc3_])
                  {
                     if(_loc4_ == "gold")
                     {
                        if(!ConditionScript.goldGE(param1.functionPara[_loc3_][_loc4_]))
                        {
                           if(param2)
                           {
                              obf_K_e_3075.showTipInfo(ConditionScript.getConditionHTML("gold>=",param1.functionPara[_loc3_][_loc4_],true));
                           }
                           return false;
                        }
                     }
                     else if(_loc4_ == "money")
                     {
                        if(!ConditionScript.moneyGE(param1.functionPara[_loc3_][_loc4_]))
                        {
                           if(param2)
                           {
                              obf_K_e_3075.showTipInfo(ConditionScript.getConditionHTML("money>=",param1.functionPara[_loc3_][_loc4_],true));
                           }
                           return false;
                        }
                     }
                     else if(_loc4_ == "roleExp")
                     {
                        if(GameContext.localPlayer.fullInfo.exp < param1.functionPara[_loc3_][_loc4_])
                        {
                           if(param2)
                           {
                              obf_K_e_3075.showTipInfo(DiversityManager.getString("ConditionPrompt","needPlayerExp",[param1.functionPara[_loc3_][_loc4_]]));
                           }
                           return false;
                        }
                     }
                  }
               }
               else if(_loc3_ == "disabledIfAnyItemInBag")
               {
                  for each(_loc5_ in param1.functionPara[_loc3_])
                  {
                     if(!obf_K_e_3075.playerBagUI)
                     {
                        return false;
                     }
                     if(obf_K_e_3075.playerBagUI.getIconItemBagByCode(_loc5_))
                     {
                        if(param2)
                        {
                           obf_K_e_3075.showTipInfo(DiversityManager.getString("ConditionPrompt","cantHaveItemInBag",[GameItemManager.getItemName(_loc5_)]));
                        }
                        return false;
                     }
                  }
               }
            }
         }
         return true;
      }
      
      public function getMenuObj(param1:Array) : Object
      {
         var _loc3_:int = 0;
         if(!param1 || param1.length == 0)
         {
            return this.obf_w_F_1319;
         }
         var _loc2_:Object = this.obf_w_F_1319;
         for each(_loc3_ in param1)
         {
            if(!_loc2_)
            {
               break;
            }
            _loc2_ = _loc2_.menus[_loc3_];
         }
         return _loc2_;
      }
      
      public function getChildMenus(param1:Array) : Array
      {
         var _loc5_:Object = null;
         var _loc6_:obf_e_g_938 = null;
         if(!param1)
         {
            return null;
         }
         var _loc2_:Object = this.getMenuObj(param1);
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:Array = new Array();
         var _loc4_:int = 0;
         for(; _loc4_ < _loc2_.menus.length; _loc4_++)
         {
            _loc5_ = _loc2_.menus[_loc4_];
            if((Boolean(_loc5_)) && Boolean(_loc5_.activity) && _loc5_.activity.length > 0)
            {
               if(!obf_J_F_3431.obf_U_Q_3887(_loc5_.activity))
               {
                  continue;
               }
            }
            _loc6_ = new obf_e_g_938(this.obf_w_F_1319,this._talkIndex,param1.concat(_loc4_));
            _loc3_.push(_loc6_);
         }
         return _loc3_;
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

