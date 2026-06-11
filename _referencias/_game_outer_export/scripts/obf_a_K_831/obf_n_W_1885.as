package obf_a_K_831
{
   import obf_i_X_3487.obf_v_0_1258;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.netRole.obf_9_c_4534;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.util.TimeLimiter;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import playerUI.TreeBoxUIMC;
   
   public class obf_n_W_1885 extends TreeBoxUIMC implements IPlayerUI, IIconItemUI
   {
      
      public var obf_N_8_3570:int;
      
      public var obf_z_q_3358:int;
      
      public var obf_M_T_1268:int;
      
      private var type:int;
      
      private var cost:int;
      
      private var obf_D_G_2655:obf_9_c_4534;
      
      private var bag:IconItemBag;
      
      private var timeInv:TimeLimiter = new TimeLimiter(2000);
      
      public function obf_n_W_1885()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         pointTree.mouseEnabled = false;
         expBar.gotoAndStop(1);
         this.bag = new IconItemBag(icon,this,0);
         this.bag.lockDrag = true;
         this.bag.addValidType(GameItemType.ALL);
         var _loc1_:IconItem = IconItemManager.getIconItemByCode(obf_v_0_1258.treeItemCode,"");
         if(!_loc1_)
         {
            return;
         }
         this.bag.pushIconItem(_loc1_);
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.underline = true;
         txtTreeInfo.setTextFormat(_loc2_);
         this.obf_x_v_2806();
      }
      
      public function initDiversity() : void
      {
         txtTreeInfo.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("treeBoxUI","txtTreeInfo") + "</a>";
         DiversityManager.setTextField(txtTitle,"treeBoxUI","txtTitle");
         DiversityManager.setTextField(txtLevel,"treeBoxUI","txtLevel");
         DiversityManager.setTextField(txtRank,"treeBoxUI","txtRank");
         cmdGetItem.label = DiversityManager.getString("treeBoxUI","cmdGetItem");
         cmdAddExp.label = DiversityManager.getString("treeBoxUI","cmdAddExp");
         cmdUpRank.label = DiversityManager.getString("treeBoxUI","cmdUpRank");
      }
      
      public function obf_x_v_2806() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         obf_K_e_3075.addUIMouseToolTip(txtTreeInfo,"txtTreeInfo");
         cmdGetItem.addEventListener(MouseEvent.CLICK,this.onCmdGetItem);
         cmdAddExp.addEventListener(MouseEvent.CLICK,this.obf_j_2103);
         cmdAddExp.addEventListener(MouseEvent.MOUSE_OVER,this.onCmdAddExpOver);
         cmdAddExp.addEventListener(MouseEvent.MOUSE_OUT,this.obf_S_G_1665);
         cmdUpRank.addEventListener(MouseEvent.CLICK,this.obf_5_2_2641);
         cmdUpRank.addEventListener(MouseEvent.MOUSE_OVER,this.onCmdUpRankOver);
         cmdUpRank.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_4_58);
      }
      
      public function removeListen() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         obf_K_e_3075.removeUIMouseToolTip(txtTreeInfo);
         cmdGetItem.removeEventListener(MouseEvent.CLICK,this.onCmdGetItem);
         cmdAddExp.removeEventListener(MouseEvent.CLICK,this.obf_j_2103);
         cmdAddExp.removeEventListener(MouseEvent.MOUSE_OVER,this.onCmdAddExpOver);
         cmdAddExp.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_S_G_1665);
         cmdUpRank.removeEventListener(MouseEvent.CLICK,this.obf_5_2_2641);
         cmdUpRank.removeEventListener(MouseEvent.MOUSE_OVER,this.onCmdUpRankOver);
         cmdUpRank.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_4_58);
      }
      
      private function onCmdAddExpOver(param1:Event) : void
      {
         var _loc2_:int = int(GameItemManager.getItemConfig(obf_v_0_1258.expItem).rank);
         var _loc3_:String = GameItemRank.getRankColor(_loc2_).toString(16);
         var _loc4_:String = "<FONT COLOR=\'#" + _loc3_ + "\'>" + GameItemManager.getItemName(obf_v_0_1258.expItem) + "</FONT>" + " x1";
         var _loc5_:int = 200;
         GameTipManager.closeTip("onCmdAddExpOver");
         var _loc6_:GameTipUI = new GameTipUI("onCmdAddExpOver");
         _loc6_.obf_l_r_2153(_loc4_,_loc5_,0);
         GameTipManager.showTip(_loc6_);
      }
      
      private function obf_S_G_1665(param1:Event) : void
      {
         GameTipManager.closeTip("onCmdAddExpOver");
      }
      
      private function onCmdUpRankOver(param1:Event) : void
      {
         var _loc2_:Object = obf_v_0_1258.getRankConfig(this.obf_N_8_3570);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = int(GameItemManager.getItemConfig(obf_v_0_1258.upRankItem).rank);
         var _loc4_:String = GameItemRank.getRankColor(_loc3_).toString(16);
         var _loc5_:String = "<FONT COLOR=\'#" + _loc4_ + "\'>" + GameItemManager.getItemName(obf_v_0_1258.upRankItem) + "</FONT>" + " x" + _loc2_.needNum;
         var _loc6_:int = 200;
         GameTipManager.closeTip("onCmdUpRankOver");
         var _loc7_:GameTipUI = new GameTipUI("onCmdUpRankOver");
         _loc7_.obf_l_r_2153(_loc5_,_loc6_,0);
         GameTipManager.showTip(_loc7_);
      }
      
      private function obf_0_6_4_58(param1:Event) : void
      {
         GameTipManager.closeTip("onCmdUpRankOver");
      }
      
      public function setInfo(param1:int, param2:int, param3:int) : void
      {
         this.obf_N_8_3570 = param1;
         this.obf_z_q_3358 = param2;
         this.obf_M_T_1268 = param3;
         this.obf_Y_d_3233();
      }
      
      public function setTreeExp(param1:int) : void
      {
         this.obf_M_T_1268 = param1;
         this.obf_e_S_2496();
      }
      
      public function setTreeLevel(param1:int) : void
      {
         if(this.obf_z_q_3358 == param1)
         {
            return;
         }
         this.obf_z_q_3358 = param1;
         this.obf_s_X_3567();
      }
      
      public function setTreeRank(param1:int) : void
      {
         this.obf_N_8_3570 = param1;
      }
      
      public function obf_Y_d_3233() : void
      {
         var _loc9_:Object = null;
         var _loc10_:Object = null;
         var _loc1_:Object = obf_v_0_1258.getRankConfig(this.obf_N_8_3570);
         if(!_loc1_)
         {
            return;
         }
         DiversityManager.setTextField(txtTreeName,"treeBoxUI","txtTreeName",[_loc1_.name,this.obf_z_q_3358 + ""]);
         if(pointTree.numChildren > 0)
         {
            pointTree.removeChildAt(0);
         }
         this.obf_D_G_2655 = new obf_9_c_4534(_loc1_.model);
         if(this.obf_D_G_2655)
         {
            this.obf_D_G_2655.x = 0;
            pointTree.addChild(this.obf_D_G_2655);
         }
         var _loc2_:Object = obf_v_0_1258.getLevelConfig(this.obf_N_8_3570,this.obf_z_q_3358);
         if(!_loc2_)
         {
            return;
         }
         txtExp.htmlText = this.obf_M_T_1268 + "/" + _loc2_.needExp;
         var _loc3_:int = this.obf_M_T_1268 * 100 / _loc2_.needExp;
         expBar.gotoAndStop(_loc3_);
         this.obf_5_v_3867();
         var _loc4_:Object = obf_v_0_1258.getTreeCost();
         if(_loc4_)
         {
            if(_loc4_.cost == 0)
            {
               DiversityManager.setTextField(txtCost,"treeBoxUI","txtCost0");
               this.cost = 0;
            }
            else if(_loc4_.type == 0)
            {
               DiversityManager.setTextField(txtCost,"treeBoxUI","txtCost1",[_loc4_.cost]);
               this.type = 0;
               this.cost = _loc4_.cost;
            }
            else if(_loc4_.type == 1)
            {
               DiversityManager.setTextField(txtCost,"treeBoxUI","txtCost2",[_loc4_.cost]);
               this.type = 1;
               this.cost = _loc4_.cost;
            }
            cmdGetItem.enabled = true;
         }
         else
         {
            txtCost.htmlText = "";
            cmdGetItem.enabled = false;
         }
         var _loc5_:Array = this.obf_F_1_3614(_loc2_.attr);
         var _loc6_:int = 0;
         while(_loc6_ < 9)
         {
            this["txtLvAttr" + _loc6_].text = "";
            this["txtLvValue" + _loc6_].text = "";
            if(_loc6_ < _loc5_.length)
            {
               _loc9_ = _loc5_[_loc6_];
               this["txtLvAttr" + _loc6_].text = RoleAttributesModifierEnum.getAttributesName(_loc9_["attr"]) + ":";
               this["txtLvValue" + _loc6_].text = "+" + _loc9_["value"];
            }
            _loc6_++;
         }
         var _loc7_:Array = this.obf_F_1_3614(_loc1_.rankAttr);
         var _loc8_:int = 0;
         while(_loc8_ < 9)
         {
            this["txtRaAttr" + _loc8_].text = "";
            this["txtRaValue" + _loc8_].text = "";
            if(_loc8_ < _loc7_.length)
            {
               _loc10_ = _loc7_[_loc8_];
               this["txtRaAttr" + _loc8_].text = RoleAttributesModifierEnum.getAttributesName(_loc10_["attr"]) + ":";
               this["txtRaValue" + _loc8_].text = "+" + _loc10_["value"];
            }
            _loc8_++;
         }
      }
      
      public function changeGetItem() : void
      {
         var _loc1_:Object = obf_v_0_1258.getTreeCost();
         if(_loc1_)
         {
            if(_loc1_.cost == 0)
            {
               DiversityManager.setTextField(txtCost,"treeBoxUI","txtCost0");
               this.cost = 0;
            }
            else if(_loc1_.type == 0)
            {
               DiversityManager.setTextField(txtCost,"treeBoxUI","txtCost1",[_loc1_.cost]);
               this.type = 0;
               this.cost = _loc1_.cost;
            }
            else if(_loc1_.type == 1)
            {
               DiversityManager.setTextField(txtCost,"treeBoxUI","txtCost2",[_loc1_.cost]);
               this.type = 1;
               this.cost = _loc1_.cost;
            }
            cmdGetItem.enabled = true;
         }
         else
         {
            txtCost.htmlText = "";
            cmdGetItem.enabled = false;
         }
      }
      
      public function obf_e_S_2496() : void
      {
         var _loc1_:Object = obf_v_0_1258.getLevelConfig(this.obf_N_8_3570,this.obf_z_q_3358);
         if(!_loc1_)
         {
            return;
         }
         txtExp.htmlText = this.obf_M_T_1268 + "/" + _loc1_.needExp;
         var _loc2_:int = this.obf_M_T_1268 * 100 / _loc1_.needExp;
         expBar.gotoAndStop(_loc2_);
         this.obf_5_v_3867();
      }
      
      public function obf_s_X_3567() : void
      {
         var _loc5_:Object = null;
         var _loc1_:Object = obf_v_0_1258.getRankConfig(this.obf_N_8_3570);
         if(!_loc1_)
         {
            return;
         }
         DiversityManager.setTextField(txtTreeName,"treeBoxUI","txtTreeName",[_loc1_.name,this.obf_z_q_3358 + ""]);
         var _loc2_:Object = obf_v_0_1258.getLevelConfig(this.obf_N_8_3570,this.obf_z_q_3358);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Array = this.obf_F_1_3614(_loc2_.attr);
         var _loc4_:int = 0;
         while(_loc4_ < 9)
         {
            this["txtLvAttr" + _loc4_].text = "";
            this["txtLvValue" + _loc4_].text = "";
            if(_loc4_ < _loc3_.length)
            {
               _loc5_ = _loc3_[_loc4_];
               this["txtLvAttr" + _loc4_].text = RoleAttributesModifierEnum.getAttributesName(_loc5_["attr"]) + ":";
               this["txtLvValue" + _loc4_].text = "+" + _loc5_["value"];
            }
            _loc4_++;
         }
      }
      
      private function obf_F_1_3614(param1:Object) : Array
      {
         var _loc3_:String = null;
         var _loc2_:Array = new Array();
         for(_loc3_ in param1)
         {
            _loc2_.push({
               "attr":int(_loc3_),
               "value":param1[_loc3_]
            });
         }
         _loc2_.sortOn("attr",Array.NUMERIC);
         return _loc2_;
      }
      
      private function obf_5_v_3867() : void
      {
         var _loc1_:Object = obf_v_0_1258.getLevelConfig(this.obf_N_8_3570,this.obf_z_q_3358);
         if(!_loc1_)
         {
            return;
         }
         if(this.obf_M_T_1268 >= _loc1_.needExp)
         {
            cmdAddExp.enabled = false;
            cmdUpRank.enabled = true;
         }
         else
         {
            cmdAddExp.enabled = true;
            cmdUpRank.enabled = false;
         }
         if(this.obf_N_8_3570 >= obf_v_0_1258.rankMax)
         {
            cmdUpRank.enabled = false;
         }
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onCmdGetItem(param1:Event) : void
      {
         if(!obf_K_e_3075.playerBagUI || !obf_K_e_3075.playerBagUI.haveEmptyBag(1))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","playerBagFull"));
            return;
         }
         if(this.cost == 0)
         {
            obf_v_0_1258.sendTreeGetItemRequest();
         }
         else
         {
            if(this.type == 0)
            {
               if(GameContext.localPlayer.fullInfo.gold < this.cost)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreGold"));
                  return;
               }
            }
            else if(this.type == 1)
            {
               if(GameContext.localPlayer.fullInfo.money < this.cost)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","noMoreMoney"));
                  return;
               }
            }
            obf_v_0_1258.sendTreeGetItemRequest();
         }
      }
      
      private function obf_j_2103(param1:Event) : void
      {
         if(!obf_K_e_3075.playerBagUI || !obf_K_e_3075.playerBagUI.getIconItemBagByCode(obf_v_0_1258.expItem))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("treeBoxUI","noItem"));
            return;
         }
         obf_v_0_1258.sendTreeAddExpRequest();
      }
      
      private function obf_5_2_2641(param1:Event) : void
      {
         var _loc2_:Object = obf_v_0_1258.getRankConfig(this.obf_N_8_3570);
         if(!_loc2_)
         {
            return;
         }
         if(!obf_K_e_3075.playerBagUI || obf_K_e_3075.playerBagUI.getItemCount(obf_v_0_1258.upRankItem) < _loc2_.needNum)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("treeBoxUI","noItem"));
            return;
         }
         obf_v_0_1258.sendTreeUpRankRequest();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(Boolean(this.obf_D_G_2655) && this.timeInv.checkTimeout())
         {
            this.obf_D_G_2655.onUpdate();
         }
      }
      
      public function showUI() : void
      {
         this.changeGetItem();
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         this.removeListen();
      }
      
      public function getIconItemBags() : Array
      {
         return [this.bag];
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
   }
}

