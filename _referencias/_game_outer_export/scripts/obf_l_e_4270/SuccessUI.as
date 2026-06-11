package obf_l_e_4270
{
   import obf_g_A_3629.ChatDecoder;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.buff.BuffManager;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.netRole.obf_n_u_l_l_2508;
   import com.sunweb.game.rpg.playerUI.ItemShowBoxUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.script.MacroScript;
   import com.sunweb.game.rpg.success.obf_j_Y_1351;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import fl.controls.dataGridClasses.DataGridColumn;
   import fl.data.DataProvider;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.AchievementUIMC;
   
   public class SuccessUI extends AchievementUIMC implements IIconItemUI
   {
      
      private var typeButtonList:Array;
      
      private var obf_z_Y_2913:String;
      
      private var bags:Array;
      
      private var timeInv:TimeLimiter;
      
      private var obf_y_M_1643:TimeLimiter;
      
      public function SuccessUI()
      {
         var _loc5_:String = null;
         var _loc6_:TableButton = null;
         this.bags = new Array();
         this.timeInv = new TimeLimiter(10000);
         this.obf_y_M_1643 = new TimeLimiter(3000);
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         var _loc1_:Array = new Array();
         var _loc2_:DataGridColumn = new DataGridColumn(DiversityManager.getString("SuccessUI","listName"));
         _loc2_.width = 150;
         _loc2_.dataField = "name";
         _loc2_.editable = false;
         _loc2_.sortable = false;
         _loc1_.push(_loc2_);
         var _loc3_:DataGridColumn = new DataGridColumn(DiversityManager.getString("SuccessUI","listDoneTimes"));
         _loc3_.dataField = "name";
         _loc3_.labelFunction = this.listSuccessSitLabel;
         _loc3_.editable = false;
         _loc3_.sortable = false;
         _loc1_.push(_loc3_);
         var _loc4_:DataGridColumn = new DataGridColumn(DiversityManager.getString("SuccessUI","listComplete"));
         _loc4_.dataField = "name";
         _loc4_.labelFunction = this.listSuccessDoneLabel;
         _loc4_.editable = false;
         _loc4_.sortable = false;
         _loc1_.push(_loc4_);
         listSuccess.columns = _loc1_;
         this.typeButtonList = new Array();
         for each(_loc5_ in obf_j_Y_1351.types)
         {
            _loc6_ = new TableButton();
            _loc6_.name = _loc5_;
            _loc6_.txtLabel.text = _loc5_;
            _loc6_.x = pointType.width;
            _loc6_.width = 100;
            pointType.addChild(_loc6_);
            this.typeButtonList.push(_loc6_);
         }
         this.selectType(JSONUtil.getStr(obf_j_Y_1351.types,[0]));
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"SuccessUI","title");
         DiversityManager.setTextField(txtDeySuccessCondition,"SuccessUI","txtSuccessCondition");
         DiversityManager.setTextField(txtDeySuccessAward,"SuccessUI","txtSuccessAward");
         DiversityManager.setTextField(txtDeyTitleContent,"SuccessUI","txtTitleContent");
      }
      
      private function addListener() : void
      {
         var _loc1_:TableButton = null;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         listSuccess.addEventListener(Event.CHANGE,this.obf_f_O_1450);
         txtSuccessCondition.addEventListener(TextEvent.LINK,this.onClickLink);
         for each(_loc1_ in this.typeButtonList)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_P_G_3138);
         }
      }
      
      private function removeListener() : void
      {
         var _loc1_:TableButton = null;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         listSuccess.removeEventListener(Event.CHANGE,this.obf_f_O_1450);
         txtSuccessCondition.removeEventListener(TextEvent.LINK,this.onClickLink);
         for each(_loc1_ in this.typeButtonList)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_P_G_3138);
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
      
      private function listSuccessSitLabel(param1:Object) : String
      {
         if(param1.isNone)
         {
            return "-------";
         }
         return obf_j_Y_1351.getSuccessDoneTimesName(param1.successId);
      }
      
      private function listSuccessDoneLabel(param1:Object) : String
      {
         if(param1.isNone)
         {
            return "-------";
         }
         return DiversityManager.getString("SuccessUI",obf_j_Y_1351.successIsDone(param1.successId) ? "successDone" : "successNotDone");
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.timeInv.checkTimeout() && Boolean(GameContext.localPlayer))
         {
            obf_j_Y_1351.obf_g_5_1840();
         }
         if(this.visible && this.obf_y_M_1643.checkTimeout())
         {
            this.obf_g_d_2160();
         }
      }
      
      private function obf_f_O_1450(param1:Event) : void
      {
         this.obf_g_d_2160();
      }
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function obf_P_G_3138(param1:Event) : void
      {
         this.selectType(param1.currentTarget.name);
      }
      
      public function selectType(param1:String) : void
      {
         var _loc2_:TableButton = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         this.obf_z_Y_2913 = param1;
         for each(_loc2_ in this.typeButtonList)
         {
            _loc2_.gotoAndStop(_loc2_.name == param1 ? 2 : 1);
         }
         _loc3_ = obf_j_Y_1351.getSuccessConfigByType(param1);
         _loc4_ = "";
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = _loc3_[_loc5_];
            if(_loc6_.subKind != _loc4_)
            {
               _loc3_.splice(_loc5_,0,{
                  "name":DiversityManager.getString("SuccessUI","listSubTypeShow",[_loc6_.subKind]),
                  "isNone":true
               });
               _loc4_ = _loc6_.subKind;
            }
            _loc5_++;
         }
         listSuccess.dataProvider = new DataProvider(_loc3_);
      }
      
      public function obf_g_d_2160() : void
      {
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:DisplayObject = null;
         listSuccess.invalidateList();
         DiversityManager.setTextField(txtSuccessTotle,"SuccessUI","txtSuccessTotal",[obf_j_Y_1351.doneSuccessTotal + "/" + obf_j_Y_1351.successTotal],true);
         var _loc1_:int = obf_j_Y_1351.doneSuccessTotal / obf_j_Y_1351.successTotal * 100;
         barSuccessTotle.gotoAndStop(_loc1_);
         txtSuccessCondition.htmlText = "";
         txtTitleContent.htmlText = "";
         while(pointSuccessAward.numChildren > 0)
         {
            pointSuccessAward.removeChildAt(0);
         }
         var _loc2_:Object = listSuccess.selectedItem;
         if(!_loc2_ || Boolean(_loc2_.isNone))
         {
            return;
         }
         txtSuccessCondition.htmlText = ChatDecoder.decode(JSONUtil.getStr(_loc2_,["detail"])) + "\n";
         txtSuccessCondition.htmlText += ChatDecoder.decode(ConditionScript.getConditionsHTML(JSONUtil.getObject(_loc2_,["condition"])));
         obf_X_d_2366.update();
         var _loc3_:Object = obf_n_u_l_l_2508.getTitleConfig(_loc2_.titleIndex);
         if(_loc3_)
         {
            txtTitleContent.htmlText = JSONUtil.getStr(BuffManager.getBuffConfigById(_loc3_.titleBuffId),["buffDetail"]);
         }
         var _loc4_:Array = MacroScript.getMacroDisplay("addTitle",_loc2_.titleIndex);
         if((Boolean(_loc4_)) && _loc4_.length > 0)
         {
            pointSuccessAward.addChild(_loc4_[0]);
         }
         for(_loc5_ in _loc2_.onSuccess)
         {
            _loc6_ = MacroScript.getMacroDisplay(_loc5_,_loc2_.onSuccess[_loc5_]);
            for each(_loc7_ in _loc6_)
            {
               if(_loc7_ is ItemShowBoxUI)
               {
                  ItemShowBoxUI(_loc7_).dockParentUI(this,this.bags);
               }
               _loc7_.y = pointSuccessAward.height;
               pointSuccessAward.addChild(_loc7_);
            }
         }
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return bgBox.getBounds(bgBox).contains(bgBox.mouseX,bgBox.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         obf_j_Y_1351.sendViewWorldSuccessTimes();
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
         return this.bags;
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

