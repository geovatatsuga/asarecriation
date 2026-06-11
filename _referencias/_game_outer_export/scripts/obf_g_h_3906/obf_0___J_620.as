package obf_g_h_3906
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.vacantSpace.VacantSpaceBallInfo;
   import com.sunweb.game.rpg.vacantSpace.obf_9_Y_4477;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.VacantSpaceBallUIMC;
   
   public class obf_0___J_620 extends VacantSpaceBallUIMC implements IPlayerUI, IIconItemUI
   {
      
      private var _bags:Array = new Array();
      
      private var upBag:IconItemBag;
      
      private var obf_6_2751:IconItemBag;
      
      public var index:int;
      
      public var ballInfo:VacantSpaceBallInfo;
      
      public var itemId:String = null;
      
      public var itemCode:String = null;
      
      public var itemCount:int = 0;
      
      public var upItem:IconItem = null;
      
      public function obf_0___J_620()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.upBag = new IconItemBag(iconUp,this,0);
         this.upBag.addValidType(GameItemType.ALL);
         this.upBag.isLocked = false;
         this._bags.push(this.upBag);
         this.obf_6_2751 = new IconItemBag(iconIn,this,1);
         this.obf_6_2751.addValidType(GameItemType.ALL);
         this.obf_6_2751.isLocked = false;
         this._bags.push(this.obf_6_2751);
         this.addListener();
      }
      
      public function initDiversity() : void
      {
         cmdUp.label = DiversityManager.getString("vacantSpaceUI","cmdUp");
         cmdIn.label = DiversityManager.getString("vacantSpaceUI","cmdIn");
      }
      
      private function addListener() : void
      {
         bg.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdUp.addEventListener(MouseEvent.CLICK,this.obf_s_l_1008);
         cmdIn.addEventListener(MouseEvent.CLICK,this.obf_4_r_879);
      }
      
      private function removeListener() : void
      {
         bg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdUp.removeEventListener(MouseEvent.CLICK,this.obf_s_l_1008);
         cmdIn.removeEventListener(MouseEvent.CLICK,this.obf_4_r_879);
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
      
      public function getIconItemBags() : Array
      {
         return this._bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(param3.parentIconUI != obf_K_e_3075.playerBagUI)
         {
            return;
         }
         var _loc4_:Object = GameItemManager.getItemConfig(param2.itemCode);
         if(!_loc4_)
         {
            return;
         }
         if(obf_9_Y_4477.disUse && JSONUtil.getInt(_loc4_,["dropMode"]) == 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("vacantSpaceUI","disUse"));
            return;
         }
         var _loc5_:int = int(obf_9_Y_4477.attrAdd[JSONUtil.getInt(_loc4_,["rank"]) + ""]);
         if(!_loc5_ || _loc5_ <= 0)
         {
            return;
         }
         if(param1 == this.obf_6_2751)
         {
            this.obf_6_2751.dropIconItem();
            this.itemId = param2.itemId;
            this.itemCode = param2.itemCode;
            this.itemCount = param2.itemCount;
            this.obf_6_2751.pushIconItem(param2);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(param1 == this.obf_6_2751)
         {
            this.obf_6_2751.dropIconItem();
            this.itemId = null;
            this.itemCode = null;
            this.itemCount = 0;
         }
      }
      
      public function obf_s_l_1008(param1:Event) : void
      {
         if(this.upItem)
         {
            if(obf_K_e_3075.playerBagUI.getEqualItemCount(this.upItem.itemCode) < this.upItem.itemCount)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("vacantSpaceUI","noItem"));
               return;
            }
            obf_9_Y_4477.sendVacantSpaceBallUpRequest(this.index);
            return;
         }
      }
      
      public function obf_4_r_879(param1:Event) : void
      {
         if(!this.itemId && !this.itemCode)
         {
            return;
         }
         obf_9_Y_4477.sendVacantSpaceBallInRequest(this.index,this.itemId,this.itemCode,this.itemCount);
      }
      
      public function refresh() : void
      {
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc1_:Object = obf_9_Y_4477.getBallConfig(this.index);
         var _loc2_:String = _loc1_ == null ? "" : JSONUtil.getStr(_loc1_,["name"]);
         txtName.htmlText = _loc2_;
         this.upBag.dropIconItem();
         var _loc3_:int = this.ballInfo.level;
         var _loc4_:Object = obf_9_Y_4477.getBallLevelConfig(_loc3_);
         var _loc5_:Object = _loc4_ == null ? null : JSONUtil.getObject(_loc4_,["upItems"]);
         if(_loc5_)
         {
            var _loc9_:int = 0;
            var _loc10_:* = _loc5_;
            for(_loc7_ in _loc10_)
            {
               _loc8_ = int(_loc5_[_loc7_]);
               this.upItem = IconItemManager.getIconItemByCode(_loc7_,null);
               this.upItem.itemCount = _loc8_;
               this.upBag.pushIconItem(this.upItem);
            }
            cmdUp.enabled = true;
         }
         else
         {
            cmdUp.enabled = false;
         }
         this.obf_6_2751.dropIconItem();
         var _loc6_:int = _loc4_ == null ? 0 : JSONUtil.getInt(_loc4_,["attrMax"]);
         if(_loc6_ == 0 || this.ballInfo.attrValue >= _loc6_)
         {
            cmdIn.enabled = false;
         }
         else
         {
            cmdIn.enabled = true;
         }
      }
   }
}

