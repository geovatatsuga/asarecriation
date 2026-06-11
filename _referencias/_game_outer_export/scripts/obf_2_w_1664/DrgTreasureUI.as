package obf_2_w_1664
{
   import obf_b_P_3069.obf_n_x_1562;
   import obf_g_A_3629.ChatDecoder;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemBriefInfo;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.obf_C_o_3363;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import playerUI.DrgTreasureUIMC;
   
   public class DrgTreasureUI extends DrgTreasureUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var drgCmdList:Array;
      
      private var obf_e_t_3768:int;
      
      private var obf_0_C_3516:String;
      
      private var obf_4_k_1780:MovieClip;
      
      private var obf_P_z_3192:Array;
      
      public function DrgTreasureUI()
      {
         var _loc3_:MovieClip = null;
         var _loc4_:IconItemBag = null;
         var _loc5_:TableButton = null;
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         tempBagButtonPrompt.mouseEnabled = false;
         tempBagButtonPrompt.visible = false;
         this.obf_P_z_3192 = new Array();
         this.bags = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 18)
         {
            _loc3_ = this["bag" + _loc1_] as MovieClip;
            if(_loc3_)
            {
               _loc4_ = new IconItemBag(_loc3_,this,_loc1_);
               _loc4_.addValidType(GameItemType.ALL);
               _loc4_.lockDrag = true;
               this.bags.push(_loc4_);
            }
            _loc1_++;
         }
         this.drgCmdList = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            _loc5_ = this["cmdTableDrg" + _loc2_];
            DiversityManager.setTextField(_loc5_.txtLabel,"DrgTreasure","tableDrg" + _loc2_,null,true);
            _loc5_.drgIndex = _loc2_;
            this.drgCmdList.push(_loc5_);
            obf_9_V_1635.setSimpleButtonTooltip(promptMC["cmdDrg" + _loc2_],DiversityManager.getString("DrgTreasure","tableDrg" + _loc2_));
            _loc2_++;
         }
         this.setDrgType(0);
         this.obf_R_s_4398();
         this.addListener();
         this.setChildIndex(promptMC,this.numChildren - 1);
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"DrgTreasure","txtTitle");
         DiversityManager.setTextField(txtDeyMyMoney,"DrgTreasure","txtMoney");
         DiversityManager.setTextField(txtDeyDrgAward,"DrgTreasure","txtDrgAward");
         DiversityManager.setTextField(txtDeyOtherDrgAward,"DrgTreasure","txtOtherDrgAward");
         promptMC.txtDeyPrompt.htmlText = DiversityManager.getString("DrgTreasure","txtDrgPrompt");
         cmdResult.label = DiversityManager.getString("DrgTreasure","cmdResult");
         cmdTempBag.label = DiversityManager.getString("MainBag","cmdTempBag");
      }
      
      private function addListener() : void
      {
         var _loc1_:TableButton = null;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         txtDrgAward.addEventListener(TextEvent.LINK,this.onClickLink);
         txtOtherDrgAward.addEventListener(TextEvent.LINK,this.onClickLink);
         txtDrgPrompt.addEventListener(TextEvent.LINK,this.onClickLink);
         cmdTempBag.addEventListener(MouseEvent.CLICK,this.obf_J_u_3467);
         cmdResult.addEventListener(MouseEvent.CLICK,this.onClickResult);
         cmdDrgHit0.addEventListener(MouseEvent.CLICK,this.obf_8_4631);
         cmdDrgHit1.addEventListener(MouseEvent.CLICK,this.obf_8_4631);
         cmdDrgHit2.addEventListener(MouseEvent.CLICK,this.obf_8_4631);
         for each(_loc1_ in this.drgCmdList)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_i_Y_980);
         }
         promptMC.cmdDrg0.addEventListener(MouseEvent.CLICK,this.obf_0_6_R_128);
         promptMC.cmdDrg1.addEventListener(MouseEvent.CLICK,this.obf_0_6_R_128);
         promptMC.cmdDrg2.addEventListener(MouseEvent.CLICK,this.obf_0_6_R_128);
      }
      
      private function removeListener() : void
      {
         var _loc1_:TableButton = null;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         txtDrgAward.removeEventListener(TextEvent.LINK,this.onClickLink);
         txtOtherDrgAward.removeEventListener(TextEvent.LINK,this.onClickLink);
         txtDrgPrompt.removeEventListener(TextEvent.LINK,this.onClickLink);
         cmdTempBag.removeEventListener(MouseEvent.CLICK,this.obf_J_u_3467);
         cmdResult.removeEventListener(MouseEvent.CLICK,this.onClickResult);
         cmdDrgHit0.removeEventListener(MouseEvent.CLICK,this.obf_8_4631);
         cmdDrgHit1.removeEventListener(MouseEvent.CLICK,this.obf_8_4631);
         cmdDrgHit2.removeEventListener(MouseEvent.CLICK,this.obf_8_4631);
         for each(_loc1_ in this.drgCmdList)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_i_Y_980);
         }
         promptMC.cmdDrg0.removeEventListener(MouseEvent.CLICK,this.obf_0_6_R_128);
         promptMC.cmdDrg1.removeEventListener(MouseEvent.CLICK,this.obf_0_6_R_128);
         promptMC.cmdDrg2.removeEventListener(MouseEvent.CLICK,this.obf_0_6_R_128);
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
      
      private function obf_i_Y_980(param1:Event) : void
      {
         this.setDrgType(param1.currentTarget.drgIndex);
      }
      
      private function obf_0_6_R_128(param1:Event) : void
      {
         if(param1.currentTarget == promptMC.cmdDrg0)
         {
            this.setDrgType(0);
         }
         else if(param1.currentTarget == promptMC.cmdDrg1)
         {
            this.setDrgType(1);
         }
         else if(param1.currentTarget == promptMC.cmdDrg2)
         {
            this.setDrgType(2);
         }
         promptMC.visible = false;
      }
      
      private function onClickResult(param1:Event) : void
      {
         obf_C_o_3363.openResultUrl();
      }
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function obf_J_u_3467(param1:Event) : void
      {
         obf_K_e_3075.showUI(obf_K_e_3075.tempBagUI);
      }
      
      private function obf_8_4631(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(param1.currentTarget == cmdDrgHit1)
         {
            _loc2_ = 1;
         }
         else if(param1.currentTarget == cmdDrgHit2)
         {
            _loc2_ = 2;
         }
         var _loc3_:Object = obf_n_x_1562.getDrgTreasurtConfig(this.obf_e_t_3768);
         if(!_loc3_)
         {
            return;
         }
         if(GameContext.localPlayer.fullInfo.money < JSONUtil.getInt(_loc3_,["moneys",_loc2_]))
         {
            obf_K_e_3075.showShortOfMoney();
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("DrgTreasure","confirm_DrgLottery",[obf_a_f_2935.getMoneyString(JSONUtil.getInt(_loc3_,["moneys",_loc2_])),JSONUtil.getStr(_loc3_,["levelNum",_loc2_])]),this.confirmLottery,{
            "drgId":this.obf_0_C_3516,
            "drgLvIndex":_loc2_
         });
      }
      
      private function confirmLottery(param1:Object) : void
      {
         var _loc2_:Object = null;
         if(param1.confirm)
         {
            obf_n_x_1562.sendLotteryDrg(param1.par.drgId,param1.par.drgLvIndex);
            _loc2_ = obf_n_x_1562.getDrgTreasurtConfig(this.obf_e_t_3768);
            txtDrgAward.htmlText += DiversityManager.getString("DrgTreasure","prompt_DrgHit",[JSONUtil.getStr(this.drgCmdList,[this.obf_e_t_3768,"txtLabel","text"]),JSONUtil.getInt(_loc2_,["levelNum",param1.par.drgLvIndex])]) + "\n";
            if(this.obf_4_k_1780)
            {
               this.obf_4_k_1780.gotoAndPlay("hit" + param1.par.drgLvIndex);
            }
         }
      }
      
      public function setDrgType(param1:uint) : void
      {
         var _loc9_:DisplayObjectContainer = null;
         var _loc10_:DisplayObject = null;
         var _loc11_:IconItemBag = null;
         var _loc2_:Object = obf_n_x_1562.getDrgTreasurtConfig(param1);
         if(!_loc2_)
         {
            return;
         }
         this.obf_e_t_3768 = param1;
         this.obf_0_C_3516 = JSONUtil.getStr(_loc2_,["ruleId"]);
         txtDrgPrompt.htmlText = ChatDecoder.decode(JSONUtil.getStr(_loc2_,["remark"]));
         this.setDrgTableButton(param1);
         this.setDrgBG(param1);
         var _loc3_:Array = JSONUtil.getObject(_loc2_,["moneys"],[]) as Array;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc9_ = this["pointDrgMoney" + _loc4_] as DisplayObjectContainer;
            if(_loc9_)
            {
               while(_loc9_.numChildren > 0)
               {
                  _loc9_.removeChildAt(0);
               }
               _loc10_ = obf_a_f_2935.getMoneyDisplay(_loc3_[_loc4_]);
               _loc10_.x = -(_loc10_.width / 2);
               _loc9_.addChild(_loc10_);
            }
            _loc4_++;
         }
         var _loc5_:Array = JSONUtil.getObject(_loc2_,["showItems"],[]) as Array;
         var _loc6_:int = 0;
         while(_loc6_ < this.bags.length)
         {
            _loc11_ = this.bags[_loc6_];
            if(_loc11_)
            {
               _loc11_.dropIconItem();
               if(_loc6_ < _loc5_.length)
               {
                  _loc11_.pushIconItem(IconItemManager.getIconItemByCode(_loc5_[_loc6_],""));
               }
            }
            _loc6_++;
         }
         var _loc7_:Array = JSONUtil.getObject(_loc2_,["levelNum"],[]) as Array;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_.length)
         {
            obf_9_V_1635.setSimpleButtonTooltip(this["cmdDrgHit" + _loc8_],DiversityManager.getString("DrgTreasure","cmdDrgHit",[_loc7_[_loc8_]]));
            _loc8_++;
         }
      }
      
      public function setDrgTableButton(param1:int) : void
      {
         var _loc3_:TableButton = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.drgCmdList.length)
         {
            _loc3_ = this.drgCmdList[_loc2_];
            _loc3_.gotoAndStop(param1 == _loc2_ ? 2 : 1);
            _loc2_++;
         }
      }
      
      public function setDrgBG(param1:int) : void
      {
         var _loc4_:MovieClip = null;
         var _loc2_:Array = [obf_Y_9_2504,obf_5_s_1586,goldenDrgBG];
         this.obf_4_k_1780 = null;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            if(_loc4_)
            {
               _loc4_.gotoAndStop("stop");
               _loc4_.visible = _loc3_ == param1;
               if(_loc3_ == param1)
               {
                  this.obf_4_k_1780 = _loc4_;
               }
            }
            _loc3_++;
         }
      }
      
      public function obf_i_J_3003(param1:String) : void
      {
         param1 = ChatDecoder.decode(param1);
         this.obf_P_z_3192.push(param1);
         if(this.obf_P_z_3192.length > JSONUtil.getInt(obf_n_x_1562.config,["posts"]) * 2)
         {
            this.obf_I_4_2571();
            return;
         }
         txtOtherDrgAward.htmlText += param1 + "\n";
         txtOtherDrgAward.scrollV = int.MAX_VALUE;
         obf_5_f_1277.update();
      }
      
      public function obf_I_4_2571() : void
      {
         var _loc2_:String = null;
         var _loc1_:int = JSONUtil.getInt(obf_n_x_1562.config,["posts"]);
         if(this.obf_P_z_3192.length > _loc1_)
         {
            this.obf_P_z_3192.splice(0,this.obf_P_z_3192.length - _loc1_);
         }
         txtOtherDrgAward.htmlText = "";
         for each(_loc2_ in this.obf_P_z_3192)
         {
            txtOtherDrgAward.htmlText += _loc2_ + "\n";
         }
         txtOtherDrgAward.scrollV = int.MAX_VALUE;
         obf_5_f_1277.update();
      }
      
      public function onHaveItems(param1:Array) : void
      {
         var _loc4_:GameItemBriefInfo = null;
         var _loc5_:String = null;
         var _loc6_:IconItemBag = null;
         var _loc7_:DisplayObject = null;
         var _loc8_:Point = null;
         var _loc9_:Point = null;
         var _loc2_:String = "";
         var _loc3_:Array = new Array();
         for each(_loc4_ in param1)
         {
            if(_loc4_)
            {
               _loc2_ += DiversityManager.getString("DrgTreasure","prompt_HaveItem",[obf_7_6_4416.getItemLinkA(_loc4_.itemCode,_loc4_.itemId) + "x" + _loc4_.itemCount]) + "\n";
               if(_loc3_.indexOf(_loc4_.itemCode) == -1)
               {
                  _loc3_.push(_loc4_.itemCode);
               }
            }
         }
         for each(_loc5_ in _loc3_)
         {
            _loc6_ = this.getItemBagByItemCode(_loc5_);
            if(_loc6_)
            {
               _loc7_ = GameItemManager.getItemIcon(_loc5_);
               _loc8_ = _loc6_.localToGlobal(new Point());
               _loc7_.x = _loc8_.x;
               _loc7_.y = _loc8_.y;
               _loc9_ = tempBagButtonPrompt.localToGlobal(new Point(-16,-16));
               obf_K_e_3075.showUITween(_loc7_,2,_loc9_.x,_loc9_.y);
            }
         }
         txtDrgAward.htmlText += _loc2_;
         txtDrgAward.scrollV = int.MAX_VALUE;
         obf_z_f_2307.update();
      }
      
      public function obf_R_s_4398() : void
      {
         while(pointMoney.numChildren > 0)
         {
            pointMoney.removeChildAt(0);
         }
         if(GameContext.localPlayer)
         {
            pointMoney.addChild(obf_a_f_2935.getMoneyDisplay(GameContext.localPlayer.fullInfo.money));
         }
      }
      
      public function getItemBagByItemCode(param1:String) : IconItemBag
      {
         var _loc2_:IconItemBag = null;
         for each(_loc2_ in this.bags)
         {
            if(Boolean(_loc2_.haveIconItem) && _loc2_.haveIconItem.itemCode == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.obf_R_s_4398();
         this.obf_I_4_2571();
      }
      
      public function getIconItemBags() : Array
      {
         if(promptMC.visible)
         {
            return [];
         }
         return this.bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
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
   }
}

