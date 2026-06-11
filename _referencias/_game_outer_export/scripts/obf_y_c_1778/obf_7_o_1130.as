package obf_y_c_1778
{
   import com.sunweb.game.rpg.animal.AnimalAttributesInfo;
   import com.sunweb.game.rpg.animal.AnimalInfo;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.netRole.obf_1_R_3404;
   import com.sunweb.game.rpg.netRole.obf_9_c_4534;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.world.obf_2_V_3982;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_A_x_3023;
   import flash.display.MovieClip;
   import flash.events.Event;
   import playerUI.RemoteAnimalUIMC;
   
   public class obf_7_o_1130 extends RemoteAnimalUIMC implements IIconItemUI
   {
      
      private var skillBar:Array;
      
      private var animalImage:obf_9_c_4534;
      
      private var defSkillBag:IconItemBag;
      
      private var petImageActiveTimeInv:TimeLimiter;
      
      public function obf_7_o_1130()
      {
         var _loc2_:MovieClip = null;
         var _loc3_:IconItemBag = null;
         this.petImageActiveTimeInv = new TimeLimiter(2000);
         super();
         this.visible = false;
         this.initDiversity();
         this.defSkillBag = new IconItemBag(barDefSkill,this,0);
         this.defSkillBag.addValidType(GameItemType.SKILL);
         this.defSkillBag.lockDrag = true;
         this.skillBar = new Array();
         var _loc1_:int = 1;
         while(_loc1_ < 7)
         {
            _loc2_ = this["animalSkill" + _loc1_];
            if(_loc2_)
            {
               _loc3_ = new IconItemBag(_loc2_,this,_loc1_);
               _loc3_.addValidType(GameItemType.SKILL);
               _loc3_.lockDrag = true;
               this.skillBar.push(_loc3_);
            }
            _loc1_++;
         }
      }
      
      public function updataBaseAnimal(param1:AnimalInfo, param2:int) : void
      {
         this.obf_7_D_4402();
         if(!param1)
         {
            return;
         }
         txtName.text = obf_2_V_3982.getTrianerName(param1.animalCode);
         txtName.textColor = obf_1_R_3404.getColor(param1.level);
         txtLv.text = param1.level + "";
         this.defSkillBag.pushIconItem(IconItemSkill.getNewIconItem(obf_2_V_3982.getTrianerDefSkillCode(param1.animalCode),1));
         var _loc3_:String = obf_2_V_3982.getTrianerMode(param1.animalCode);
         this.animalImage = new obf_9_c_4534(_loc3_,param1);
         this.animalImage.x = 0;
         animalPonit.addChild(this.animalImage);
         this.updataAttrAnimal(param1.animalAtr,param2);
      }
      
      private function obf_0_4_O_703() : void
      {
         while(animalPonit.numChildren > 0)
         {
            animalPonit.removeChildAt(0);
         }
         if(this.animalImage)
         {
            this.animalImage.destroy();
         }
         this.animalImage = null;
      }
      
      private function updataAttrAnimal(param1:AnimalAttributesInfo, param2:int) : void
      {
         var _loc4_:IconItemSkill = null;
         if(!param1)
         {
            return;
         }
         txtHp.text = param1.hp + "/" + param1.hpMax;
         txtPhysicalAttack.text = param1.physicalAttack + "";
         txtMagicAttack.text = param1.magicAttack + "";
         txtPhysicalDefense.text = param1.physicalDefense + "(" + obf_A_x_3023.getRateString(param1.physicalReduceRate) + ")";
         txtMagicDefense.text = param1.magicDefense + "(" + obf_A_x_3023.getRateString(param1.magicReduceRate) + ")";
         txtAccuracy.text = param1.hitValue + "(+" + obf_A_x_3023.getRateString(param1.hitRate - 1) + ")";
         txtDodge.text = param1.dodgeValue + "(" + obf_A_x_3023.getRateString(param1.dodgeRate) + ")";
         txtCrit.text = param1.critValue + "(" + obf_A_x_3023.getRateString(param1.critRate) + ")";
         txtCritDamage.text = obf_A_x_3023.getRateString(param1.critDamageMul);
         txtAttackSpeed.text = obf_A_x_3023.getRateString(1 / param1.castTimeModifier);
         txtSingSpeed.text = obf_A_x_3023.getRateString(1 / param1.singTimeModifier);
         txtSpeed.text = param2 + "";
         txtStrength.text = param1.strength + "";
         txtAgility.text = param1.agility + "";
         txtIntellect.text = param1.wisdom + "";
         txtStamina.text = param1.vitality + "";
         if(!param1.skillArray)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.skillArray.length)
         {
            _loc4_ = IconItemSkill.getNewIconItem(param1.skillArray[_loc3_],1);
            if(_loc3_ < this.skillBar.length)
            {
               if(_loc4_)
               {
                  (this.skillBar[_loc3_] as IconItemBag).pushIconItem(_loc4_);
               }
            }
            _loc3_++;
         }
      }
      
      private function obf_L_t_4155() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.skillBar)
         {
            _loc1_.dropIconItem();
         }
      }
      
      private function obf_7_D_4402() : void
      {
         txtName.text = "";
         txtLv.text = "";
         txtStrength.text = "";
         txtAgility.text = "";
         txtIntellect.text = "";
         txtStamina.text = "";
         this.obf_0_4_O_703();
         txtHp.text = "";
         txtPhysicalAttack.text = "";
         txtMagicAttack.text = "";
         txtPhysicalDefense.text = "";
         txtMagicDefense.text = "";
         txtAccuracy.text = "";
         txtDodge.text = "";
         txtCrit.text = "";
         txtCritDamage.text = "";
         txtAttackSpeed.text = "";
         txtSingSpeed.text = "";
         txtSpeed.text = "";
         this.defSkillBag.dropIconItem();
         this.obf_L_t_4155();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(Boolean(this.animalImage) && this.petImageActiveTimeInv.checkTimeout())
         {
            this.animalImage.onUpdate();
            this.animalImage.doAction(obf_S_c_3330.obf_h_4_3537,Math.random() * 8,true);
         }
      }
      
      public function getIconItemBags() : Array
      {
         return this.skillBar.concat(this.defSkillBag);
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
         DiversityManager.setTextField(txtDeyStrength,"animalUI","txtStrength");
         DiversityManager.setTextField(txtDeyAgility,"animalUI","txtAgility");
         DiversityManager.setTextField(txtDeyIntellect,"animalUI","txtIntellect");
         DiversityManager.setTextField(txtDeyStamina,"animalUI","txtStamina");
         DiversityManager.setTextField(txtDeyName,"animalUI","txtDeyName");
         DiversityManager.setTextField(txtDeyLv,"animalUI","txtDeyLv");
         DiversityManager.setTextField(txtDeyAttarr,"animalUI","txtDeyAttarr");
         DiversityManager.setTextField(txtDeyHp,"animalUI","txtDeyHp");
         DiversityManager.setTextField(txtDeyPhysicalAttack,"animalUI","txtDeyPhysicalAttack");
         DiversityManager.setTextField(txtDeyPhysicalDefense,"animalUI","txtDeyPhysicalDefense");
         DiversityManager.setTextField(txtDeyAccuracy,"animalUI","txtDeyAccuracy");
         DiversityManager.setTextField(txtDeyDodge,"animalUI","txtDeyDodge");
         DiversityManager.setTextField(txtDeyCritDamage,"animalUI","txtDeyCritDamage");
         DiversityManager.setTextField(txtDeyAttackSpeed,"animalUI","txtDeyAttackSpeed");
         DiversityManager.setTextField(txtDeyMagicAttack,"animalUI","txtDeyMagicAttack");
         DiversityManager.setTextField(txtDeyMagicDefense,"animalUI","txtDeyMagicDefense");
         DiversityManager.setTextField(txtDeyCrit,"animalUI","txtDeyCrit");
         DiversityManager.setTextField(txtDeySingSpeed,"animalUI","txtDeySingSpeed");
         DiversityManager.setTextField(txtDeySkill,"animalUI","txtDeySkill");
         DiversityManager.setTextField(txtDeyPetDefSkill,"animalUI","txtDeyPetDefSkill");
         DiversityManager.setTextField(txtDeySpeed,"animalUI","txtDeySpeed");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         this.obf_7_D_4402();
      }
   }
}

