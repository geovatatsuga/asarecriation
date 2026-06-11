package obf_V_n_3191
{
   import obf_x_O_4078.obf_A_V_935;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.equ.EquipmentManager;
   import com.sunweb.game.rpg.equ.obf_y_a_2168;
   import com.sunweb.game.rpg.gameItem.GameItemFullInfo;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_0_M_3913;
   import com.sunweb.game.rpg.role.obf_E_k_1445;
   import com.sunweb.game.rpg.role.action.obf_D_0_1300;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.ArtifaceUpgradeUIMC;
   
   public class ArtifactUpgradeUI extends ArtifaceUpgradeUIMC implements IIconItemUI, obf_0_d_4341
   {
      
      private var bags:Array;
      
      private var obf_4_O_4355:IconItemBag;
      
      private var obf_o_X_2799:IconItemBag;
      
      private var obf_0_2_f_172:Array;
      
      private var obf_0___T_461:GameItemFullInfo;
      
      private var viewPlayer:obf_0_M_3913;
      
      private var _noviceSprite:Sprite;
      
      private var playerViewActionTimeInv:TimeLimiter;
      
      private var timeInv:TimeLimiter;
      
      private var obf_f_J_4627:TimeLimiter;
      
      public function ArtifactUpgradeUI()
      {
         var _loc2_:MovieClip = null;
         var _loc3_:IconItemBag = null;
         this.playerViewActionTimeInv = new TimeLimiter(4000);
         this.timeInv = new TimeLimiter(500);
         super();
         this.initDiversity();
         this.bags = new Array();
         this.obf_4_O_4355 = new IconItemBag(bagUpgradeArtifact,this,0);
         this.obf_4_O_4355.addValidType(GameItemType.EQUIPMENT);
         this.bags.push(this.obf_4_O_4355);
         this.obf_o_X_2799 = new IconItemBag(bagArtifactUpgraded,this,0);
         this.obf_o_X_2799.addValidType(GameItemType.ALL);
         this.obf_o_X_2799.lockDrag = true;
         this.bags.push(this.obf_o_X_2799);
         this.obf_0_2_f_172 = new Array();
         var _loc1_:int = 0;
         while(_loc1_ <= 5)
         {
            _loc2_ = this["bagUpgrade" + _loc1_];
            if(_loc2_)
            {
               _loc3_ = new IconItemBag(_loc2_,this,_loc1_);
               _loc3_.addValidType(GameItemType.ALL);
               _loc3_.lockDrag = true;
               this.obf_0_2_f_172.push(_loc3_);
               this.bags.push(_loc3_);
            }
            _loc1_++;
         }
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyPushUpgrade,"ArtifactUpgradeUI","txtPushUpgrade");
         DiversityManager.setTextField(txtDeyArtifactUpgraded,"ArtifactUpgradeUI","txtArtifactUpgraded");
         DiversityManager.setTextField(txtDeyPlayerView,"ArtifactUpgradeUI","txtPlayerView");
         DiversityManager.setTextField(txtDeyUpgrade,"ArtifactUpgradeUI","txtUpgrade");
         DiversityManager.setTextField(txtNeedRefine,"ArtifactUpgradeUI","txtNeedRefine",[""]);
         DiversityManager.setTextField(txtUpgradeChance,"ArtifactUpgradeUI","txtUpgradeChance",[""]);
         DiversityManager.setTextField(txtRemark,"ArtifactUpgradeUI","txtRemark");
         cmdArtifactUpgrade.label = DiversityManager.getString("ArtifactUpgradeUI","cmdArtifactUpgrade");
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
         return "ArtifactUpgradeUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         var _loc2_:DisplayObject = this.getChildByName(param1);
         if(!_loc2_)
         {
            return null;
         }
         return this.globalToLocal(_loc2_.localToGlobal(new Point(16,16)));
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         return this.getChildByName(param1);
      }
      
      private function addListener() : void
      {
         cmdArtifactUpgrade.addEventListener(MouseEvent.CLICK,this.obf_Z_v_1153);
      }
      
      private function removeListener() : void
      {
         cmdArtifactUpgrade.removeEventListener(MouseEvent.CLICK,this.obf_Z_v_1153);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(Boolean(this.viewPlayer) && this.playerViewActionTimeInv.checkTimeout())
         {
            this.viewPlayer.doAction(obf_S_c_3330.obf_h_4_3537,int(Math.random() * 9) - 1,true);
         }
         if(this.timeInv.checkTimeout())
         {
            if(!this.obf_0___T_461 && Boolean(this.obf_4_O_4355.haveIconItem))
            {
               this.obf_a_M_2920();
            }
         }
         if(Boolean(this.obf_f_J_4627) && this.obf_f_J_4627.checkTimeout())
         {
            cmdArtifactUpgrade.enabled = true;
            this.obf_f_J_4627 = null;
         }
      }
      
      private function obf_Z_v_1153(param1:Event) : void
      {
         if(!this.obf_0___T_461)
         {
            return;
         }
         if(!obf_y_a_2168.equipmentCanUpgrade(this.obf_0___T_461))
         {
            return;
         }
         var _loc2_:IconItemBag = obf_K_e_3075.playerFullInfoUI.getEquipBagByKind(EquipmentKind.WEAPON);
         if(Boolean(_loc2_.haveIconItem) && this.obf_0___T_461.itemId == _loc2_.haveIconItem.itemId)
         {
            EquipmentManager.sendRemoveEquip(EquipmentKind.WEAPON,-1);
         }
         obf_A_V_935.sendEquipmentUpgrade(this.obf_0___T_461.itemId,[]);
         this.obf_f_J_4627 = new TimeLimiter(1000);
         cmdArtifactUpgrade.enabled = false;
      }
      
      private function obf_X_l_842() : void
      {
         var _loc2_:String = null;
         if(this.viewPlayer)
         {
            pointPlayerView.removeChild(this.viewPlayer);
            this.viewPlayer.destroy();
         }
         this.viewPlayer = new obf_0_M_3913(GameContext.localPlayer.playerModelCode);
         this.viewPlayer.id = "_&ArtifactView&_";
         this.viewPlayer.setDefaultEquipmentModel(obf_E_k_1445.HAT,GameContext.localPlayer.getDefaultEquipmentModel(obf_E_k_1445.HAT));
         var _loc1_:Array = [obf_E_k_1445.HAT,obf_E_k_1445.WEAPON,obf_E_k_1445.SHIELD,obf_E_k_1445.WING,obf_E_k_1445.CLOTHES];
         for each(_loc2_ in _loc1_)
         {
            this.viewPlayer.setUsingEquipmentModel(_loc2_,GameContext.localPlayer.getUsingEquipmentModel(_loc2_));
         }
         pointPlayerView.addChild(this.viewPlayer);
         this.viewPlayer.moveToPixel(0,0);
         this.viewPlayer.doAction(obf_S_c_3330.obf_h_4_3537,obf_D_0_1300.DOWN,true);
         this.viewPlayer.obf_A_j_2560();
      }
      
      public function autoPushArtifactUpgrade() : void
      {
         var _loc3_:String = null;
         var _loc4_:IconItemBag = null;
         var _loc1_:Array = obf_y_a_2168.getUpgradeEquipmentList();
         var _loc2_:IconItemBag = obf_K_e_3075.playerFullInfoUI.getEquipBagByKind(EquipmentKind.WEAPON);
         if(Boolean(_loc2_.haveIconItem) && _loc1_.indexOf(_loc2_.haveIconItem.itemCode) > -1)
         {
            this.obf_4_O_4355.dropIconItem();
            this.obf_4_O_4355.pushIconItem(_loc2_.haveIconItem.clone());
            this.obf_a_M_2920();
            return;
         }
         for each(_loc3_ in _loc1_)
         {
            _loc4_ = obf_K_e_3075.playerBagUI.getIconItemBagByCode(_loc3_);
            if((Boolean(_loc4_)) && Boolean(_loc4_.haveIconItem))
            {
               this.obf_4_O_4355.dropIconItem();
               this.obf_4_O_4355.pushIconItem(_loc4_.haveIconItem.clone());
               this.obf_a_M_2920();
               return;
            }
         }
      }
      
      public function obf_a_M_2920() : void
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:IconItem = null;
         var _loc10_:IconItemBag = null;
         if(!this.obf_4_O_4355.haveIconItem)
         {
            return;
         }
         this.obf_8_Q_3889(true);
         this.obf_0___T_461 = GameItemInfoManager.getItemInfo(this.obf_4_O_4355.haveIconItem.itemId);
         if(!this.obf_0___T_461)
         {
            GameContext.bagItemManager.sendViewItem(this.obf_4_O_4355.haveIconItem.itemId);
            return;
         }
         var _loc1_:Object = obf_y_a_2168.getUpgradeConfig(this.obf_4_O_4355.haveIconItem.itemCode);
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:IconItem = IconItemManager.getIconItemByCode(_loc1_.equItemUpgrade,"");
         if(!_loc2_)
         {
            return;
         }
         this.obf_o_X_2799.pushIconItem(_loc2_);
         this.obf_X_l_842();
         if(Boolean(this.viewPlayer) && GameItemManager.getEquipItemModelCode(_loc1_.equItemUpgrade) != "")
         {
            _loc4_ = GameItemManager.getEquipItemModelCode(_loc1_.equItemUpgrade).split(",");
            for each(_loc5_ in _loc4_)
            {
               _loc6_ = obf_E_k_1445.getEquipmentModelKind(_loc5_);
               this.viewPlayer.setUsingEquipmentModel(_loc6_,_loc5_);
            }
            this.viewPlayer.obf_A_j_2560();
         }
         DiversityManager.setTextField(txtNeedRefine,"ArtifactUpgradeUI","txtNeedRefine",["+" + _loc1_.costRefineLevel]);
         var _loc3_:Object = JSONUtil.getObject(_loc1_,["condition","equalItemsInBag"]);
         if(_loc3_)
         {
            _loc7_ = 0;
            for(_loc8_ in _loc3_)
            {
               if(_loc7_ >= this.obf_0_2_f_172.length)
               {
                  break;
               }
               _loc9_ = IconItemManager.getIconItemByCode(_loc8_,"");
               _loc9_.itemCount = _loc3_[_loc8_];
               _loc10_ = this.obf_0_2_f_172[_loc7_];
               _loc10_.pushIconItem(_loc9_);
               _loc7_++;
            }
         }
         DiversityManager.setTextField(txtUpgradeChance,"ArtifactUpgradeUI","txtUpgradeChance",[int(JSONUtil.getNumber(_loc1_,["baseChance"],1) * 100)]);
      }
      
      public function obf_8_Q_3889(param1:Boolean = false) : void
      {
         var _loc2_:IconItemBag = null;
         this.obf_0___T_461 = null;
         if(!param1)
         {
            this.obf_4_O_4355.dropIconItem();
         }
         this.obf_o_X_2799.dropIconItem();
         for each(_loc2_ in this.obf_0_2_f_172)
         {
            _loc2_.dropIconItem();
         }
         txtUpgradeChance.text = "";
         DiversityManager.setTextField(txtNeedRefine,"ArtifactUpgradeUI","txtNeedRefine",[""]);
         if(this.viewPlayer)
         {
            pointPlayerView.removeChild(this.viewPlayer);
            this.viewPlayer.destroy();
         }
         this.viewPlayer = null;
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
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.autoPushArtifactUpgrade();
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.obf_8_Q_3889();
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
         if(param1 == this.obf_4_O_4355)
         {
            this.obf_8_Q_3889();
            this.obf_4_O_4355.pushIconItem(param2);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(param1 == this.obf_4_O_4355)
         {
            this.obf_8_Q_3889();
         }
      }
   }
}

