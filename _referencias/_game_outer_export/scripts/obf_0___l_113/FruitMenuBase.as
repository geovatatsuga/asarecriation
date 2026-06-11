package obf_0___l_113
{
   import obf_a_F_1055.obf_K_i_1311;
   import obf_a_F_1055.obf_Z_2951;
   import obf_a_F_1055.obf_e_g_938;
   import obf_a_F_1055.obf_m_9_1680;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.JSONUtil;
   
   public class FruitMenuBase extends obf_e_g_938
   {
      
      private var obf_w_F_1319:Object;
      
      private var _talkIndex:int;
      
      private var _menuConfig:Object;
      
      private var _menuIndex:Array;
      
      public var count1:int;
      
      public var count2:int;
      
      public function FruitMenuBase(param1:Object, param2:int, param3:Array = null)
      {
         super(param1,param2,param3);
         this.obf_w_F_1319 = param1;
         this._talkIndex = param2;
         this._menuConfig = this.obf_w_F_1319;
         this._menuIndex = [];
         if(Boolean(param3) && param3.length > 0)
         {
            this._menuIndex = param3;
            this._menuConfig = getMenuObj(this._menuIndex);
            if(!this._menuConfig)
            {
               obf_x_0_1295.obf_r_w_3556("obf_N_P_C________21" + param1.label + "obf_____4790" + param3 + "obf___4950！");
            }
         }
         var _loc4_:String = "";
         var _loc5_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(JSONUtil.getStr(this._menuConfig,["limit","numberLimitFlag"]));
         if(JSONUtil.getInt(this._menuConfig,["limit","numberLimitPerDay"]) > 0)
         {
            this.count2 = JSONUtil.getInt(this._menuConfig,["limit","numberLimitPerDay"]);
            this.count1 = this.count2 - JSONUtil.getInt(_loc5_,["numOfDay"]);
         }
         else if(JSONUtil.getInt(this._menuConfig,["limit","numberLimitPerWeek"]) > 0)
         {
            this.count2 = JSONUtil.getInt(this._menuConfig,["limit","numberLimitPerWeek"]);
            this.count1 = this.count2 - JSONUtil.getInt(_loc5_,["numOfWeek"]);
         }
         else if(JSONUtil.getInt(this._menuConfig,["limit","numberLimitPerMonth"]) > 0)
         {
            this.count2 = JSONUtil.getInt(this._menuConfig,["limit","numberLimitPerMonth"]);
            this.count1 = this.count2 - JSONUtil.getInt(_loc5_,["numOfMonth"]);
         }
      }
      
      override public function obf_5_y_948() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         super.obf_5_y_948();
         if(!this._menuConfig || !obf_V_V_990)
         {
            return;
         }
         if(Boolean(this.obf_w_F_1319.condition) && !ConditionScript.checkCondition(this.obf_w_F_1319.condition,null,true))
         {
            return;
         }
         obf_V_V_990.clearMenu();
         if(this._menuConfig.type == obf_m_9_1680.obf_n_Z_785)
         {
            obf_i_7_4475.setTalkContent(this._menuConfig.talk);
            obf_i_7_4475.addMenus(getChildMenus(this._menuIndex));
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
                  obf_i_7_4475.setTalkContent(getMenuObj(_loc1_).talk);
                  obf_i_7_4475.addMenus(getChildMenus(_loc1_));
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
            if(!obf_Q_4688(this._menuConfig,true))
            {
               obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
               return;
            }
            if(this._menuConfig.functionIndex == obf_Z_2951.obf_0_8_E_432)
            {
               _loc2_ = WorldConfig.getObjectSetting("mapHonorShopLsit") as Array;
               _loc3_ = false;
               _loc4_ = 0;
               while(_loc4_ < _loc2_.length)
               {
                  if(JSONUtil.getStr(this._menuConfig.functionPara,["type"]) == _loc2_[_loc4_])
                  {
                     _loc3_ = true;
                  }
                  _loc4_++;
               }
               if(!_loc3_ && Boolean(obf_K_e_3075.assembleBoxUI))
               {
                  obf_K_e_3075.assembleBoxUI.show(obf_V_V_990.npcId,JSONUtil.getStr(this._menuConfig.functionPara,["type"]),[this._talkIndex].concat(this._menuIndex));
               }
            }
            else if(this._menuConfig.functionIndex == obf_Z_2951.obf_P_l_2676)
            {
               if(obf_K_e_3075.depotBagUI)
               {
                  obf_K_e_3075.depotBagUI.showDepotBag(obf_V_V_990.npcId,[this._talkIndex].concat(this._menuIndex));
               }
            }
            else if(this._menuConfig.functionIndex == obf_Z_2951.obf_z_y_1097)
            {
               if(obf_K_e_3075.rankingUI)
               {
                  obf_K_e_3075.rankingUI.showRanking(obf_V_V_990.npcId,[this._talkIndex].concat(this._menuIndex));
               }
            }
            else if(this._menuConfig.functionIndex == obf_Z_2951.obf_w_i_t_h_3114)
            {
               if(obf_K_e_3075.obf_l_H_2916)
               {
                  obf_K_e_3075.obf_l_H_2916.showAgent(obf_V_V_990.npcId,[this._talkIndex].concat(this._menuIndex));
               }
            }
            else if(this._menuConfig.functionIndex == obf_Z_2951.obf_T_H_3037)
            {
               if(obf_K_e_3075.npcShopUI)
               {
                  obf_K_e_3075.npcShopUI.showNpcShop(obf_V_V_990.npcId,JSONUtil.getObject(this._menuConfig,["functionPara","kindList"]) as Array,[this._talkIndex].concat(this._menuIndex));
               }
            }
            else if(this._menuConfig.functionIndex == obf_Z_2951.obf_0_7_G_573)
            {
               WindowManager.showInputBox(DiversityManager.getString("FamilyBoxUI","prompt_InputDisabelSpeaker"),null,{
                  "npcId":obf_V_V_990.npcId,
                  "menuIndex":[this._talkIndex].concat(this._menuIndex)
               },0,false,obf_K_i_1311.confirmDisableSpeak);
            }
            else
            {
               obf_K_i_1311.sendMenuAction(obf_V_V_990.npcId,[this._talkIndex].concat(this._menuIndex));
            }
         }
      }
      
      public function obf_w_2_1037() : void
      {
         var _loc1_:Array = this._menuIndex.concat();
         if(_loc1_.length <= 1)
         {
            obf_V_V_990.resetMenu();
         }
         else
         {
            _loc1_.pop();
            _loc1_.pop();
            obf_V_V_990.addMenus(getChildMenus(_loc1_));
         }
      }
   }
}

