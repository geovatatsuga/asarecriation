package obf_y_c_1778
{
   import com.sunweb.game.rpg.constellation.obf_H_B_2569;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.gameItem.GameItemBriefInfo;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemEquip;
   import com.sunweb.game.rpg.iconItem.IconItemRide;
   import com.sunweb.game.rpg.netRole.obf_Y_E_3667;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.RemotePlayerViewInfo;
   import com.sunweb.game.rpg.role.obf_I_5_1944;
   import com.sunweb.game.rpg.role.action.obf_D_0_1300;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_A_x_3023;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import playerUI.RemoteViewUIMC;
   
   public class obf_0_5_K_355 extends RemoteViewUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var bagKind:Object;
      
      private var _player:obf_Y_E_3667;
      
      private var rideBag:IconItemBag;
      
      private var bagNames:Array;
      
      private var timeInv:TimeLimiter;
      
      public function obf_0_5_K_355()
      {
         var _loc1_:IconItemBag = null;
         this.timeInv = new TimeLimiter(500);
         super();
         this.visible = false;
         this.initDiversity();
         this.bags = new Array();
         this.bagKind = new Object();
         this.bagNames = [[bagWeapon,EquipmentKind.WEAPON],[bagShield,EquipmentKind.SHIELD],[bagClothes,EquipmentKind.CLOTHES],[bagHat,EquipmentKind.HAT],[bagWing,EquipmentKind.WING],[bagShoes,EquipmentKind.SHOES],[bagGlove,EquipmentKind.GLOVE],[bagRing,EquipmentKind.RING],[bagAmulet,EquipmentKind.AMULET],[bagMedal,EquipmentKind.obf_s_Y_1219],[bagSoul,EquipmentKind.obf_m_S_4609],[bagFashionClothes,EquipmentKind.FASHION_CLOTHES],[bagFashionHat,EquipmentKind.FASHION_HAT],[bagBanner,EquipmentKind.obf_8_L_1856],[bagCloak,EquipmentKind.obf_i_3_4546]];
         var _loc2_:int = 0;
         while(_loc2_ < this.bagNames.length)
         {
            _loc1_ = new IconItemBag(this.bagNames[_loc2_][0],this,_loc2_,this.bagNames[_loc2_][1] + "");
            _loc1_.addValidType(GameItemType.EQUIPMENT);
            _loc1_.lockDrag = true;
            this.bags.push(_loc1_);
            this.bagKind[this.bagNames[_loc2_][1] + ""] = _loc1_;
            _loc2_++;
         }
         this.rideBag = new IconItemBag(this.bagRide,this,0);
         this.rideBag.addValidType(GameItemType.RIDE);
         this.rideBag.lockDrag = true;
         this.bags.push(this.rideBag);
         this.addListener();
      }
      
      public function updataRemoteViewUI(param1:RemotePlayerViewInfo) : void
      {
         var _loc2_:IconItemBag = null;
         var _loc3_:int = 0;
         var _loc4_:GameItemBriefInfo = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Object = null;
         var _loc7_:IconItemBag = null;
         var _loc8_:IconItemRide = null;
         if(!param1)
         {
            return;
         }
         this.clear();
         for each(_loc2_ in this.bags)
         {
            _loc2_.dropIconItem();
         }
         _loc3_ = 0;
         while(_loc3_ < this.bagNames.length)
         {
            _loc5_ = this.bagNames[_loc3_][0] as MovieClip;
            if(_loc5_)
            {
               _loc5_.alpha = 0.6;
            }
            _loc3_++;
         }
         this.rideBag.bagMC.alpha = 0.6;
         for each(_loc4_ in param1.equipments)
         {
            _loc6_ = GameItemManager.getItemConfig(_loc4_.itemCode);
            if(_loc6_)
            {
               _loc7_ = this.bagKind[_loc6_.properties.kind];
               if(_loc7_)
               {
                  _loc7_.pushIconItem(IconItemEquip.getNewIconItem(_loc4_.itemCode,_loc4_.itemId));
                  _loc7_.bagMC.alpha = 1;
               }
            }
         }
         if(param1.usingRide)
         {
            _loc8_ = IconItemRide.getNewIconItem(param1.usingRide.rideCode,param1.usingRide.rideId);
            if(_loc8_)
            {
               this.rideBag.pushIconItem(_loc8_);
               this.rideBag.bagMC.alpha = 1;
            }
         }
         obf_K_e_3075.obf_u_p_3828.txtTitle = param1.name;
         txtLevel.text = param1.level + "";
         txtConstellation.text = obf_H_B_2569.getGodTypeName(param1.constellation);
         if(param1.pet)
         {
            txtPet.htmlText = obf_7_6_4416.getItemLinkA(param1.pet.petCode,param1.pet.petId);
         }
         txtJob.text = obf_I_5_1944.getJobShowName(param1.jobCode);
         txtGild.text = param1.familyName;
         txtMate.htmlText = !obf_L_l_4100.isEmpty(param1.mateName) ? obf_7_6_4416.getRoleLinkA(param1.mateName) : "";
         DiversityManager.setTextField(txtState,"PlayerReborn",param1.rebornTimes + "",null,true);
         txtRank.text = JSONUtil.getStr(NumberConfig.getSettingObject("honorLevelNames"),[param1.honorLevel]);
         txtPrestige.text = param1.honorValue + "";
         txtPK.text = param1.pkValue + "";
         txtHp.text = param1.attributes.hp + "/" + param1.attributes.hpMax;
         txtMp.text = param1.attributes.mp + "/" + param1.attributes.mpMax;
         txtSp.text = param1.attributes.sp + "/" + param1.attributes.spMax;
         txtStrength.text = param1.attributes.strength + "";
         txtAgility.text = param1.attributes.agility + "";
         txtIntellect.text = param1.attributes.wisdom + "";
         txtStamina.text = param1.attributes.vitality + "";
         txtPhysicalAttack.text = param1.attributes.physicalAttack + "";
         txtMagicAttack.text = param1.attributes.magicAttack + "";
         txtCure.text = param1.attributes.cureValue + "";
         txtPhysicalDefense.text = param1.attributes.physicalDefense + "(" + obf_A_x_3023.getRateString(param1.attributes.physicalReduceRate) + ")";
         txtMagicDefense.text = param1.attributes.magicDefense + "(" + obf_A_x_3023.getRateString(param1.attributes.magicReduceRate) + ")";
         txtAccuracy.text = param1.attributes.hitValue + "(+" + obf_A_x_3023.getRateString(param1.attributes.hitRate - 1) + ")";
         txtDodge.text = param1.attributes.dodgeValue + "(" + obf_A_x_3023.getRateString(param1.attributes.dodgeRate) + ")";
         txtCrit.text = param1.attributes.critValue + "(" + obf_A_x_3023.getRateString(param1.attributes.critRate) + ")";
         if(this._player)
         {
            this._player.destroy();
         }
         this._player = new obf_Y_E_3667(param1.jobCode,param1.sex,param1.hairStyleIndex);
         this._player.moveToPixel(0,0);
         this._player.setEquipmentModels(param1.equipmentModels);
         this._player.doAction(obf_S_c_3330.obf_h_4_3537,obf_D_0_1300.DOWN,true);
         while(obf_3_817.numChildren > 0)
         {
            obf_3_817.removeChildAt(0);
         }
         obf_3_817.addChild(this._player);
      }
      
      private function clear() : void
      {
         txtConstellation.text = "";
         txtLevel.text = "";
         txtPet.text = "";
         txtJob.text = "";
         txtState.text = "";
         txtRank.text = "";
         txtPrestige.text = "";
         txtGild.text = "";
         txtMate.text = "";
         txtPK.text = "";
         txtHp.text = "";
         txtMp.text = "";
         txtSp.text = "";
         txtStrength.text = "";
         txtAgility.text = "";
         txtIntellect.text = "";
         txtStamina.text = "";
         txtPhysicalAttack.text = "";
         txtMagicAttack.text = "";
         txtCure.text = "";
         txtPhysicalDefense.text = "";
         txtMagicDefense.text = "";
         txtAccuracy.text = "";
         txtDodge.text = "";
         txtCrit.text = "";
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyEquipSoul,"RoleUI","txtSoul");
         DiversityManager.setTextField(txtDeyEquipAmulet,"RoleUI","txtAmulet");
         DiversityManager.setTextField(txtDeyEquipRing,"RoleUI","txtRing");
         DiversityManager.setTextField(txtDeyEquipWing,"RoleUI","txtWing");
         DiversityManager.setTextField(txtDeyEquipMedal,"RoleUI","txtMedal");
         DiversityManager.setTextField(txtDeyEquipRide,"RoleUI","txtRide");
         DiversityManager.setTextField(txtDeyEquipHat,"RoleUI","txtHat");
         DiversityManager.setTextField(txtDeyEquipWeapon,"RoleUI","txtWeapon");
         DiversityManager.setTextField(txtDeyEquipShield,"RoleUI","txtShield");
         DiversityManager.setTextField(txtDeyEquipClothes,"RoleUI","txtClothes");
         DiversityManager.setTextField(txtDeyEquipGlove,"RoleUI","txtGlove");
         DiversityManager.setTextField(txtDeyEquipShoes,"RoleUI","txtShoes");
         DiversityManager.setTextField(txtDeyEquipFashionClothes,"RoleUI","txtFashionClothes");
         DiversityManager.setTextField(txtDeyEquipFashionHat,"RoleUI","txtFashionHat");
         DiversityManager.setTextField(txtDeyEquipBanner,"RoleUI","txtBanner");
         DiversityManager.setTextField(txtDeyEquipCloak,"RoleUI","txtCloak");
         DiversityManager.setTextField(txtDeyConstellation,"RoleUI","txtConstellation");
         DiversityManager.setTextField(txtDeyLevel,"RoleUI","txtLevel");
         DiversityManager.setTextField(txtDeyPet,"RoleUI","txtPet");
         DiversityManager.setTextField(txtDeyJob,"RoleUI","txtJob");
         DiversityManager.setTextField(txtDeyState,"RoleUI","txtState");
         DiversityManager.setTextField(txtDeyRank,"RoleUI","txtRank");
         DiversityManager.setTextField(txtDeyPrestige,"RoleUI","txtPrestige");
         DiversityManager.setTextField(txtDeyGild,"RoleUI","txtGild");
         DiversityManager.setTextField(txtDeyMate,"RoleUI","txtMate");
         DiversityManager.setTextField(txtDeyPK,"RoleUI","txtPK");
         DiversityManager.setTextField(txtDeyHp,"RoleUI","txtHP");
         DiversityManager.setTextField(txtDeyMp,"RoleUI","txtMP");
         DiversityManager.setTextField(txtDeySp,"RoleUI","txtSP");
         DiversityManager.setTextField(txtDeyStrength,"RoleUI","txtStrength");
         DiversityManager.setTextField(txtDeyAgility,"RoleUI","txtAgility");
         DiversityManager.setTextField(txtDeyIntellect,"RoleUI","txtIntellect");
         DiversityManager.setTextField(txtDeyStamina,"RoleUI","txtStamina");
         DiversityManager.setTextField(txtDeyPhysicalAttack,"RoleUI","txtPhysicalAttack");
         DiversityManager.setTextField(txtDeyMagicAttack,"RoleUI","txtMagicAttack");
         DiversityManager.setTextField(txtDeyCure,"RoleUI","txtCure");
         DiversityManager.setTextField(txtDeyPhysicalDefense,"RoleUI","txtPhysicalDefense");
         DiversityManager.setTextField(txtDeyMagicDefense,"RoleUI","txtMagicDefense");
         DiversityManager.setTextField(txtDeyAccuracy,"RoleUI","txtAccuracy");
         DiversityManager.setTextField(txtDeyDodge,"RoleUI","txtDodge");
         DiversityManager.setTextField(txtDeyCrit,"RoleUI","txtCrit");
         DiversityManager.setTextField(txtDeyArena,"RoleUI","");
      }
      
      private function addListener() : void
      {
         txtMate.addEventListener(TextEvent.LINK,this.onClickLink);
         txtPet.addEventListener(TextEvent.LINK,this.onClickLink);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function removeListener() : void
      {
         txtMate.removeEventListener(TextEvent.LINK,this.onClickLink);
         txtPet.removeEventListener(TextEvent.LINK,this.onClickLink);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
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
         if(Boolean(this._player) && this.timeInv.checkTimeout())
         {
            this._player.obf_A_j_2560();
         }
      }
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
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
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.bags)
         {
            _loc1_.destroy();
         }
         this.removeListener();
         if(this._player)
         {
            this._player.destroy();
         }
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         if(param3)
         {
            obf_K_e_3075.obf_e_q_2572.addItemLink(param1.haveIconItem.itemCode,param1.haveIconItem.itemId,param1.haveIconItem.itemName,GameItemRank.getRankColor(param1.haveIconItem.iconItemRank));
         }
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

