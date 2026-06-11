package obf_U_i_2841
{
   import obf_0_7_o_492.obf_b_q_889;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.magicCircleUIMC;
   
   public class obf_0_6_r_163 extends magicCircleUIMC implements IPlayerUI
   {
      
      public var hasMap:Object;
      
      public var select:int = 0;
      
      public var useIndex:int = -1;
      
      private var attrList:Array;
      
      public function obf_0_6_r_163()
      {
         var _loc3_:int = 0;
         this.attrList = ["100","110","120","130","140","150","160","170","280","290","291","260"];
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            this["box" + _loc1_].gotoAndStop(1);
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.attrList.length)
         {
            _loc3_ = parseInt(this.attrList[_loc2_]);
            this["txtAttr" + _loc2_].htmlText = RoleAttributesModifierEnum.getAttributesName(_loc3_);
            _loc2_++;
         }
         useMC.visible = false;
         this.addListener();
         this.refresh();
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtTitle,"magicCircleUI","txtTitle");
         DiversityManager.setTextField(txtInfo,"MouseToolTip","magicCircleInfo");
         cmdUp.label = DiversityManager.getString("magicCircleUI","cmdUp0");
         cmdUse.label = DiversityManager.getString("magicCircleUI","cmdUse");
      }
      
      private function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            this["box" + _loc1_].addEventListener(MouseEvent.CLICK,this.onSelect);
            _loc1_++;
         }
         cmdUp.addEventListener(MouseEvent.CLICK,this.obf_s_l_1008);
         cmdUse.addEventListener(MouseEvent.CLICK,this.onCmdUse);
         cmdUp.addEventListener(MouseEvent.MOUSE_OVER,this.obf_e_r_1572);
         cmdUp.addEventListener(MouseEvent.MOUSE_OUT,this.obf_c_h_3872);
      }
      
      private function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            this["box" + _loc1_].removeEventListener(MouseEvent.CLICK,this.onSelect);
            _loc1_++;
         }
         cmdUp.removeEventListener(MouseEvent.CLICK,this.obf_s_l_1008);
         cmdUse.removeEventListener(MouseEvent.CLICK,this.onCmdUse);
         cmdUp.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_e_r_1572);
         cmdUp.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_c_h_3872);
      }
      
      private function obf_e_r_1572(param1:MouseEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc2_:GameTipUI = new GameTipUI("magicCircleUpButtonTip");
         var _loc3_:int = 200;
         var _loc4_:Object = obf_b_q_889.magicCircleList[this.select];
         if(!_loc4_)
         {
            return;
         }
         if(Boolean(this.hasMap) && Boolean(this.hasMap[this.select]))
         {
            _loc5_ = int(this.hasMap[this.select]);
            if(_loc5_ >= _loc4_.maxLevel)
            {
               return;
            }
            if(_loc4_.upItems)
            {
               for(_loc6_ in _loc4_.upItems)
               {
                  _loc7_ = int(_loc4_.upItems[_loc6_]);
                  _loc2_.addTipInfo("<FONT color=\'#FF0000\'>" + GameItemManager.getItemName(_loc6_) + " x " + _loc7_ + "</FONT>",_loc3_,_loc2_.maxRow + 1);
               }
            }
         }
         else if(_loc4_.openCode)
         {
            _loc2_.addTipInfo("<FONT color=\'#FF0000\'>" + GameItemManager.getItemName(_loc4_.openCode) + " x 1 </FONT>",_loc3_,_loc2_.maxRow + 1);
         }
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_c_h_3872(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("magicCircleUpButtonTip");
      }
      
      private function obf_s_l_1008(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc2_:Object = obf_b_q_889.magicCircleList[this.select];
         if(!_loc2_)
         {
            return;
         }
         if(Boolean(this.hasMap) && Boolean(this.hasMap[this.select]))
         {
            _loc3_ = int(this.hasMap[this.select]);
            if(_loc3_ >= _loc2_.maxLevel)
            {
               return;
            }
            if(_loc2_.upItems)
            {
               for(_loc4_ in _loc2_.upItems)
               {
                  _loc5_ = int(_loc2_.upItems[_loc4_]);
                  if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc4_) < _loc5_)
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("magicCircleUI","noItem"));
                     return;
                  }
               }
            }
         }
         else if(_loc2_.openCode)
         {
            if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc2_.openCode) <= 0)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("magicCircleUI","noItem"));
               return;
            }
         }
         obf_b_q_889.sendMagicCircleUpRequest(this.select);
      }
      
      private function onCmdUse(param1:Event) : void
      {
         var _loc2_:Object = obf_b_q_889.magicCircleList[this.select];
         if(!_loc2_)
         {
            return;
         }
         if(!this.hasMap)
         {
            return;
         }
         var _loc3_:int = int(this.hasMap[this.select]);
         if(!_loc3_)
         {
            return;
         }
         obf_b_q_889.sendMagicCircleUseRequest(this.select);
      }
      
      private function onSelect(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:String = _loc2_.slice(3);
         this.select = parseInt(_loc3_);
         this.refresh();
      }
      
      public function refresh() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         useMC.visible = false;
         cmdUp.enabled = false;
         cmdUse.enabled = false;
         var _loc1_:int = 0;
         while(_loc1_ < 24)
         {
            this["box" + _loc1_].gotoAndStop(1);
            if(this.select == _loc1_)
            {
               selectMC.x = this["box" + _loc1_].x;
               selectMC.y = this["box" + _loc1_].y;
            }
            if(Boolean(this.hasMap) && Boolean(this.hasMap[_loc1_]))
            {
               this["box" + _loc1_].gotoAndStop(2);
               if(this.useIndex == _loc1_)
               {
                  useMC.x = this["box" + _loc1_].x;
                  useMC.y = this["box" + _loc1_].y;
                  useMC.visible = true;
               }
               if(this.select == _loc1_)
               {
                  cmdUse.label = DiversityManager.getString("magicCircleUI","cmdUse");
                  cmdUse.enabled = true;
                  if(this.useIndex == _loc1_)
                  {
                     cmdUse.label = DiversityManager.getString("magicCircleUI","cmdUse0");
                  }
               }
            }
            _loc1_++;
         }
         if(!obf_b_q_889.magicCircleList || obf_b_q_889.magicCircleList.length == 0)
         {
            return;
         }
         var _loc2_:Object = obf_b_q_889.magicCircleList[this.select];
         if(_loc2_)
         {
            txtAttrTitle.htmlText = _loc2_.name;
            if(Boolean(this.hasMap) && Boolean(this.hasMap[this.select]))
            {
               _loc4_ = int(this.hasMap[this.select]);
               txtAttrTitle.htmlText += "  lv." + _loc4_;
            }
            _loc3_ = 1;
            if(Boolean(this.hasMap) && Boolean(this.hasMap[this.select]))
            {
               _loc3_ = int(this.hasMap[this.select]);
               cmdUp.label = DiversityManager.getString("magicCircleUI","cmdUp");
            }
            else
            {
               cmdUp.label = DiversityManager.getString("magicCircleUI","cmdUp0");
            }
            if(_loc3_ < _loc2_.maxLevel)
            {
               cmdUp.enabled = true;
            }
            if(_loc2_.attr)
            {
               _loc5_ = 0;
               while(_loc5_ < this.attrList.length)
               {
                  _loc6_ = this.attrList[_loc5_];
                  _loc7_ = int(_loc2_.attr[_loc6_]);
                  if(_loc7_)
                  {
                     this["txtAttrValue" + _loc5_].htmlText = Math.round(_loc7_ * _loc3_);
                  }
                  else
                  {
                     this["txtAttrValue" + _loc5_].htmlText = "";
                  }
                  _loc5_++;
               }
            }
         }
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:Event) : void
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

