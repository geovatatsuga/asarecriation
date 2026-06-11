package obf_2_Q_4093
{
   import obf_0_6_Z_584.obf_5_M_1027;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.VarShopBoxUIMC;
   
   public class VarShopBoxUI extends VarShopBoxUIMC implements IIconItemUI
   {
      
      private var _id:String;
      
      private var _kind:int;
      
      private var _boxList:Array;
      
      private var _page:int;
      
      private var obf_7_2_2783:int;
      
      public function VarShopBoxUI()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.addListener();
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get kind() : int
      {
         return this._kind;
      }
      
      public function init(param1:String) : void
      {
         if(!obf_5_M_1027.shopTypes || !obf_5_M_1027.shopKinds)
         {
            return;
         }
         var _loc2_:Object = obf_5_M_1027.shopTypes[param1];
         if(!_loc2_)
         {
            return;
         }
         this._id = param1;
         var _loc3_:Array = JSONUtil.getValue(_loc2_,["kinds"]) as Array;
         this._kind = _loc3_[0];
         var _loc4_:int = 0;
         while(_loc4_ < 9)
         {
            this["kind" + _loc4_].gotoAndStop(1);
            _loc4_++;
         }
         kind0.gotoAndStop(2);
         this.refreshBoxList(this._kind);
         this.refreshShopUI();
         this.obf_0_6_v_213();
      }
      
      public function refreshBoxList(param1:int) : void
      {
         var _loc4_:Object = null;
         var _loc5_:obf_Q_8_4338 = null;
         if(this._boxList)
         {
            this._boxList = null;
         }
         var _loc2_:Array = JSONUtil.getValue(obf_5_M_1027.shopKinds[this._kind],["items"]) as Array;
         if(!_loc2_)
         {
            return;
         }
         this._boxList = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc5_ = new obf_Q_8_4338();
            _loc5_.obf_5_d_847(_loc4_);
            this._boxList.push(_loc5_);
            _loc3_++;
         }
         this._page = 1;
         this.obf_7_2_2783 = (_loc2_.length - 1) / 16 + 1;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         cmdPrvPage.label = DiversityManager.getString("varShopBoxUI","cmdPrvPage");
         cmdNextPage.label = DiversityManager.getString("varShopBoxUI","cmdNextPage");
      }
      
      private function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            this["kind" + _loc1_].addEventListener(MouseEvent.CLICK,this.obf_u_y_2763);
            _loc1_++;
         }
         cmdPrvPage.addEventListener(MouseEvent.CLICK,this.obf_0_7_R_475);
         cmdNextPage.addEventListener(MouseEvent.CLICK,this.obf_C_R_4204);
      }
      
      private function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         var _loc1_:int = 0;
         while(_loc1_ < 9)
         {
            this["kind" + _loc1_].removeEventListener(MouseEvent.CLICK,this.obf_u_y_2763);
            _loc1_++;
         }
         cmdPrvPage.removeEventListener(MouseEvent.CLICK,this.obf_0_7_R_475);
         cmdNextPage.removeEventListener(MouseEvent.CLICK,this.obf_C_R_4204);
      }
      
      private function obf_u_y_2763(param1:MouseEvent) : void
      {
         var _loc2_:int = this.obf_Q_V_2397(param1.currentTarget);
         var _loc3_:Object = obf_5_M_1027.shopTypes[this.id];
         var _loc4_:Array = JSONUtil.getValue(_loc3_,["kinds"]) as Array;
         this._kind = _loc4_[_loc2_];
         this.refreshBoxList(this._kind);
         this.refreshShopUI();
      }
      
      public function obf_Q_V_2397(param1:Object) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < 9)
         {
            if(param1 == this["kind" + _loc3_])
            {
               this["kind" + _loc3_].gotoAndStop(2);
               _loc2_ = _loc3_;
            }
            else
            {
               this["kind" + _loc3_].gotoAndStop(1);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function obf_0_7_R_475(param1:Event) : void
      {
         if(this._page <= 1)
         {
            return;
         }
         --this._page;
         this.refreshShopUI();
      }
      
      private function obf_C_R_4204(param1:Event) : void
      {
         if(this._page >= this.obf_7_2_2783)
         {
            return;
         }
         this._page += 1;
         this.refreshShopUI();
      }
      
      public function obf_0_6_v_213() : void
      {
         var _loc4_:Object = null;
         var _loc1_:Object = obf_5_M_1027.shopTypes[this._id];
         txtTitle.text = JSONUtil.getStr(_loc1_,["name"]);
         txtVarName.text = JSONUtil.getStr(_loc1_,["varName"]);
         this.setPlayerVarValue();
         var _loc2_:Array = JSONUtil.getValue(_loc1_,["kinds"]) as Array;
         var _loc3_:int = 0;
         while(_loc3_ < 9)
         {
            if(_loc3_ < _loc2_.length)
            {
               _loc4_ = obf_5_M_1027.shopKinds[_loc2_[_loc3_]];
               this["kind" + _loc3_].txtLabel.text = JSONUtil.getStr(_loc4_,["kindName"]);
               this["kind" + _loc3_].visible = true;
            }
            else
            {
               this["kind" + _loc3_].visible = false;
            }
            _loc3_++;
         }
      }
      
      public function setPlayerVarValue() : void
      {
         var _loc1_:Object = obf_5_M_1027.shopTypes[this._id];
         var _loc2_:* = GameContext.localPlayer.dynamicVars.intVars[JSONUtil.getStr(_loc1_,["var"])];
         if(_loc2_ == null)
         {
            _loc2_ = 0;
         }
         txtVarNum.text = _loc2_;
      }
      
      public function refreshShopUI() : void
      {
         var _loc4_:Object = null;
         var _loc1_:int = 0;
         while(_loc1_ < 16)
         {
            while(this["box" + _loc1_].numChildren > 0)
            {
               this["box" + _loc1_].removeChildAt(0);
            }
            _loc1_++;
         }
         DiversityManager.setTextField(txtPage,"varShopBoxUI","txtPage",[this._page + "/" + this.obf_7_2_2783]);
         var _loc2_:int = 16 * (this._page - 1);
         var _loc3_:int = 0;
         while(_loc3_ < 16)
         {
            _loc4_ = this._boxList[_loc2_];
            if(_loc4_)
            {
               this["box" + _loc3_].addChild(_loc4_);
               _loc2_++;
            }
            _loc3_++;
         }
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bg.getBounds(bg).contains(bg.mouseX,bg.mouseY);
         }
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
      
      public function getIconItemBags() : Array
      {
         var _loc2_:Object = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this._boxList)
         {
            _loc1_.push(_loc2_.iconBag);
         }
         return _loc1_;
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
   }
}

