package obf_0_9_D_86
{
   import obf_x_O_4078.obf_1_t_884;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemCollection;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import playerUI.DevolveUIMC;
   
   public class DevolveUI extends DevolveUIMC implements IIconItemUI, IPlayerUI
   {
      
      private var _bags:Array;
      
      private var obf_B_N_3547:IconItemBag;
      
      private var obf_0_8_Q_578:IconItemBag;
      
      private var obf_A_m_3897:IconItemBag;
      
      private var cost:int;
      
      private var obf_Q_S_4113:Object;
      
      private var obf_a_k_2370:Array;
      
      private var equipSoulLevel:int;
      
      private var soulLevelConfig:Object;
      
      private var equipInfo:GameItemFullInfo;
      
      private var getEquipInfo:GameItemFullInfo;
      
      private var timeInv:TimeLimiter = new TimeLimiter(300);
      
      public function DevolveUI()
      {
         super();
         this.visible = false;
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         titleBox.mouseEnabled = false;
         this._bags = new Array();
         this.obf_B_N_3547 = new IconItemBag(obf_f_j_3137,this,0);
         this.obf_B_N_3547.addValidType(GameItemType.EQUIPMENT);
         this.obf_B_N_3547.isLocked = false;
         this._bags.push(this.obf_B_N_3547);
         this.obf_0_8_Q_578 = new IconItemBag(obf_V_p_2843,this,0);
         this.obf_0_8_Q_578.addValidType(GameItemType.EQUIPMENT);
         this.obf_0_8_Q_578.isLocked = false;
         this._bags.push(this.obf_0_8_Q_578);
         this.obf_A_m_3897 = new IconItemBag(obf_0_5_g_343,this,0);
         this.obf_A_m_3897.addValidType(GameItemType.COLLECTION);
         this.obf_A_m_3897.isLocked = true;
         this.obf_A_m_3897.lockDrag = false;
         this._bags.push(this.obf_A_m_3897);
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.underline = true;
         txtRemark.setTextFormat(_loc1_);
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdDevolve.addEventListener(MouseEvent.CLICK,this.obf_0_2_V_188);
         obf_K_e_3075.addUIMouseToolTip(txtRemark,"devolve");
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdDevolve.removeEventListener(MouseEvent.CLICK,this.obf_0_2_V_188);
         obf_K_e_3075.removeUIMouseToolTip(txtRemark);
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
         if(obf_K_e_3075.playerBagUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.playerBagUI);
         }
      }
      
      private function obf_0_2_V_188(param1:Event) : void
      {
         var _loc3_:String = null;
         if(!this.obf_0_8_Q_578.haveIconItem || !this.obf_B_N_3547.haveIconItem)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("DevolveUI","pushEqu"));
            return;
         }
         if(this.equipInfo.equipmentInfo.addSoulLevel < 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("DevolveUI","noSoulLevel"));
            return;
         }
         if(this.getEquipInfo.equipmentInfo.addSoulLevel > 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("DevolveUI","noSoul"));
            return;
         }
         if(this.cost > GameContext.localPlayer.fullInfo.gold)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("DevolveUI","noGold"));
            return;
         }
         var _loc2_:Object = GameItemManager.getItemConfig(this.obf_0_8_Q_578.haveIconItem.itemCode);
         if(!_loc2_)
         {
            return;
         }
         if(!JSONUtil.getBoolean(_loc2_,["properties","canRefine"]))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("DevolveUI","prompt_CantRefine"));
            return;
         }
         for(_loc3_ in this.obf_Q_S_4113)
         {
            if(obf_0_5_g_343[obf_0_5_g_343] > obf_K_e_3075.playerBagUI.getItemCount(_loc3_))
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("DevolveUI","noStuff"));
               return;
            }
         }
         obf_1_t_884.sendArtifactSoulMoveRequest(this.obf_0_8_Q_578.haveIconItem.itemId,this.obf_B_N_3547.haveIconItem.itemId);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(Boolean(!this.equipInfo) && Boolean(this.obf_B_N_3547.haveIconItem) && this.timeInv.checkTimeout())
         {
            this.obf_l_n_3275();
         }
         if(Boolean(!this.getEquipInfo) && Boolean(this.obf_0_8_Q_578.haveIconItem) && this.timeInv.checkTimeout())
         {
            this.getEquipInfo = GameItemInfoManager.getItemInfo(this.obf_0_8_Q_578.haveIconItem.itemId);
         }
         else if(this.obf_0_8_Q_578.haveIconItem)
         {
            GameContext.bagItemManager.sendViewItem(this.obf_0_8_Q_578.haveIconItem.itemId);
         }
      }
      
      private function obf_l_n_3275() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         if(!this.obf_B_N_3547.haveIconItem)
         {
            return;
         }
         this.equipInfo = GameItemInfoManager.getItemInfo(this.obf_B_N_3547.haveIconItem.itemId);
         if(this.equipInfo)
         {
            if(this.equipInfo.isEmpty)
            {
               return;
            }
            this.equipSoulLevel = this.equipInfo.equipmentInfo.addSoulLevel;
            this.obf_a_k_2370 = obf_1_t_884.getAddSoulConfig();
            this.obf_a_k_2370.sortOn("maxLv",Array.NUMERIC);
            for each(_loc2_ in this.obf_a_k_2370)
            {
               if(this.equipSoulLevel <= _loc2_["maxLv"])
               {
                  _loc1_ = _loc2_;
                  break;
               }
            }
            this.soulLevelConfig = _loc1_;
            if(this.obf_A_m_3897.haveIconItem)
            {
               this.obf_Q_S_4113 = JSONUtil.getObject(this.soulLevelConfig,["moveItems"]);
               this.obf_A_m_3897.haveIconItem.itemCount = this.obf_Q_S_4113[obf_1_t_884.getMoveItemCode()];
               if(this.obf_Q_S_4113[this.obf_A_m_3897.haveIconItem.itemCode] <= obf_K_e_3075.playerBagUI.getItemCount(this.obf_A_m_3897.haveIconItem.itemCode))
               {
                  this.obf_A_m_3897.haveIconItem.countTextColor = 16777215;
               }
               else
               {
                  this.obf_A_m_3897.haveIconItem.countTextColor = 16711680;
               }
            }
            while(pointCost.numChildren > 0)
            {
               pointCost.removeChildAt(0);
            }
            this.cost = JSONUtil.getNumber(this.soulLevelConfig,["moveGold"]);
            pointCost.addChild(obf_a_f_2935.getGoldDisplay(this.cost));
         }
         else
         {
            GameContext.bagItemManager.sendViewItem(this.obf_B_N_3547.haveIconItem.itemId);
         }
      }
      
      private function pushEquipIn(param1:IconItemEquip) : void
      {
         if(!param1)
         {
            return;
         }
         this.clearContent(true);
         this.obf_k_K_3759();
         this.obf_B_N_3547.pushIconItem(param1);
      }
      
      private function obf_k_K_3759() : void
      {
         var _loc1_:IconItemCollection = IconItemCollection.getNewIconItem(obf_1_t_884.getMoveItemCode(),"");
         if(!_loc1_)
         {
            return;
         }
         this.obf_A_m_3897.isLocked = false;
         this.obf_A_m_3897.dropIconItem();
         this.obf_A_m_3897.pushIconItem(_loc1_);
      }
      
      public function clearContent(param1:Boolean = false) : void
      {
         if(param1)
         {
            this.obf_B_N_3547.dropIconItem();
            this.obf_0_8_Q_578.dropIconItem();
         }
         this.equipInfo = null;
         this.getEquipInfo = null;
         this.obf_A_m_3897.isLocked = true;
         this.obf_A_m_3897.dropIconItem();
         while(pointCost.numChildren > 0)
         {
            pointCost.removeChildAt(0);
         }
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
         if(!param1 || param3.parentIconUI != obf_K_e_3075.playerBagUI)
         {
            return;
         }
         if(param1.isLocked)
         {
            return;
         }
         if(param1 == this.obf_B_N_3547 && param2 is IconItemEquip)
         {
            this.pushEquipIn(param2 as IconItemEquip);
         }
         else if(param1 == this.obf_0_8_Q_578)
         {
            this.getEquipInfo = null;
            param1.dropIconItem();
            param1.pushIconItem(param2);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(param1 == this.obf_B_N_3547)
         {
            this.clearContent(true);
         }
         if(param1 == this.obf_0_8_Q_578)
         {
            this.getEquipInfo = null;
            this.obf_0_8_Q_578.dropIconItem();
         }
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
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"DevolveUI","txtTitle");
         txtRemark.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("DevolveUI","txtRemark") + "</a>";
         cmdDevolve.label = DiversityManager.getString("DevolveUI","cmdDevolve");
         DiversityManager.setTextField(txtDeyCost,"DevolveUI","txtDeyCost");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.clearContent(true);
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this._bags)
         {
            _loc1_.destroy();
         }
      }
   }
}

