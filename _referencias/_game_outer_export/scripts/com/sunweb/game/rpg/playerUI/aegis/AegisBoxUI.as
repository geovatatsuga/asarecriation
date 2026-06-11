package com.sunweb.game.rpg.playerUI.aegis
{
   import com.sunweb.game.res.obf_0_P_4381;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.aegis.AegisRequestType;
   import com.sunweb.game.rpg.aegis.obf_C_E_4362;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.shop.ShopManager;
   import com.sunweb.game.rpg.worldZone.command.aegis.AegisPlayerNotify;
   import com.sunweb.game.rpg.worldZone.command.aegis.AegisPrayAnswer;
   import com.sunweb.game.rpg.worldZone.command.aegis.AegisUpLevelAnswer;
   import com.sunweb.game.rpg.worldZone.command.aegis.AegisUpdateAnswer;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.AegisUIMC;
   
   public class AegisBoxUI extends AegisUIMC implements IIconItemUI
   {
      
      private var materialBag:IconItemBag;
      
      private var materialCurrentNum:int;
      
      private var upValues:int;
      
      private var cardArray:Array = new Array();
      
      private var CardEffectPoint:Array = new Array();
      
      private var _prayLimite:TimeLimiter = new TimeLimiter(1000);
      
      private var txtRankArray:Array = new Array();
      
      private var obf_k_t_2128:int;
      
      public function AegisBoxUI()
      {
         super();
         this.onResize(null);
         this.visible = false;
         this.materialBag = new IconItemBag(obf_b_0_808,this,0);
         this.materialBag.lockDrag = true;
         this.materialBag.addValidType(GameItemType.ALL);
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            (this["card" + _loc1_] as MovieClip).gotoAndStop(1);
            _loc1_++;
         }
         this.cardArray = [this.card0,this.card1,this.card2,this.card3,this.card4,this.card5,this.card6,this.card7,this.card8];
         var _loc2_:int = 0;
         while(_loc2_ < 9)
         {
            this.CardEffectPoint.push(this["point" + _loc2_] as MovieClip);
            _loc2_++;
         }
         this.addListener();
         this.initDiversity();
         this.txtRankArray = [DiversityManager.getString("AegisBoxUI","common"),DiversityManager.getString("AegisBoxUI","excellence"),DiversityManager.getString("AegisBoxUI","perfection"),DiversityManager.getString("AegisBoxUI","legend")];
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(titleAegis,"AegisBoxUI","txttitle");
         cmdAegis.label = DiversityManager.getString("AegisBoxUI","txtAegis");
         cmdAegisLevel.label = DiversityManager.getString("AegisBoxUI","txtAegisLevel");
         obf_0_8_B_611.label = DiversityManager.getString("AegisBoxUI","txtAutoMateria");
         txtSystem.htmlText = DiversityManager.getString("AegisBoxUI","txtSystem");
      }
      
      private function addListener() : void
      {
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdAegis.addEventListener(MouseEvent.CLICK,this.onClickAegis);
         cmdAegisLevel.addEventListener(MouseEvent.CLICK,this.obf_0_0_B_625);
         cmdAegisLevel.addEventListener(MouseEvent.MOUSE_MOVE,this.showAegisPoint);
         cmdAegisLevel.addEventListener(MouseEvent.MOUSE_OUT,this.outAegisPoint);
      }
      
      private function removeListener() : void
      {
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdAegis.removeEventListener(MouseEvent.CLICK,this.onClickAegis);
         cmdAegisLevel.removeEventListener(MouseEvent.CLICK,this.obf_0_0_B_625);
         cmdAegisLevel.removeEventListener(MouseEvent.MOUSE_MOVE,this.showAegisPoint);
         cmdAegisLevel.removeEventListener(MouseEvent.MOUSE_OUT,this.outAegisPoint);
      }
      
      private function showAegisPoint(param1:Event) : void
      {
         var _loc2_:GameTipUI = null;
         var _loc3_:int = 0;
         if(obf_C_E_4362.obf_0_5_o_582 >= this.txtRankArray.length)
         {
            _loc2_ = new GameTipUI("AegisMouseTip");
            _loc3_ = 200;
            _loc3_ = 150;
            _loc2_.addTipInfo("<P align=\'center\'>" + DiversityManager.getString("AegisBoxUI","needPoint",[obf_C_E_4362.getUpValues(obf_C_E_4362.obf_7_m_2787)]) + "</FONT>",_loc3_,_loc2_.maxRow + 1);
            GameTipManager.showTip(_loc2_);
         }
      }
      
      private function outAegisPoint(param1:Event) : void
      {
         if(obf_C_E_4362.obf_0_5_o_582 >= this.txtRankArray.length)
         {
            GameTipManager.closeTip("AegisMouseTip");
         }
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2 - 150;
         this.y = GameContext.gameStage.stageHeight / 2 - 50;
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onClickAegis(param1:Event) : void
      {
         if(!this._prayLimite.checkTimeout())
         {
            return;
         }
         if(obf_C_E_4362.obf_0_5_o_582 >= obf_C_E_4362.rankList.length && obf_C_E_4362.obf_7_m_2787 >= obf_C_E_4362.maxLevel(obf_C_E_4362.obf_0_5_o_582))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AegisBoxUI","noAegis"));
            return;
         }
         if(!obf_K_e_3075.playerBagUI)
         {
            return;
         }
         var _loc2_:int = obf_K_e_3075.playerBagUI.getItemCount(obf_C_E_4362.getCode);
         this.materialCurrentNum = obf_C_E_4362.getItemNums(obf_C_E_4362.obf_i_P_1289);
         if(_loc2_ >= this.materialCurrentNum)
         {
            obf_C_E_4362.sendAegis(AegisRequestType.PRAY);
         }
         else if(obf_0_8_B_611.selected && _loc2_ < this.materialCurrentNum)
         {
            ShopManager.sendStoreBuyItem(obf_C_E_4362.getCode,ShopManager.obf_B_9_2165,"",this.materialCurrentNum - _loc2_);
            this.addEventListener(Event.ENTER_FRAME,this.onEnterframe);
         }
         else
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AegisBoxUI","noMaterial",[GameItemManager.getItemName(obf_C_E_4362.getCode)]));
         }
      }
      
      private function onEnterframe(param1:Event) : void
      {
         if(!obf_K_e_3075.playerBagUI)
         {
            return;
         }
         if(obf_K_e_3075.playerBagUI.getItemCount(obf_C_E_4362.getCode) >= this.materialCurrentNum)
         {
            obf_C_E_4362.sendAegis(AegisRequestType.PRAY);
            this.removeEventListener(Event.ENTER_FRAME,this.onEnterframe);
         }
      }
      
      private function onGetAegis(param1:Event) : void
      {
         if(obf_C_E_4362.obf_0_5_o_582 >= obf_C_E_4362.rankList.length)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AegisBoxUI","maxRank"));
            return;
         }
         if(obf_C_E_4362.openCardArray.length <= 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AegisBoxUI","noSuccesse"));
            return;
         }
         obf_C_E_4362.sendAegis(AegisRequestType.UPDATE);
      }
      
      private function obf_0_0_B_625(param1:Event) : void
      {
         if(obf_C_E_4362.obf_0_5_o_582 < this.txtRankArray.length)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AegisBoxUI","achieveRank"));
            return;
         }
         if(obf_C_E_4362.aegisPoint < obf_C_E_4362.getUpValues(obf_C_E_4362.obf_7_m_2787))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AegisBoxUI","noPoint"));
            return;
         }
         if(obf_C_E_4362.obf_7_m_2787 >= obf_C_E_4362.maxLevel(obf_C_E_4362.obf_0_5_o_582))
         {
            if(obf_C_E_4362.obf_0_5_o_582 == 0)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("AegisBoxUI","upRank"));
               return;
            }
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AegisBoxUI","maxLevel",[this.getTextRank(obf_C_E_4362.obf_0_5_o_582)]));
            return;
         }
         obf_C_E_4362.sendAegis(AegisRequestType.UPLEVEL);
      }
      
      public function refurbish(param1:AegisPlayerNotify) : void
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1.aegisList)
         {
            (this.cardArray[_loc2_] as MovieClip).gotoAndStop(2);
         }
         this.obf_k_t_2128 = param1.aegisValue;
         obf_x_l_3067.text = DiversityManager.getString("AegisBoxUI","aegiePointNum") + ": " + param1.aegisValue;
         this.obf_S_V_1901(param1.aegisPray);
         this.refreshAegisAtrr(param1.aegisLevel,param1.aegisRank);
         this.isView();
      }
      
      private function obf_S_V_1901(param1:int) : void
      {
         if(Boolean(this.materialBag) && Boolean(this.materialBag.haveIconItem))
         {
            this.materialBag.dropIconItem();
         }
         var _loc2_:IconItem = IconItemManager.getIconItemByCode(obf_C_E_4362.getCode,"");
         _loc2_.itemCount = obf_C_E_4362.getItemNums(param1);
         this.materialBag.pushIconItem(_loc2_);
      }
      
      private function refreshAegisAtrr(param1:int, param2:int) : void
      {
         var _loc3_:String = "";
         var _loc4_:String = "";
         var _loc5_:String = "";
         if(param1 == 0 || param2 == 0)
         {
            AegisAtrr.text = "";
            return;
         }
         var _loc6_:Array = obf_C_E_4362.getLevelStr(param2,param1);
         var _loc7_:String = GameItemRank.getRankColor(param2).toString(16);
         _loc3_ = "<P align=\'center\'><font color=\'#FF0000\'>" + DiversityManager.getString("AegisBoxUI","strLv",[param1]) + "</font></P>";
         _loc4_ = "<P align=\'center\'><font color=\'#" + _loc7_ + "\'>" + DiversityManager.getString("AegisBoxUI","strRank",[this.getTextRank(param2)]) + "</font></P>";
         _loc5_ = "<P align=\'center\'><font color=\'#00FF00\'>" + DiversityManager.getString("AegisBoxUI","strAtt") + "</font></P>";
         var _loc8_:String = "";
         var _loc9_:int = 0;
         while(_loc9_ < _loc6_.length)
         {
            _loc8_ += _loc6_[_loc9_] + "\n";
            _loc9_++;
         }
         AegisAtrr.htmlText = "\n" + _loc3_ + _loc4_ + _loc5_ + "<P align=\'center\'><font color=\'#00FF00\'>" + _loc8_ + "</font></P>";
      }
      
      public function obf_s_B_4526(param1:AegisUpdateAnswer) : void
      {
         var _loc3_:MovieClip = null;
         if(!param1.isSuccessed)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AegisBoxUI","noSuccesse"));
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.cardArray.length)
         {
            _loc3_ = this.cardArray[_loc2_] as MovieClip;
            _loc3_.gotoAndStop(1);
            _loc2_++;
         }
         this.refreshAegisAtrr(param1.aegisLevel,param1.aegisRank);
         this.obf_S_V_1901(param1.aegisPray);
         this.isView();
      }
      
      public function obf_t_c_4393(param1:AegisUpLevelAnswer) : void
      {
         this.obf_k_t_2128 = param1.aegisValue;
         obf_x_l_3067.text = DiversityManager.getString("AegisBoxUI","aegiePointNum") + ": " + param1.aegisValue + "";
         this.refreshAegisAtrr(param1.aegisLevel,obf_C_E_4362.obf_0_5_o_582);
         this.isView();
      }
      
      public function obf_T_W_1546(param1:AegisPrayAnswer) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc2_:Boolean = false;
         for each(_loc4_ in obf_C_E_4362.openCardArray)
         {
            if(!(_loc4_ < 0 || _loc4_ > this.cardArray.length))
            {
               _loc3_ = this.cardArray[_loc4_] as MovieClip;
               _loc3_.gotoAndStop(2);
               if(_loc4_ == param1.turnIndex)
               {
                  obf_0_P_4381.obf_q_h_1296("openCard@cardEfect",this.CardEffectPoint[param1.turnIndex],null,true);
                  _loc2_ = true;
               }
            }
         }
         if(!_loc2_)
         {
            obf_0_P_4381.obf_q_h_1296("openCard@cardEfect",this.CardEffectPoint[param1.turnIndex],null,true);
            _loc3_ = this.cardArray[param1.turnIndex] as MovieClip;
            _loc3_.gotoAndStop(2);
         }
         this.obf_S_V_1901(param1.aegisPray);
         if(param1.aegisValue - this.obf_k_t_2128 > 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("AegisBoxUI","getAegisValue",[param1.aegisValue - this.obf_k_t_2128]));
            this.obf_k_t_2128 = param1.aegisValue;
         }
         obf_x_l_3067.text = DiversityManager.getString("AegisBoxUI","aegiePointNum") + ": " + param1.aegisValue + "";
      }
      
      private function getTextRank(param1:int) : String
      {
         return JSONUtil.getStr(this.txtRankArray,[param1 - 1]);
      }
      
      private function isView() : void
      {
         if(obf_C_E_4362.obf_7_m_2787 >= obf_C_E_4362.maxLevel(obf_C_E_4362.obf_0_5_o_582))
         {
            cmdAegisLevel.enabled = false;
         }
         else
         {
            cmdAegisLevel.enabled = true;
         }
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      public function getIconItemBags() : Array
      {
         return [this.materialBag];
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
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
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

