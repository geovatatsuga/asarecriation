package com.sunweb.game.rpg.playerUI.pet
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.gameItem.obf_x_c_2855;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.netRole.obf_t_T_3981;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.action.obf_D_0_1300;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.sound.obf_q_6_3634;
   import com.sunweb.game.rpg.worldZone.command.npc.NpcAssembleItemAnswer;
   import com.sunweb.game.util.TimeLimiter;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.PetAssembleBoxUIMC;
   
   public class obf_O_U_751 extends PetAssembleBoxUIMC implements IIconItemUI
   {
      
      private var petBag:IconItemBag;
      
      private var targetPetBag:IconItemBag;
      
      private var materialBag:IconItemBag;
      
      private var obf_Z_X_1425:String;
      
      private var obf_f_7_1060:String;
      
      private var currentPetAssembleConfig:Object;
      
      private var obf_y_G_2458:obf_t_T_3981;
      
      private var targetAiPet:obf_t_T_3981;
      
      private var obf_M_C_3926:TimeLimiter = new TimeLimiter(1000);
      
      public function obf_O_U_751()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth - 300;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         txtChanse.visible = false;
         pointPetImage.mouseEnabled = false;
         pointTargetPetImage.mouseEnabled = false;
         this.petBag = new IconItemBag(petBagMC,this,0);
         this.petBag.lockDrag = true;
         this.petBag.addValidType(GameItemType.PET);
         this.targetPetBag = new IconItemBag(targetPetBagMC,this,0);
         this.targetPetBag.lockDrag = true;
         this.targetPetBag.addValidType(GameItemType.PET);
         this.materialBag = new IconItemBag(materialBagMC,this,0);
         this.materialBag.lockDrag = true;
         this.materialBag.addValidType(GameItemType.ALL);
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"PetAssembleUI","txtTitle");
         DiversityManager.setTextField(txtPetImage,"PetAssembleUI","txtPetImage");
         DiversityManager.setTextField(txtTargetPetImage,"PetAssembleUI","txtTargetImage");
         DiversityManager.setTextField(txtDeyMaterial,"PetAssembleUI","txtMaterial");
         DiversityManager.setTextField(txtDeyPrompt,"PetAssembleUI","txtPrompt");
         cmdAssPet.label = DiversityManager.getString("PetAssembleUI","cmdAssemblePet");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         closeButton.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdAssPet.addEventListener(MouseEvent.CLICK,this.obf_W_j_2205);
         obf_K_e_3075.addUIMouseToolTip(obf_Q_0_1896,"Luck_StarPrompt");
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         closeButton.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdAssPet.removeEventListener(MouseEvent.CLICK,this.obf_W_j_2205);
         obf_K_e_3075.removeUIMouseToolTip(obf_Q_0_1896);
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
         var _loc2_:int = 0;
         if(this.obf_M_C_3926.checkTimeout())
         {
            _loc2_ = Math.round(Math.random() * 8);
            if(this.obf_y_G_2458)
            {
               this.obf_y_G_2458.onUpdate();
               this.obf_y_G_2458.doAction(obf_S_c_3330.obf_h_4_3537,_loc2_,true);
            }
            if(this.targetAiPet)
            {
               this.targetAiPet.onUpdate();
               this.targetAiPet.doAction(obf_S_c_3330.obf_h_4_3537,_loc2_,true);
            }
         }
      }
      
      private function obf_W_j_2205(param1:Event) : void
      {
         if(!this.currentPetAssembleConfig)
         {
            return;
         }
         if(!obf_x_c_2855.obf_C_e_1742(this.currentPetAssembleConfig))
         {
            return;
         }
         obf_x_c_2855.sendAssemble("",null,this.currentPetAssembleConfig.ruleIndex,null,false,[this.obf_f_7_1060]);
      }
      
      public function obf_6_q_3366(param1:NpcAssembleItemAnswer) : void
      {
         if(!this.visible)
         {
            return;
         }
         if(param1.assembleRuleIndex == this.currentPetAssembleConfig.ruleIndex)
         {
            if(param1.isSucceeded)
            {
               obf_x_c_2855.setAssembleLuck(param1.assembleRuleIndex,0);
               obf_x_c_2855.setLuckBox(0,obf_Q_0_1896);
               obf_q_6_3634.obf_e_J_1876("dzhao@fs9",1);
               obf_K_e_3075.closeUI(this);
            }
            else
            {
               obf_K_e_3075.showInfoOnUI(DiversityManager.getString("AssemblePrompt","assembleFail"),this,new Point(0,-100));
               obf_6_D_3816.print(DiversityManager.getString("AssemblePrompt","assembleFail"));
               obf_x_c_2855.setLuckBox(obf_x_c_2855.obf_0_2_6_666(param1.assembleRuleIndex),obf_Q_0_1896);
            }
         }
      }
      
      public function showPetAssemble(param1:String, param2:String) : void
      {
         var _loc3_:String = null;
         var _loc4_:IconItem = null;
         this.obf_P_W_1972();
         this.obf_Z_X_1425 = param1;
         this.obf_f_7_1060 = param2;
         this.currentPetAssembleConfig = obf_x_c_2855.getConfigInMaterialMap(param1,0);
         this.petBag.pushIconItem(IconItemManager.getIconItemByCode(param1,param2));
         this.obf_y_G_2458 = new obf_t_T_3981(param1);
         this.obf_y_G_2458.moveToPixel(0,0);
         this.obf_y_G_2458.doAction(obf_S_c_3330.obf_h_4_3537,obf_D_0_1300.DOWN,true);
         pointPetImage.addChild(this.obf_y_G_2458);
         if(this.currentPetAssembleConfig)
         {
            obf_x_c_2855.setLuckBox(obf_x_c_2855.getAssembleLuck(this.currentPetAssembleConfig.ruleIndex),obf_Q_0_1896,false);
            obf_Q_0_1896.visible = true;
            this.targetPetBag.pushIconItem(IconItemManager.getIconItemByCode(this.currentPetAssembleConfig.mainTargetItem,""));
            this.targetAiPet = new obf_t_T_3981(this.currentPetAssembleConfig.mainTargetItem);
            this.targetAiPet.moveToPixel(0,0);
            this.targetAiPet.doAction(obf_S_c_3330.obf_h_4_3537,obf_D_0_1300.DOWN,true);
            pointTargetPetImage.addChild(this.targetAiPet);
            for(_loc3_ in this.currentPetAssembleConfig.baseItems)
            {
               if(_loc3_ != this.obf_Z_X_1425)
               {
                  _loc4_ = IconItemManager.getIconItemByCode(_loc3_,"");
                  if(_loc4_)
                  {
                     _loc4_.itemCount = this.currentPetAssembleConfig.baseItems[_loc3_];
                     this.materialBag.pushIconItem(_loc4_);
                  }
               }
            }
         }
      }
      
      public function obf_P_W_1972() : void
      {
         txtChanse.text = "";
         obf_Q_0_1896.visible = false;
         this.petBag.dropIconItem();
         this.targetPetBag.dropIconItem();
         this.materialBag.dropIconItem();
         if(this.obf_y_G_2458)
         {
            this.obf_y_G_2458.destroy();
            if(pointPetImage.contains(this.obf_y_G_2458))
            {
               pointPetImage.removeChild(this.obf_y_G_2458);
            }
         }
         if(this.targetAiPet)
         {
            this.targetAiPet.destroy();
            if(pointTargetPetImage.contains(this.targetAiPet))
            {
               pointTargetPetImage.removeChild(this.targetAiPet);
            }
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
      
      public function showUI() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.visible = true;
      }
      
      public function getIconItemBags() : Array
      {
         return [this.petBag,this.targetPetBag,this.materialBag];
      }
      
      public function closeUI() : void
      {
         this.obf_P_W_1972();
         this.currentPetAssembleConfig = null;
         this.obf_Z_X_1425 = "";
         this.obf_f_7_1060 = "";
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.petBag.destroy();
         this.targetPetBag.destroy();
         this.materialBag.destroy();
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

