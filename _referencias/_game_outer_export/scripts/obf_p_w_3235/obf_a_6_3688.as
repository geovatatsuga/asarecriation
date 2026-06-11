package obf_p_w_3235
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.lockTower.LockTowerInfo;
   import com.sunweb.game.rpg.lockTower.obf_0_5_y_508;
   import com.sunweb.game.rpg.lockTower.obf_N_9_4230;
   import com.sunweb.game.rpg.netRole.obf_9_c_4534;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.rpg.world.MonsterInfoUtil;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.LockTowerUIMC;
   
   public class obf_a_6_3688 extends LockTowerUIMC implements IPlayerUI
   {
      
      private var _index:int = 1;
      
      private var _page:int = 1;
      
      private var obf_y_o_4214:Object;
      
      private var obf_D_G_2655:obf_9_c_4534;
      
      public var obf_t_R_1627:Object;
      
      private var obf_4_u_1362:int;
      
      private var petImageActiveTimeInv:TimeLimiter = new TimeLimiter(2000);
      
      public function obf_a_6_3688()
      {
         super();
         this.visible = false;
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         expBar.gotoAndStop(0);
         this.addListener();
      }
      
      public function setTowerMap(param1:Object) : void
      {
         var _loc3_:* = undefined;
         this.obf_t_R_1627 = param1;
         this.obf_1_L_1379();
         this.obf_D_j_4220();
         this.obf_N_M_2642();
         var _loc2_:int = 0;
         for(_loc3_ in this.obf_t_R_1627)
         {
            if(_loc3_ > _loc2_)
            {
               _loc2_ = _loc3_;
            }
         }
         if(_loc2_ > 0)
         {
            this.setOpenFloor(_loc2_);
         }
      }
      
      public function setTowerMapOne(param1:LockTowerInfo) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:LockTowerInfo = this.obf_t_R_1627[param1.floor];
         this.obf_t_R_1627[param1.floor] = param1;
         if(_loc2_)
         {
            if(_loc2_.level != param1.level)
            {
               this.obf_D_j_4220();
            }
            if(_loc2_.monsterCode != param1.monsterCode)
            {
               this.obf_D_j_4220();
            }
         }
         if(param1.floor == this._index)
         {
            this.obf_1_L_1379();
         }
      }
      
      public function hasMonster(param1:String) : Boolean
      {
         var _loc2_:* = undefined;
         if(!this.obf_t_R_1627)
         {
            return false;
         }
         for each(_loc2_ in this.obf_t_R_1627)
         {
            if(_loc2_.monsterCode)
            {
               if(param1 == _loc2_.monsterCode)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function setOpenFloor(param1:int) : void
      {
         this.obf_4_u_1362 = param1;
         if(this.obf_4_u_1362 >= obf_N_9_4230.obf_s_4_4089())
         {
            cmdTowerUp.enabled = false;
         }
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTitle,"lockTowerUI","txtTitle");
         txtTip.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("lockTowerUI","txtTip") + "</a>";
         DiversityManager.setTextField(txtTowerAttr,"lockTowerUI","txtTowerAttr");
         DiversityManager.setTextField(txtTowerLvName,"lockTowerUI","txtTowerLvName");
         cmdBuff.label = DiversityManager.getString("lockTowerUI","cmdBuff");
         cmdEat.label = DiversityManager.getString("lockTowerUI","cmdEat");
         cmdFree.label = DiversityManager.getString("lockTowerUI","cmdFree");
         cmdTowerUp.label = DiversityManager.getString("lockTowerUI","cmdTowerUp");
         cmdPrv.label = DiversityManager.getString("lockTowerUI","cmdPrv");
         cmdNext.label = DiversityManager.getString("lockTowerUI","cmdNext");
      }
      
      private function addListener() : void
      {
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         txtTip.addEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
         txtTip.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
         cmdBuff.addEventListener(MouseEvent.CLICK,this.onCmdBuff);
         cmdEat.addEventListener(MouseEvent.CLICK,this.onCmdEat);
         cmdUp.addEventListener(MouseEvent.CLICK,this.obf_s_l_1008);
         cmdFree.addEventListener(MouseEvent.CLICK,this.obf_l_Q_2764);
         cmdTowerUp.addEventListener(MouseEvent.CLICK,this.obf_q_E_3511);
         cmdPrv.addEventListener(MouseEvent.CLICK,this.obf_c_b_3295);
         cmdNext.addEventListener(MouseEvent.CLICK,this.obf_j_l_1190);
         cmdTower0.addEventListener(MouseEvent.CLICK,this.obf_E_C_2637);
         cmdTower1.addEventListener(MouseEvent.CLICK,this.obf_E_C_2637);
         cmdTower2.addEventListener(MouseEvent.CLICK,this.obf_E_C_2637);
         cmdTower3.addEventListener(MouseEvent.CLICK,this.obf_E_C_2637);
         cmdTower4.addEventListener(MouseEvent.CLICK,this.obf_E_C_2637);
         cmdTower5.addEventListener(MouseEvent.CLICK,this.obf_E_C_2637);
         pointModle.addEventListener(MouseEvent.MOUSE_OVER,this.obf_g_n_2131);
         pointModle.addEventListener(MouseEvent.MOUSE_OUT,this.obf_1_B_2656);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         txtTip.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
         txtTip.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
         cmdBuff.removeEventListener(MouseEvent.CLICK,this.onCmdBuff);
         cmdEat.removeEventListener(MouseEvent.CLICK,this.onCmdEat);
         cmdUp.removeEventListener(MouseEvent.CLICK,this.obf_s_l_1008);
         cmdFree.removeEventListener(MouseEvent.CLICK,this.obf_l_Q_2764);
         cmdTowerUp.removeEventListener(MouseEvent.CLICK,this.obf_q_E_3511);
         cmdPrv.removeEventListener(MouseEvent.CLICK,this.obf_c_b_3295);
         cmdNext.removeEventListener(MouseEvent.CLICK,this.obf_j_l_1190);
         cmdTower0.removeEventListener(MouseEvent.CLICK,this.obf_E_C_2637);
         cmdTower1.removeEventListener(MouseEvent.CLICK,this.obf_E_C_2637);
         cmdTower2.removeEventListener(MouseEvent.CLICK,this.obf_E_C_2637);
         cmdTower3.removeEventListener(MouseEvent.CLICK,this.obf_E_C_2637);
         cmdTower4.removeEventListener(MouseEvent.CLICK,this.obf_E_C_2637);
         cmdTower5.removeEventListener(MouseEvent.CLICK,this.obf_E_C_2637);
         pointModle.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_g_n_2131);
         pointModle.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_1_B_2656);
      }
      
      public function obf_Z_l_1286(param1:Event) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("UIMouseTip");
         _loc2_.addTipInfo(DiversityManager.getString("lockTowerUI","txtTip0"),250,0);
         GameTipManager.showTip(_loc2_);
      }
      
      public function obf_0_6_9_109(param1:Event) : void
      {
         GameTipManager.closeTip("UIMouseTip");
      }
      
      public function obf_g_n_2131(param1:Event) : void
      {
         if(!this.obf_t_R_1627)
         {
            return;
         }
         var _loc2_:LockTowerInfo = this.obf_t_R_1627[this._index];
         if(!_loc2_ || !_loc2_.monsterCode)
         {
            return;
         }
         var _loc3_:Object = MonsterInfoUtil.getMonsterInfo(_loc2_.monsterCode);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:int = 250;
         var _loc5_:GameTipUI = new GameTipUI("UIMonsterTip");
         _loc5_.addTipInfo(RoleAttributesModifierEnum.getAttributesName(200),_loc4_,_loc5_.maxRow);
         _loc5_.addTipInfo("<P align=\'right\'>" + RoleAttributesModifierEnum.getAttributesValueString(200,_loc3_.hp) + "</P>",_loc4_,_loc5_.maxRow);
         _loc5_.addTipInfo(RoleAttributesModifierEnum.getAttributesName(140),_loc4_,_loc5_.maxRow + 1);
         _loc5_.addTipInfo("<P align=\'right\'>" + RoleAttributesModifierEnum.getAttributesValueString(140,_loc3_.physicalAttack) + "</P>",_loc4_,_loc5_.maxRow);
         _loc5_.addTipInfo(RoleAttributesModifierEnum.getAttributesName(150),_loc4_,_loc5_.maxRow + 1);
         _loc5_.addTipInfo("<P align=\'right\'>" + RoleAttributesModifierEnum.getAttributesValueString(150,_loc3_.magicAttack) + "</P>",_loc4_,_loc5_.maxRow);
         _loc5_.addTipInfo(RoleAttributesModifierEnum.getAttributesName(160),_loc4_,_loc5_.maxRow + 1);
         _loc5_.addTipInfo("<P align=\'right\'>" + RoleAttributesModifierEnum.getAttributesValueString(160,_loc3_.physicalDefense) + "</P>",_loc4_,_loc5_.maxRow);
         _loc5_.addTipInfo(RoleAttributesModifierEnum.getAttributesName(170),_loc4_,_loc5_.maxRow + 1);
         _loc5_.addTipInfo("<P align=\'right\'>" + RoleAttributesModifierEnum.getAttributesValueString(170,_loc3_.magicDefense) + "</P>",_loc4_,_loc5_.maxRow);
         _loc5_.addTipInfo(RoleAttributesModifierEnum.getAttributesName(230),_loc4_,_loc5_.maxRow + 1);
         _loc5_.addTipInfo("<P align=\'right\'>" + RoleAttributesModifierEnum.getAttributesValueString(230,_loc3_.hitValue) + "</P>",_loc4_,_loc5_.maxRow);
         _loc5_.addTipInfo(RoleAttributesModifierEnum.getAttributesName(240),_loc4_,_loc5_.maxRow + 1);
         _loc5_.addTipInfo("<P align=\'right\'>" + RoleAttributesModifierEnum.getAttributesValueString(240,_loc3_.dodgeValue) + "</P>",_loc4_,_loc5_.maxRow);
         _loc5_.addTipInfo(RoleAttributesModifierEnum.getAttributesName(250),_loc4_,_loc5_.maxRow + 1);
         _loc5_.addTipInfo("<P align=\'right\'>" + RoleAttributesModifierEnum.getAttributesValueString(250,_loc3_.critValue) + "</P>",_loc4_,_loc5_.maxRow);
         GameTipManager.showTip(_loc5_);
      }
      
      public function obf_1_B_2656(param1:Event) : void
      {
         GameTipManager.closeTip("UIMonsterTip");
      }
      
      public function onCmdBuff(param1:MouseEvent) : void
      {
         var _loc2_:LockTowerInfo = this.obf_t_R_1627[this._index];
         if(!_loc2_ || !_loc2_.canBuff)
         {
            return;
         }
         obf_N_9_4230.obf_7_w_1560(this._index);
      }
      
      public function onCmdEat(param1:MouseEvent) : void
      {
         var _loc2_:LockTowerInfo = this.obf_t_R_1627[this._index];
         if(!_loc2_ || _loc2_.canBuff)
         {
            return;
         }
         param1.stopPropagation();
         obf_K_e_3075.lockTowerEatUI.setFloor(this._index);
         obf_K_e_3075.showUI(obf_K_e_3075.lockTowerEatUI);
      }
      
      public function obf_s_l_1008(param1:MouseEvent) : void
      {
         var _loc2_:LockTowerInfo = this.obf_t_R_1627[this._index];
         if(!_loc2_)
         {
            return;
         }
         param1.stopPropagation();
         if(!_loc2_.monsterCode)
         {
            obf_K_e_3075.lockTowerInitUI.setFloor(this._index);
            obf_K_e_3075.showUI(obf_K_e_3075.lockTowerInitUI);
         }
         else
         {
            obf_K_e_3075.lockTowerUpUI.setFloorInfo(this._index,_loc2_.monsterCode);
            obf_K_e_3075.showUI(obf_K_e_3075.lockTowerUpUI);
         }
      }
      
      public function obf_l_Q_2764(param1:MouseEvent) : void
      {
         var _loc2_:LockTowerInfo = this.obf_t_R_1627[this._index];
         if(!_loc2_ || !_loc2_.monsterCode)
         {
            return;
         }
         param1.stopPropagation();
         obf_K_e_3075.lockTowerFreeUI.setFloor(this._index);
         obf_K_e_3075.showUI(obf_K_e_3075.lockTowerFreeUI);
      }
      
      public function obf_q_E_3511(param1:MouseEvent) : void
      {
         if(this.obf_4_u_1362 >= obf_N_9_4230.obf_s_4_4089())
         {
            return;
         }
         if(obf_K_e_3075.playerBagUI.getItemCount(obf_N_9_4230.addFloorItem()) < obf_N_9_4230.addFloorNum())
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("lockTowerUI","noItems"));
            return;
         }
         obf_N_9_4230.obf_f_6_2285();
      }
      
      public function obf_c_b_3295(param1:MouseEvent) : void
      {
         if(this._page <= 1)
         {
            return;
         }
         this.obf_H_K_3140(this._page - 1);
      }
      
      public function obf_j_l_1190(param1:MouseEvent) : void
      {
         var _loc2_:int = (obf_N_9_4230.obf_s_4_4089() - 1) / 6 + 1;
         if(this._page >= _loc2_)
         {
            return;
         }
         this.obf_H_K_3140(this._page + 1);
      }
      
      public function obf_E_C_2637(param1:MouseEvent) : void
      {
         if(!this.obf_y_o_4214)
         {
            return;
         }
         var _loc2_:int = int(this.obf_y_o_4214[param1.target.name]);
         if(!_loc2_)
         {
            return;
         }
         this.changeIndex(_loc2_);
      }
      
      public function changeIndex(param1:int) : void
      {
         if(this._index == param1)
         {
            return;
         }
         this._index = param1;
         this.obf_1_L_1379();
      }
      
      public function obf_1_L_1379() : void
      {
         var _loc1_:LockTowerInfo = this.obf_t_R_1627[this._index];
         if(!_loc1_ || !_loc1_.isOpen)
         {
            imgClose.visible = true;
            this.obf_C_V_2747();
         }
         else
         {
            imgClose.visible = false;
            this.obf_K_V_887(_loc1_);
         }
      }
      
      public function obf_C_V_2747() : void
      {
         DiversityManager.setTextField(txtTower,"lockTowerUI","cmdTower",[this._index + ""]);
         if(pointModle.numChildren > 0)
         {
            pointModle.removeChildAt(0);
            if(this.obf_D_G_2655)
            {
               this.obf_D_G_2655.destroy();
               this.obf_D_G_2655 = null;
            }
         }
         pointModle.visible = false;
         cmdUp.label = DiversityManager.getString("lockTowerUI","cmdUp0");
         cmdUp.enabled = false;
         cmdBuff.enabled = false;
         cmdEat.enabled = false;
         cmdFree.enabled = false;
         txtMonster.htmlText = "";
         txtTowerLv.htmlText = "";
         txtTowerExp.htmlText = "";
         expBar.gotoAndStop(0);
      }
      
      public function obf_K_V_887(param1:LockTowerInfo) : void
      {
         var _loc7_:Object = null;
         DiversityManager.setTextField(txtTower,"lockTowerUI","cmdTower",[param1.floor + ""]);
         if(!param1.monsterCode)
         {
            if(pointModle.numChildren > 0)
            {
               pointModle.removeChildAt(0);
               if(this.obf_D_G_2655)
               {
                  this.obf_D_G_2655.destroy();
                  this.obf_D_G_2655 = null;
               }
            }
            pointModle.visible = false;
            cmdUp.label = DiversityManager.getString("lockTowerUI","cmdUp0");
            cmdBuff.enabled = false;
            cmdEat.enabled = false;
            cmdFree.enabled = false;
            txtMonster.htmlText = "";
         }
         else
         {
            if(pointModle.numChildren > 0)
            {
               pointModle.removeChildAt(0);
               if(this.obf_D_G_2655)
               {
                  this.obf_D_G_2655.destroy();
                  this.obf_D_G_2655 = null;
               }
            }
            pointModle.visible = true;
            cmdUp.label = DiversityManager.getString("lockTowerUI","cmdUp");
            cmdFree.enabled = true;
            if(param1.canBuff)
            {
               cmdBuff.enabled = true;
               cmdEat.enabled = false;
            }
            else
            {
               cmdBuff.enabled = false;
               cmdEat.enabled = true;
            }
            _loc7_ = MonsterInfoUtil.getMonsterInfo(param1.monsterCode);
            this.obf_D_G_2655 = new obf_9_c_4534(_loc7_.modelCode);
            if(this.obf_D_G_2655)
            {
               this.obf_D_G_2655.x = 0;
               pointModle.addChild(this.obf_D_G_2655);
            }
            DiversityManager.setTextField(txtMonster,"lockTowerUI","txtMonster",[_loc7_.level + "",_loc7_.name]);
         }
         var _loc2_:Object = param1.getLevelConfig();
         var _loc3_:String = JSONUtil.getStr(_loc2_,["sign"]);
         var _loc4_:String = JSONUtil.getStr(_loc2_,["color"]);
         var _loc5_:int = JSONUtil.getInt(_loc2_,["needExp"]);
         txtTowerLv.htmlText = "<font color=\'" + _loc4_ + "\'>" + _loc3_ + "</font>";
         txtTowerExp.htmlText = param1.exp + "/" + _loc5_;
         var _loc6_:int = param1.exp / _loc5_ * 100;
         expBar.gotoAndStop(_loc6_);
         if(param1.isMaxLevel())
         {
            cmdUp.enabled = false;
         }
         else
         {
            cmdUp.enabled = true;
         }
      }
      
      public function obf_D_j_4220() : void
      {
         var _loc3_:LockTowerInfo = null;
         var _loc4_:Object = null;
         if(!this.obf_t_R_1627)
         {
            return;
         }
         var _loc1_:obf_0_5_y_508 = new obf_0_5_y_508();
         var _loc2_:int = 0;
         while(_loc2_ < obf_N_9_4230.obf_s_4_4089())
         {
            _loc3_ = this.obf_t_R_1627[_loc2_];
            if(!(!_loc3_ || !_loc3_.isOpen || !_loc3_.monsterCode))
            {
               _loc4_ = _loc3_.getLevelConfig();
               if(!(!_loc4_ || !_loc4_.attr))
               {
                  _loc1_.addObject(_loc4_.attr);
               }
            }
            _loc2_++;
         }
         txtAttrName0.htmlText = RoleAttributesModifierEnum.getAttributesName(200);
         txtAttrVale0.htmlText = _loc1_.hp + "";
         txtAttrName1.htmlText = RoleAttributesModifierEnum.getAttributesName(140);
         txtAttrVale1.htmlText = _loc1_.atk + "";
         txtAttrName2.htmlText = RoleAttributesModifierEnum.getAttributesName(150);
         txtAttrVale2.htmlText = _loc1_.obf_7_l_4176 + "";
         txtAttrName3.htmlText = RoleAttributesModifierEnum.getAttributesName(160);
         txtAttrVale3.htmlText = _loc1_.obf_y_1_1936 + "";
         txtAttrName4.htmlText = RoleAttributesModifierEnum.getAttributesName(170);
         txtAttrVale4.htmlText = _loc1_.obf_0_1_P_161 + "";
      }
      
      public function obf_H_K_3140(param1:int) : void
      {
         if(this._page == param1)
         {
            return;
         }
         this._page = param1;
         this.obf_N_M_2642();
      }
      
      public function obf_N_M_2642() : void
      {
         var _loc4_:int = 0;
         var _loc1_:int = (obf_N_9_4230.obf_s_4_4089() - 1) / 6 + 1;
         if(this._page > _loc1_ || this._page < 1)
         {
            this._page = 1;
         }
         DiversityManager.setTextField(txtPage,"lockTowerUI","txtPage",[this._page + "/" + _loc1_]);
         this.obf_y_o_4214 = new Object();
         var _loc2_:int = (this._page - 1) * 6 + 1;
         var _loc3_:int = 0;
         while(_loc3_ < 6)
         {
            _loc4_ = _loc2_ + _loc3_;
            if(_loc4_ > obf_N_9_4230.obf_s_4_4089())
            {
               this["cmdTower" + _loc3_].visible = false;
            }
            else
            {
               this["cmdTower" + _loc3_].visible = true;
               this["cmdTower" + _loc3_].label = DiversityManager.getString("lockTowerUI","cmdTower",[_loc4_ + ""]);
               this.obf_y_o_4214[this["cmdTower" + _loc3_].name] = _loc4_;
            }
            _loc3_++;
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(Boolean(this.obf_D_G_2655) && this.petImageActiveTimeInv.checkTimeout())
         {
            this.obf_D_G_2655.onUpdate();
            this.obf_D_G_2655.doAction(obf_S_c_3330.obf_h_4_3537,Math.random() * 8,true);
         }
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         obf_K_e_3075.closeUI(this);
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
      
      public function showUI() : void
      {
         if(!this.obf_t_R_1627)
         {
            return;
         }
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
         this.removeListener();
      }
   }
}

