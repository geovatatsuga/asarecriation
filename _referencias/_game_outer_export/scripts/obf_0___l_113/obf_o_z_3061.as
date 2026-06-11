package obf_0___l_113
{
   import obf_a_F_1055.obf_0_6_b_250;
   import obf_a_F_1055.obf_b_f_2719;
   import obf_a_F_1055.obf_o_I_4492;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.AncientTreeUI;
   import playerUI.CallTreeUI;
   import playerUI.EnergyTreeUI;
   import playerUI.ForeverTreeUI;
   import playerUI.FruitBoxUIMC;
   import playerUI.LifeTreeUI;
   import playerUI.WarTreeUI;
   
   public class obf_o_z_3061 extends FruitBoxUIMC implements IPlayerUI
   {
      
      private var obf_0_1_C_451:obf_o_Q_2118;
      
      private var menus:Array;
      
      private var obf_y_7_947:Array;
      
      private var callMenu:FruitMenuBase;
      
      public var obf_0_5_3970:obf_0_6_b_250;
      
      private var allCon:int;
      
      private var obf_j_V_2568:int;
      
      private var goldNpc:obf_o_Q_2118;
      
      private var moneyNpc:obf_o_Q_2118;
      
      public function obf_o_z_3061()
      {
         var _loc2_:Object = null;
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         this.visible = false;
         this.menus = new Array();
         this.obf_y_7_947 = new Array();
         this.addListener();
         this.obf_0_5_3970 = new obf_0_6_b_250();
         var _loc1_:Array = WorldConfig.getObjectSetting("npcList") as Array;
         for each(_loc2_ in _loc1_)
         {
            _loc2_.name = "";
            if(_loc2_.fruitType == obf_N_3_4290.obf_U_M_2463)
            {
               this.goldNpc = new obf_o_Q_2118(_loc2_,null);
            }
            else if(_loc2_.fruitType == obf_N_3_4290.obf_q_3_1816)
            {
               this.moneyNpc = new obf_o_Q_2118(_loc2_,null);
            }
         }
         this.initTreeShow(this.goldNpc);
      }
      
      private function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         goldFruit.addEventListener(MouseEvent.CLICK,this.obf_r_9_3010);
         moneyFruit.addEventListener(MouseEvent.CLICK,this.obf_0_3_V_325);
      }
      
      private function obf_I_g_2025() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         goldFruit.removeEventListener(MouseEvent.CLICK,this.obf_r_9_3010);
         moneyFruit.removeEventListener(MouseEvent.CLICK,this.obf_0_3_V_325);
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      public function get npcId() : String
      {
         return this.obf_0_1_C_451.id;
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      public function obf_S_L_1164() : void
      {
         while(moneyPoint.numChildren > 0)
         {
            moneyPoint.removeChildAt(0);
         }
         moneyPoint.addChild(obf_a_f_2935.getMoneyDisplay(GameContext.localPlayer.fullInfo.money));
         var _loc1_:Array = obf_a_f_2935.getGoldRank(GameContext.localPlayer.fullInfo.gold);
         txtDiamond.text = _loc1_[0] + "";
         txtGold.text = _loc1_[1] + "";
         txtSilver.text = _loc1_[2] + "";
         txtCopper.text = _loc1_[3] + "";
      }
      
      public function obf_X_T_3284(param1:MovieClip, param2:Number, param3:int) : void
      {
         while(param1.moneyPoint.numChildren > 0)
         {
            param1.moneyPoint.removeChildAt(0);
         }
         var _loc4_:Array = obf_a_f_2935.getGoldRank(param2);
         param1.txtDiamond.text = _loc4_[0] + "";
         param1.txtGold.text = _loc4_[1] + "";
         param1.txtSilver.text = _loc4_[2] + "";
         param1.txtCopper.text = _loc4_[3] + "";
         param1.moneyPoint.addChild(obf_a_f_2935.getMoneyDisplay(param3));
      }
      
      public function initTreeShow(param1:obf_o_Q_2118) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:Boolean = false;
         var _loc5_:FruitMenuBase = null;
         var _loc6_:CallTreeUI = null;
         if(!param1)
         {
            return;
         }
         this.obf_0_1_C_451 = param1;
         if(param1.npcConfig.fruitType == obf_N_3_4290.obf_U_M_2463)
         {
            DiversityManager.setTextField(txtSay,"fruitBoxUI","txtSay");
         }
         else if(param1.npcConfig.fruitType == obf_N_3_4290.obf_q_3_1816)
         {
            DiversityManager.setTextField(txtSay,"fruitBoxUI","txtSay1");
         }
         fruitScrollBar.update();
         for(; _loc2_ < param1.menus.length; _loc2_++)
         {
            _loc3_ = param1.menus[_loc2_];
            if(_loc3_)
            {
               if(Boolean(_loc3_.activity) && _loc3_.activity.length > 0)
               {
                  if(!obf_J_F_3431.obf_U_Q_3887(_loc3_.activity))
                  {
                     continue;
                  }
               }
               _loc4_ = false;
               _loc5_ = new FruitMenuBase(_loc3_,_loc2_);
               if(_loc3_.treeType == obf_W_F_908.obf_p_I_2220)
               {
                  _loc5_.obf_0___j_672(new AncientTreeUI());
                  this.obf_T_5_1567(_loc5_,_loc3_);
                  this.allCon = this.obf_j_V_2568 = _loc5_.count2;
               }
               else if(_loc3_.treeType == obf_W_F_908.obf_z_F_4173)
               {
                  _loc5_.obf_0___j_672(new EnergyTreeUI());
                  this.obf_T_5_1567(_loc5_,_loc3_);
               }
               else if(_loc3_.treeType == obf_W_F_908.obf_F_U_2687)
               {
                  _loc5_.obf_0___j_672(new ForeverTreeUI());
                  this.obf_T_5_1567(_loc5_,_loc3_);
               }
               else if(_loc3_.treeType == obf_W_F_908.obf_v_J_1381)
               {
                  _loc5_.obf_0___j_672(new LifeTreeUI());
                  this.obf_T_5_1567(_loc5_,_loc3_);
               }
               else if(_loc3_.treeType == obf_W_F_908.obf_r_A_4292)
               {
                  _loc5_.obf_0___j_672(new WarTreeUI());
                  this.obf_T_5_1567(_loc5_,_loc3_);
               }
               else if(_loc3_.treeType == obf_W_F_908.obf_A_d_4491)
               {
                  _loc6_ = new CallTreeUI();
                  _loc6_.cmdMoney.label = DiversityManager.getString("fruitBoxUI","cmdMoney");
                  _loc5_.obf_0___j_672(_loc6_);
                  buttonPoint.addChild(_loc5_ as DisplayObject);
                  _loc4_ = true;
               }
               _loc5_.addEventListener(MouseEvent.CLICK,this.onClickMenu);
               _loc5_.obf_V_V_990 = this;
               if(!_loc4_)
               {
                  this.obf_y_7_947.push(_loc5_);
               }
               else
               {
                  this.callMenu = _loc5_;
               }
            }
         }
      }
      
      public function refreshMenu() : void
      {
         var _loc1_:obf_o_I_4492 = null;
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:obf_o_I_4492 = null;
         var _loc8_:obf_o_I_4492 = null;
         var _loc9_:obf_o_I_4492 = null;
         var _loc10_:obf_o_I_4492 = null;
         var _loc11_:Object = null;
         var _loc12_:FruitMenuBase = null;
         if(!this.obf_0_1_C_451)
         {
            return;
         }
         this.clearContent();
         for each(_loc2_ in this.obf_0_1_C_451.receiveTaskMenus)
         {
            if(_loc2_.receiveRule.npcMenuReceive)
            {
               _loc7_ = new obf_o_I_4492(_loc2_.receiveRule.npcMenuReceive,_loc2_.taskId,-1,obf_o_I_4492.obf_W_W_3673);
               if(_loc2_.receiveRule.autoReceive)
               {
                  _loc1_ = _loc7_;
               }
               this.addMenu(_loc7_);
            }
         }
         for each(_loc3_ in this.obf_0_1_C_451.promptTaskMenus)
         {
            if(_loc3_.receiveRule.npcMenuReceive)
            {
               _loc8_ = new obf_o_I_4492(_loc3_.receiveRule.npcMenuReceive,_loc3_.taskId,-1,obf_o_I_4492.obf_W_W_3673);
               this.addMenu(_loc8_);
            }
         }
         for each(_loc4_ in this.obf_0_1_C_451.finishTaskMenus)
         {
            if(_loc4_.finishRule.npcMenuFinish)
            {
               _loc9_ = new obf_o_I_4492(_loc4_.finishRule.npcMenuFinish,_loc4_.taskId,-1,obf_o_I_4492.obf_A_Y_3125);
               if(_loc4_.finishRule.autoFinish)
               {
                  _loc1_ = _loc9_;
               }
               this.addMenu(_loc9_);
            }
         }
         for each(_loc5_ in this.obf_0_1_C_451.doingTaskMenus)
         {
            if(_loc5_.finishRule.npcMenuQuery)
            {
               _loc10_ = new obf_o_I_4492(_loc5_.finishRule.npcMenuQuery,_loc5_.taskId,-1,obf_o_I_4492.obf_K_6_4447);
               this.addMenu(_loc10_);
            }
         }
         for(; _loc6_ < this.obf_0_1_C_451.menus.length; _loc6_++)
         {
            _loc11_ = this.obf_0_1_C_451.menus[_loc6_];
            if(_loc11_)
            {
               if(Boolean(_loc11_.activity) && _loc11_.activity.length > 0)
               {
                  if(!obf_J_F_3431.obf_U_Q_3887(_loc11_.activity))
                  {
                     continue;
                  }
               }
               _loc12_ = new FruitMenuBase(_loc11_,_loc6_);
               this.addMenu(_loc12_);
            }
         }
         if(_loc1_)
         {
            this.obf_5_y_948(_loc1_);
         }
      }
      
      public function resetMenu() : void
      {
         var _loc1_:FruitMenuBase = null;
         if(!this.obf_0_1_C_451)
         {
            return;
         }
         this.clearMenu();
         for each(_loc1_ in this.obf_y_7_947)
         {
            this.addMenu(_loc1_);
         }
      }
      
      public function addMenu(param1:obf_0_6_b_250) : void
      {
         param1.isLocked = false;
         if(param1 is FruitMenuBase)
         {
            if(Boolean((param1 as FruitMenuBase).menuConfig.hideRule) && Boolean(!ConditionScript.isEmptyPar((param1 as FruitMenuBase).menuConfig.hideRule)) && ConditionScript.checkCondition((param1 as FruitMenuBase).menuConfig.hideRule))
            {
               param1.isLocked = true;
            }
            if(Boolean((param1 as FruitMenuBase).menuConfig.showRule) && Boolean(!ConditionScript.isEmptyPar((param1 as FruitMenuBase).menuConfig.showRule)) && !ConditionScript.checkCondition((param1 as FruitMenuBase).menuConfig.showRule))
            {
               param1.isLocked = true;
            }
         }
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter(JSONUtil.getStr((param1 as FruitMenuBase).menuConfig,["limit","numberLimitFlag"]));
         if(JSONUtil.getInt((param1 as FruitMenuBase).menuConfig,["limit","numberLimitPerDay"]) > 0)
         {
            this.obf_j_V_2568 = this.allCon - JSONUtil.getInt(_loc2_,["numOfDay"]);
         }
         else if(JSONUtil.getInt((param1 as FruitMenuBase).menuConfig,["limit","numberLimitPerWeek"]) > 0)
         {
            this.obf_j_V_2568 = this.allCon - JSONUtil.getInt(_loc2_,["numOfWeek"]);
         }
         else if(JSONUtil.getInt((param1 as FruitMenuBase).menuConfig,["limit","numberLimitPerMonth"]) > 0)
         {
            this.obf_j_V_2568 = this.allCon - JSONUtil.getInt(_loc2_,["numOfMonth"]);
         }
         DiversityManager.setTextField(allNum,"NpcTalkUI","menuCounter",[this.obf_j_V_2568,this.allCon]);
      }
      
      private function obf_T_5_1567(param1:DisplayObject, param2:Object) : void
      {
         if(!param2 || !param2.condition)
         {
            return;
         }
         if(param2.treeType == obf_W_F_908.obf_z_F_4173)
         {
            this.obf_X_T_3284(goldBox0,param2.condition["gold>="],param2.condition["money>="]);
         }
         else if(param2.treeType == obf_W_F_908.obf_v_J_1381)
         {
            param1.x = (param1.width + 35) * 2;
            this.obf_X_T_3284(goldBox2,param2.condition["gold>="],param2.condition["money>="]);
         }
         else if(param2.treeType == obf_W_F_908.obf_F_U_2687)
         {
            param1.x = (param1.width + 35) * 4;
            this.obf_X_T_3284(goldBox4,param2.condition["gold>="],param2.condition["money>="]);
         }
         else if(param2.treeType == obf_W_F_908.obf_p_I_2220)
         {
            param1.x = (param1.width + 35) * 3;
            this.obf_X_T_3284(goldBox3,param2.condition["gold>="],param2.condition["money>="]);
         }
         else if(param2.treeType == obf_W_F_908.obf_r_A_4292)
         {
            param1.x = (param1.width + 35) * 1;
            this.obf_X_T_3284(goldBox1,param2.condition["gold>="],param2.condition["money>="]);
         }
         imagePoint.addChild(param1);
      }
      
      public function addMenus(param1:Array) : void
      {
         var _loc2_:obf_0_6_b_250 = null;
         for each(_loc2_ in param1)
         {
            this.addMenu(_loc2_);
         }
      }
      
      private function onClickMenu(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(!(param1.currentTarget is obf_b_f_2719) || (param1.currentTarget as obf_0_6_b_250).isLocked)
         {
            return;
         }
         this.obf_0_5_3970 = param1.currentTarget as obf_0_6_b_250;
         if(param1.currentTarget == this.callMenu)
         {
            _loc2_ = JSONUtil.getInt((param1.currentTarget as FruitMenuBase).menuConfig,["condition","money>="]);
            WindowManager.showConfirmBox(DiversityManager.getString("fruitBoxUI","buyMoney",[_loc2_]),this.callBuy);
            return;
         }
         this.obf_5_y_948(param1.currentTarget as obf_b_f_2719);
      }
      
      private function callBuy(param1:Object) : void
      {
         if(param1.confirm)
         {
            this.obf_5_y_948(this.callMenu as obf_b_f_2719);
         }
      }
      
      private function obf_r_9_3010(param1:MouseEvent) : void
      {
         if(!this.goldNpc)
         {
            return;
         }
         this.clearContent();
         this.initTreeShow(this.goldNpc);
         this.resetMenu();
      }
      
      private function obf_0_3_V_325(param1:MouseEvent) : void
      {
         if(!this.moneyNpc)
         {
            return;
         }
         this.clearContent();
         this.initTreeShow(this.moneyNpc);
         this.resetMenu();
      }
      
      private function obf_5_y_948(param1:obf_b_f_2719) : void
      {
         param1.obf_5_y_948();
      }
      
      public function clearContent() : void
      {
         var _loc1_:obf_b_f_2719 = null;
         this.menus = new Array();
         for each(_loc1_ in this.obf_y_7_947)
         {
            if(_loc1_ is DisplayObject)
            {
               (_loc1_ as DisplayObject).removeEventListener(MouseEvent.CLICK,this.onClickMenu);
               if(imagePoint.contains(_loc1_ as DisplayObject))
               {
                  imagePoint.removeChild(_loc1_ as DisplayObject);
               }
            }
            _loc1_.destroy();
         }
         if(this.callMenu is DisplayObject)
         {
            (this.callMenu as DisplayObject).removeEventListener(MouseEvent.CLICK,this.onClickMenu);
            if(buttonPoint.contains(this.callMenu as DisplayObject))
            {
               buttonPoint.removeChild(this.callMenu as DisplayObject);
            }
         }
         this.callMenu.destroy();
         while(imagePoint.numChildren > 0)
         {
            imagePoint.removeChildAt(0);
         }
         while(buttonPoint.numChildren > 0)
         {
            buttonPoint.removeChildAt(0);
         }
         this.obf_y_7_947 = [];
      }
      
      public function clearMenu() : void
      {
         var _loc1_:obf_0_6_b_250 = null;
         for each(_loc1_ in this.obf_y_7_947)
         {
            if(_loc1_ is DisplayObject)
            {
               _loc1_.isLocked = true;
            }
         }
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(mouseX,mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"fruitBoxUI","txtDeyTitle");
         DiversityManager.setTextField(txtAllGold,"fruitBoxUI","txtAllGold");
         DiversityManager.setTextField(txtDeyGold,"fruitBoxUI","txtGold");
         DiversityManager.setTextField(txtMoney,"fruitBoxUI","txtMoney");
         DiversityManager.setTextField(txtAllNum,"fruitBoxUI","txtAllNum");
         DiversityManager.setTextField(allNum,"NpcTalkUI","menuCounter",[0,0]);
         goldFruit.label = DiversityManager.getString("fruitBoxUI","goldFruit");
         moneyFruit.label = DiversityManager.getString("fruitBoxUI","moneyFruit");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.obf_r_9_3010(null);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.obf_0_5_3970 = null;
      }
      
      public function destroy() : void
      {
         this.clearContent();
         this.obf_I_g_2025();
      }
   }
}

