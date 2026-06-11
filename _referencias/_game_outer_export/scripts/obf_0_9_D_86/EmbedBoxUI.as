package obf_0_9_D_86
{
   import obf_x_O_4078.obf_A_V_935;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.EmbedBoxUIMC;
   import playerUI.IconItemBagTips;
   
   public class EmbedBoxUI extends EmbedBoxUIMC implements IIconItemUI, obf_0_d_4341
   {
      
      private const obf_N_p_3608:String = "hole";
      
      private const obf_L_5_3704:String = "disembed";
      
      private var maxGemCount:int = 5;
      
      private var obf_m_o_2112:Array;
      
      private var showGemBags:Array;
      
      private var _equipBag:IconItemBag;
      
      private var obf_A_m_3897:IconItemBag;
      
      private var equipInfo:GameItemFullInfo;
      
      private var action:String;
      
      private var _noviceSprite:Sprite;
      
      private var timeInv:TimeLimiter;
      
      private var selectedGemIndex:int;
      
      private var selectedGemCode:String;
      
      public function EmbedBoxUI()
      {
         var _loc2_:MovieClip = null;
         var _loc3_:IconItemBag = null;
         this.timeInv = new TimeLimiter(100);
         super();
         this.initDiversity();
         this.x = 200;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         this._equipBag = new IconItemBag(bagEquip,this,0);
         this._equipBag.addValidType(GameItemType.EQUIPMENT);
         this.obf_A_m_3897 = new IconItemBag(bagMaterial,this,0);
         this.obf_A_m_3897.addValidType(GameItemType.ALL);
         this.obf_A_m_3897.lockDrag = true;
         this.obf_m_o_2112 = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < this.maxGemCount)
         {
            _loc2_ = this["bag" + _loc1_];
            if(_loc2_)
            {
               _loc3_ = new IconItemBag(_loc2_,this,_loc1_);
               _loc3_.addValidType(GameItemType.ALL);
               _loc3_.lockDrag = true;
               this.obf_m_o_2112.push(_loc3_);
            }
            _loc1_++;
         }
         this.addListener();
         this.obf_0_8_p_357();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"EmbedBoxUI","txtTitle");
         DiversityManager.setTextField(txtDeyEquip,"EmbedBoxUI","txtEquip");
         DiversityManager.setTextField(txtDeyMaterial,"EmbedBoxUI","txtMaterial");
         DiversityManager.setTextField(txtDeyPrompt,"EmbedBoxUI","txtPrompt");
         DiversityManager.setTextField(txtDeyGemType,"EmbedBoxUI","txtGemType",null,true);
      }
      
      public function set noviceSprite(param1:Sprite) : void
      {
         this._noviceSprite = param1;
      }
      
      public function get noviceSprite() : Sprite
      {
         return this._noviceSprite;
      }
      
      public function get novicePromptName() : String
      {
         return "EmbedBoxUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         var _loc2_:DisplayObject = this[param1];
         if(!_loc2_)
         {
            return null;
         }
         return new Point(_loc2_.x + _loc2_.width / 2,_loc2_.y + _loc2_.height / 2);
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         return JSONUtil.getObject(this,[param1]) as DisplayObject;
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         txtDeyGemType.addEventListener(MouseEvent.MOUSE_OVER,this.obf_o_a_1923);
         txtDeyGemType.addEventListener(MouseEvent.MOUSE_OUT,this.obf_e_p_3916);
         cmdAction.addEventListener(MouseEvent.CLICK,this.doAction);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         txtDeyGemType.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_o_a_1923);
         txtDeyGemType.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_e_p_3916);
         cmdAction.removeEventListener(MouseEvent.CLICK,this.doAction);
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
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.timeInv.checkTimeout() && !this.equipInfo)
         {
            this.obf_l_n_3275();
         }
      }
      
      private function obf_o_a_1923(param1:Event) : void
      {
         var _loc6_:int = 0;
         if(!this._equipBag.haveIconItem)
         {
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(this._equipBag.haveIconItem.itemCode);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Object = obf_A_V_935.getEmbedPlan(JSONUtil.getStr(_loc2_,["properties","embedPlanId"]));
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:GameTipUI = new GameTipUI("gemType");
         var _loc5_:int = 120;
         _loc4_.addTipInfo("<p align=\'center\'>" + DiversityManager.getString("EmbedBoxUI","gemType",[JSONUtil.getInt(_loc2_,["properties","embedGemLevel"])]) + "</p>",_loc5_,0);
         _loc4_.addTipInfo("  ",_loc5_,_loc4_.maxRow + 1);
         for each(_loc6_ in _loc3_.embedGemType)
         {
            _loc4_.addTipInfo("<p align=\'center\'>" + obf_A_V_935.getGemTypeName(_loc6_) + "</p>",_loc5_,_loc4_.maxRow + 1);
         }
         GameTipManager.showTip(_loc4_);
      }
      
      private function obf_e_p_3916(param1:Event) : void
      {
         GameTipManager.closeTip("gemType");
      }
      
      private function obf_l_n_3275() : void
      {
         if(!this._equipBag.haveIconItem)
         {
            return;
         }
         this.equipInfo = GameItemInfoManager.getItemInfo(this._equipBag.haveIconItem.itemId);
         if(this.equipInfo)
         {
            this.setGemBags(this.equipInfo);
         }
         else
         {
            GameContext.bagItemManager.sendViewItem(this._equipBag.haveIconItem.itemId);
         }
      }
      
      public function pushEquipIn(param1:IconItemEquip) : void
      {
         var _loc2_:Object = GameItemManager.getItemConfig(param1.itemCode);
         if(!_loc2_)
         {
            return;
         }
         this.clearContent();
         this.obf_0_8_p_357();
         this.equipInfo = null;
         this._equipBag.dropIconItem();
         this._equipBag.pushIconItem(param1);
      }
      
      public function obf_m_C_3806(param1:String, param2:int) : void
      {
         var _loc9_:Object = null;
         if(!this.equipInfo || !this._equipBag.haveIconItem)
         {
            return;
         }
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            return;
         }
         if(!obf_A_V_935.obf_0_6_B_169(this._equipBag.haveIconItem.itemCode,param1))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EmbedUI","error_GemType"));
            return;
         }
         if(!obf_A_V_935.obf_j_n_1267(this._equipBag.haveIconItem.itemCode,param1))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EmbedUI","error_GemLevel"));
            return;
         }
         var _loc4_:int = int(this.equipInfo.equipmentInfo.embedGemCodeList.length);
         var _loc5_:String = "";
         var _loc6_:Object = GameItemManager.getItemConfig(this.equipInfo.itemCode);
         var _loc7_:Object = obf_A_V_935.getEmbedPlan(JSONUtil.getStr(_loc6_,["properties","embedPlanId"]));
         var _loc8_:int = 0;
         while(_loc8_ < this.equipInfo.equipmentInfo.embedGemCodeList.length)
         {
            _loc9_ = GameItemManager.getItemConfig(this.equipInfo.equipmentInfo.embedGemCodeList[_loc8_]);
            if(_loc9_)
            {
               if(JSONUtil.getBoolean(_loc7_,["onlyDiffType"]) && JSONUtil.getInt(_loc9_,["properties","gemType"]) == JSONUtil.getInt(_loc3_,["properties","gemType"]))
               {
                  if(JSONUtil.getInt(_loc9_,["properties","gemLevel"]) >= JSONUtil.getInt(_loc3_,["properties","gemLevel"]))
                  {
                     obf_K_e_3075.showTipInfo(DiversityManager.getString("EmbedUI","error_CantCover"));
                     return;
                  }
                  _loc5_ = DiversityManager.getString("EmbedUI","prompt_GemCover");
                  _loc4_ = _loc8_;
                  break;
               }
            }
            _loc8_++;
         }
         if(_loc4_ > this.equipInfo.equipmentInfo.holeNumber - 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("EmbedUI","error_NoMoreHole"));
            return;
         }
         WindowManager.showConfirmBox(_loc5_ + "\n" + DiversityManager.getString("EmbedBoxUI","confirm_Embed",[obf_7_6_4416.getItemLinkA(param1,"")]),this.confirmEmbed,{
            "gemIndex":_loc4_,
            "itemIndex":param2
         });
      }
      
      private function selectHole() : void
      {
         var _loc4_:String = null;
         var _loc5_:IconItem = null;
         if(!this.equipInfo || !this._equipBag.haveIconItem)
         {
            return;
         }
         var _loc1_:Object = GameItemManager.getItemConfig(this._equipBag.haveIconItem.itemCode);
         var _loc2_:Object = obf_A_V_935.getHolePlan(JSONUtil.getStr(_loc1_,["properties","holePlanId"]));
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Object = obf_A_V_935.getHoleCost(_loc2_.planId,this.equipInfo.equipmentInfo.holeNumber);
         if(!GameItemManager.itemCanHole(this._equipBag.haveIconItem.itemCode) || !_loc3_)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("HoleUI","error_EquipCantHole"));
            return;
         }
         txtChance.text = DiversityManager.getString("EmbedBoxUI","txtChance") + Number(_loc3_.chance * 100).toFixed(2) + "%";
         var _loc6_:int = 0;
         var _loc7_:* = _loc3_.costItems;
         for(_loc4_ in _loc7_)
         {
            _loc5_ = IconItemManager.getIconItemByCode(_loc4_,"");
            if(_loc5_)
            {
               _loc5_.itemCount = _loc3_.costItems[_loc4_];
               this.obf_A_m_3897.pushIconItem(_loc5_);
               if(obf_K_e_3075.playerBagUI.getEqualItemCount(_loc4_) < _loc3_.costItems[_loc4_])
               {
                  _loc5_.countTextColor = 16711680;
               }
               else
               {
                  _loc5_.countTextColor = 16777215;
               }
            }
         }
         this.action = this.obf_N_p_3608;
         cmdAction.label = DiversityManager.getString("EmbedBoxUI","cmdHole");
         cmdAction.visible = true;
      }
      
      private function selectDisembed(param1:String, param2:int) : void
      {
         if(!this.equipInfo || !this._equipBag.haveIconItem)
         {
            return;
         }
         this.selectedGemIndex = param2;
         this.selectedGemCode = param1;
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:Object = obf_A_V_935.getDisembedCost(JSONUtil.getInt(_loc3_,["properties","gemLevel"]));
         if(!_loc4_)
         {
            return;
         }
         this.obf_A_m_3897.dropIconItem();
         var _loc5_:IconItem = IconItemManager.getIconItemByCode(JSONUtil.getStr(_loc4_,["costItemCode"]),"");
         if(_loc5_)
         {
            _loc5_.itemCount = JSONUtil.getInt(_loc4_,["costItemNum"]);
            this.obf_A_m_3897.pushIconItem(_loc5_);
         }
         this.action = this.obf_L_5_3704;
         cmdAction.label = DiversityManager.getString("EmbedBoxUI","cmdDisembed");
         cmdAction.visible = true;
      }
      
      private function doAction(param1:Event) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         if(!this.equipInfo || !this._equipBag.haveIconItem)
         {
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(this._equipBag.haveIconItem.itemCode);
         if(!_loc2_)
         {
            return;
         }
         if(!obf_K_e_3075.playerBagUI.getIconItemBagByID(this._equipBag.haveIconItem.itemId))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","notHaveItemInBag"));
            return;
         }
         if(this.action == this.obf_N_p_3608)
         {
            _loc3_ = obf_A_V_935.getHolePlan(JSONUtil.getStr(_loc2_,["properties","holePlanId"]));
            if(!_loc3_)
            {
               return;
            }
            _loc4_ = obf_A_V_935.getHoleCost(_loc3_.planId,this.equipInfo.equipmentInfo.holeNumber);
            if(!GameItemManager.itemCanHole(this._equipBag.haveIconItem.itemCode) || !_loc4_)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("HoleUI","error_EquipCantHole"));
               return;
            }
            for(_loc5_ in _loc4_.costItems)
            {
               if(!obf_K_e_3075.playerBagUI || obf_K_e_3075.playerBagUI.getEqualItemCount(_loc5_) < _loc4_.costItems[_loc5_])
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("HoleUI","error_NoMoreAid"));
                  return;
               }
            }
            obf_A_V_935.sendHole(this._equipBag.haveIconItem.itemId,this.equipInfo.equipmentInfo.holeNumber);
            cmdAction.enabled = false;
         }
         else if(this.action == this.obf_L_5_3704)
         {
            if(!obf_K_e_3075.playerBagUI.haveEmptyBag(1))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","nomoreEmptyBag"));
               return;
            }
            _loc6_ = GameItemManager.getItemConfig(this.selectedGemCode);
            if(!_loc6_)
            {
               return;
            }
            _loc7_ = obf_A_V_935.getDisembedCost(JSONUtil.getInt(_loc6_,["properties","gemLevel"]));
            if(!_loc7_ || obf_K_e_3075.playerBagUI.getItemCount(_loc7_.costItemCode) < JSONUtil.getInt(_loc7_,["costItemNum"]))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("DisembedUI","error_NoMoreAid"));
               return;
            }
            obf_A_V_935.sendDisembed(this._equipBag.haveIconItem.itemId,this.selectedGemIndex);
            cmdAction.enabled = false;
         }
      }
      
      private function confirmEmbed(param1:Object) : void
      {
         if(!param1.confirm)
         {
            return;
         }
         obf_A_V_935.sendEmbed(this._equipBag.haveIconItem.itemId,param1.par.itemIndex,param1.par.gemIndex);
      }
      
      private function setGemBags(param1:GameItemFullInfo) : void
      {
         var _loc6_:IconItemBag = null;
         var _loc7_:IconItemBagTips = null;
         var _loc8_:IconItem = null;
         if(!param1 || !param1.equipmentInfo || !this.equipInfo)
         {
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(param1.itemCode);
         var _loc3_:Object = obf_A_V_935.getHolePlan(JSONUtil.getStr(_loc2_,["properties","holePlanId"]));
         var _loc4_:int = JSONUtil.getInt(_loc3_,["maxHoleNumber"]);
         this.showGemBags = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < this.obf_m_o_2112.length)
         {
            _loc6_ = this.obf_m_o_2112[_loc5_];
            _loc6_.dropIconItem();
            _loc6_.obf_o_g_3238();
            _loc6_.visible = _loc5_ < _loc4_;
            _loc6_.isLocked = _loc5_ >= param1.equipmentInfo.holeNumber;
            if(_loc5_ < _loc4_)
            {
               this.showGemBags.push(_loc6_);
            }
            if(_loc5_ < param1.equipmentInfo.embedGemCodeList.length)
            {
               _loc8_ = IconItemManager.getIconItemByCode(param1.equipmentInfo.embedGemCodeList[_loc5_],"");
               if(_loc8_)
               {
                  _loc6_.pushIconItem(_loc8_);
               }
            }
            _loc7_ = new IconItemBagTips();
            if(!_loc6_.haveIconItem)
            {
               if(_loc6_.isLocked)
               {
                  DiversityManager.setTextField(_loc7_.txt,"EmbedBoxUI","gemPrompt_Hole",null,true);
               }
               else
               {
                  DiversityManager.setTextField(_loc7_.txt,"EmbedBoxUI","gemPrompt_Embed",null,true);
               }
            }
            _loc5_++;
         }
      }
      
      public function clearContent(param1:Boolean = false) : void
      {
         var _loc2_:IconItemBag = null;
         for each(_loc2_ in this.obf_m_o_2112)
         {
            _loc2_.visible = true;
            _loc2_.dropIconItem();
            _loc2_.obf_o_g_3238();
            _loc2_.isLocked = false;
         }
         if(param1)
         {
            this.equipInfo = null;
         }
         this.obf_A_m_3897.dropIconItem();
         this.action = "";
         cmdAction.enabled = true;
         cmdAction.visible = false;
      }
      
      public function obf_0_8_p_357() : void
      {
         this.action = "";
         cmdAction.visible = false;
         this.obf_A_m_3897.dropIconItem();
         txtChance.text = "";
      }
      
      public function getIconItemBags() : Array
      {
         return [].concat(this.showGemBags,this._equipBag,this.obf_A_m_3897);
      }
      
      public function showUI() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.clearContent();
         this._equipBag.dropIconItem();
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = false;
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         if(param1.isLocked)
         {
            this.selectHole();
         }
         else if(param1.haveIconItem)
         {
            this.selectDisembed(param1.haveIconItem.itemCode,param1.itemIndex);
         }
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1 || param3.parentIconUI != obf_K_e_3075.playerBagUI)
         {
            return;
         }
         if(param1 == this._equipBag && param2 is IconItemEquip)
         {
            this.pushEquipIn(param2 as IconItemEquip);
         }
         if(!param1.isLocked && this.obf_m_o_2112.indexOf(param1) > -1)
         {
            this.obf_m_C_3806(param2.itemCode,param3.itemIndex);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

