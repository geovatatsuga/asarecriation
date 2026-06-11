package com.sunweb.game.rpg.playerUI.fastApplyUI
{
   import com.adobe.serialization.json.JSON;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.PlayerAttrFastApplyUIMC;
   
   public class obf_E_8_1846 extends PlayerAttrFastApplyUIMC implements IPlayerUI
   {
      
      private var strAdded:int;
      
      private var agiAdded:int;
      
      private var wisAdded:int;
      
      private var vitAdded:int;
      
      private var freeAttrPoint:int;
      
      public function obf_E_8_1846()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2 + 350;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdOK.addEventListener(MouseEvent.CLICK,this.onAssignAttrPoint);
         cmdStrAddPoint.addEventListener(MouseEvent.CLICK,this.onAddAttrPoint);
         cmdStrAddAllPoint.addEventListener(MouseEvent.CLICK,this.onAddAttrAllPoint);
         cmdStrRemovePoint.addEventListener(MouseEvent.CLICK,this.onRemoveAttrPoint);
         cmdAgiAddPoint.addEventListener(MouseEvent.CLICK,this.onAddAttrPoint);
         cmdAgiAddAllPoint.addEventListener(MouseEvent.CLICK,this.onAddAttrAllPoint);
         cmdAgiRemovePoint.addEventListener(MouseEvent.CLICK,this.onRemoveAttrPoint);
         cmdWigAddPoint.addEventListener(MouseEvent.CLICK,this.onAddAttrPoint);
         cmdWisAddAllPoint.addEventListener(MouseEvent.CLICK,this.onAddAttrAllPoint);
         cmdWisRemovePoint.addEventListener(MouseEvent.CLICK,this.onRemoveAttrPoint);
         cmdVitAddPoint.addEventListener(MouseEvent.CLICK,this.onAddAttrPoint);
         cmdVitAddAllPoint.addEventListener(MouseEvent.CLICK,this.onAddAttrAllPoint);
         cmdVitRemovePoint.addEventListener(MouseEvent.CLICK,this.onRemoveAttrPoint);
         cmdPointAuto.addEventListener(MouseEvent.CLICK,this.obf_u_2_3167);
         obf_K_e_3075.addUIMouseToolTip(txtDeyStrength,"Role_Strength");
         obf_K_e_3075.addUIMouseToolTip(txtDeyAgility,"Role_Agility");
         obf_K_e_3075.addUIMouseToolTip(txtDeyIntellect,"Role_Intellect");
         obf_K_e_3075.addUIMouseToolTip(txtDeyStamina,"Role_Stamina");
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdOK.removeEventListener(MouseEvent.CLICK,this.onAssignAttrPoint);
         cmdStrAddPoint.removeEventListener(MouseEvent.CLICK,this.onAddAttrPoint);
         cmdStrAddAllPoint.removeEventListener(MouseEvent.CLICK,this.onAddAttrAllPoint);
         cmdStrRemovePoint.removeEventListener(MouseEvent.CLICK,this.onRemoveAttrPoint);
         cmdAgiAddPoint.removeEventListener(MouseEvent.CLICK,this.onAddAttrPoint);
         cmdAgiAddAllPoint.removeEventListener(MouseEvent.CLICK,this.onAddAttrAllPoint);
         cmdAgiRemovePoint.removeEventListener(MouseEvent.CLICK,this.onRemoveAttrPoint);
         cmdWigAddPoint.removeEventListener(MouseEvent.CLICK,this.onAddAttrPoint);
         cmdWisAddAllPoint.removeEventListener(MouseEvent.CLICK,this.onAddAttrAllPoint);
         cmdWisRemovePoint.removeEventListener(MouseEvent.CLICK,this.onRemoveAttrPoint);
         cmdVitAddPoint.removeEventListener(MouseEvent.CLICK,this.onAddAttrPoint);
         cmdVitAddAllPoint.removeEventListener(MouseEvent.CLICK,this.onAddAttrAllPoint);
         cmdVitRemovePoint.removeEventListener(MouseEvent.CLICK,this.onRemoveAttrPoint);
         cmdPointAuto.removeEventListener(MouseEvent.CLICK,this.obf_u_2_3167);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyStrength);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyAgility);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyIntellect);
         obf_K_e_3075.removeUIMouseToolTip(txtDeyStamina);
      }
      
      private function onClose(param1:Event) : void
      {
         obf_X_t_4110.closeFastApplyUI(this);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      public function obf_a_N_3886() : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         this.freeAttrPoint = GameContext.localPlayer.fullInfo.freeAttrPt;
         this.strAdded = 0;
         this.agiAdded = 0;
         this.wisAdded = 0;
         this.vitAdded = 0;
         this.obf_t_4_1098();
      }
      
      public function obf_t_4_1098() : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         txtStrength.text = GameContext.localPlayer.fullInfo.attributes.strength + (this.strAdded > 0 ? "+(" + this.strAdded + ")" : "");
         txtAgility.text = GameContext.localPlayer.fullInfo.attributes.agility + (this.agiAdded > 0 ? "+(" + this.agiAdded + ")" : "");
         txtIntellect.text = GameContext.localPlayer.fullInfo.attributes.wisdom + (this.wisAdded > 0 ? "+(" + this.wisAdded + ")" : "");
         txtStamina.text = GameContext.localPlayer.fullInfo.attributes.vitality + (this.vitAdded > 0 ? "+(" + this.vitAdded + ")" : "");
         txtAttrPoint.text = this.freeAttrPoint + "";
         cmdOK.enabled = this.strAdded + this.agiAdded + this.wisAdded + this.vitAdded > 0;
      }
      
      private function onAssignAttrPoint(param1:Event) : void
      {
         if(this.strAdded + this.agiAdded + this.wisAdded + this.vitAdded <= 0 || !GameContext.localPlayer)
         {
            return;
         }
         GameContext.localPlayer.sendAssignAttr(this.strAdded,this.agiAdded,this.wisAdded,this.vitAdded);
         obf_X_t_4110.closeFastApplyUI(this);
      }
      
      private function onAddAttrPoint(param1:Event) : void
      {
         if(!GameContext.localPlayer || this.freeAttrPoint <= 0)
         {
            return;
         }
         if(param1.currentTarget == cmdStrAddPoint)
         {
            ++this.strAdded;
         }
         else if(param1.currentTarget == cmdAgiAddPoint)
         {
            ++this.agiAdded;
         }
         else if(param1.currentTarget == cmdWigAddPoint)
         {
            ++this.wisAdded;
         }
         else
         {
            if(param1.currentTarget != cmdVitAddPoint)
            {
               return;
            }
            ++this.vitAdded;
         }
         --this.freeAttrPoint;
         this.obf_t_4_1098();
      }
      
      private function onAddAttrAllPoint(param1:MouseEvent) : void
      {
         if(!GameContext.localPlayer || this.freeAttrPoint <= 0)
         {
            return;
         }
         if(param1.currentTarget == cmdStrAddAllPoint)
         {
            this.strAdded += this.freeAttrPoint;
         }
         else if(param1.currentTarget == cmdAgiAddAllPoint)
         {
            this.agiAdded += this.freeAttrPoint;
         }
         else if(param1.currentTarget == cmdWisAddAllPoint)
         {
            this.wisAdded += this.freeAttrPoint;
         }
         else
         {
            if(param1.currentTarget != cmdVitAddAllPoint)
            {
               return;
            }
            this.vitAdded += this.freeAttrPoint;
         }
         this.freeAttrPoint = 0;
         this.obf_t_4_1098();
      }
      
      private function onRemoveAttrPoint(param1:Event) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         if(param1.currentTarget == cmdStrRemovePoint && this.strAdded > 0)
         {
            --this.strAdded;
         }
         else if(param1.currentTarget == cmdAgiRemovePoint && this.agiAdded > 0)
         {
            --this.agiAdded;
         }
         else if(param1.currentTarget == cmdWisRemovePoint && this.wisAdded > 0)
         {
            --this.wisAdded;
         }
         else
         {
            if(!(param1.currentTarget == cmdVitRemovePoint && this.vitAdded > 0))
            {
               return;
            }
            --this.vitAdded;
         }
         ++this.freeAttrPoint;
         this.obf_t_4_1098();
      }
      
      private function obf_i_s_1897(param1:MouseEvent) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         this.freeAttrPoint += this.strAdded + this.agiAdded + this.wisAdded + this.vitAdded;
         this.strAdded = 0;
         this.agiAdded = 0;
         this.wisAdded = 0;
         this.vitAdded = 0;
         this.obf_t_4_1098();
      }
      
      private function obf_u_2_3167(param1:MouseEvent) : void
      {
         var basePointAuto:int;
         var strAddNumber:Number;
         var agiAddNumber:Number;
         var wisAddNumber:Number;
         var vitAddNumber:Number;
         var pointAutoArray:Array = null;
         var i:int = 0;
         var remainArray:Array = null;
         var strRemain:String = null;
         var agiRemain:String = null;
         var wisRemain:String = null;
         var vitRemain:String = null;
         var k:int = 0;
         var e:MouseEvent = param1;
         if(!GameContext.localPlayer)
         {
            return;
         }
         try
         {
            pointAutoArray = com.adobe.serialization.json.JSON.decode(DiversityManager.getString("PlayerPointAuto",GameContext.localPlayer.fullInfo.jobCode + "")) as Array;
         }
         catch(ex:Error)
         {
         }
         if(!pointAutoArray || pointAutoArray.length != 4)
         {
            return;
         }
         this.freeAttrPoint += this.strAdded + this.agiAdded + this.wisAdded + this.vitAdded;
         this.strAdded = 0;
         this.agiAdded = 0;
         this.wisAdded = 0;
         this.vitAdded = 0;
         basePointAuto = 0;
         while(i < pointAutoArray.length)
         {
            basePointAuto += int(pointAutoArray[i]);
            i++;
         }
         if(basePointAuto == 0)
         {
            return;
         }
         strAddNumber = int(pointAutoArray[0]) * this.freeAttrPoint / basePointAuto;
         agiAddNumber = int(pointAutoArray[1]) * this.freeAttrPoint / basePointAuto;
         wisAddNumber = int(pointAutoArray[2]) * this.freeAttrPoint / basePointAuto;
         vitAddNumber = int(pointAutoArray[3]) * this.freeAttrPoint / basePointAuto;
         this.strAdded = Math.floor(strAddNumber);
         this.agiAdded = Math.floor(agiAddNumber);
         this.wisAdded = Math.floor(wisAddNumber);
         this.vitAdded = Math.floor(vitAddNumber);
         this.freeAttrPoint -= this.strAdded + this.agiAdded + this.wisAdded + this.vitAdded;
         if(this.freeAttrPoint > 0)
         {
            remainArray = new Array();
            strRemain = (strAddNumber - this.strAdded).toFixed(1);
            remainArray.push({
               "name":"str",
               "remain":strRemain,
               "attrAdd":this.strAdded
            });
            agiRemain = (agiAddNumber - this.agiAdded).toFixed(1);
            remainArray.push({
               "name":"agi",
               "remain":agiRemain,
               "attrAdd":this.agiAdded
            });
            wisRemain = (wisAddNumber - this.wisAdded).toFixed(1);
            remainArray.push({
               "name":"wis",
               "remain":wisRemain,
               "attrAdd":this.wisAdded
            });
            vitRemain = (vitAddNumber - this.vitAdded).toFixed(1);
            remainArray.push({
               "name":"vit",
               "remain":vitRemain,
               "attrAdd":this.vitAdded
            });
            remainArray.sortOn(["remain","attrAdd"],[Array.NUMERIC,Array.NUMERIC]);
            k = remainArray.length - 1;
            while(k >= 0)
            {
               if(this.freeAttrPoint == 0)
               {
                  break;
               }
               trace(remainArray[k].name + "*" + remainArray[k].remain + "*" + this.freeAttrPoint);
               if(remainArray[k].name == "str")
               {
                  ++this.strAdded;
                  --this.freeAttrPoint;
               }
               else if(remainArray[k].name == "agi")
               {
                  ++this.agiAdded;
                  --this.freeAttrPoint;
               }
               else if(remainArray[k].name == "wis")
               {
                  ++this.wisAdded;
                  --this.freeAttrPoint;
               }
               else if(remainArray[k].name == "vit")
               {
                  ++this.vitAdded;
                  --this.freeAttrPoint;
               }
               k--;
            }
         }
         this.obf_t_4_1098();
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
         DiversityManager.setTextField(txtDeyStrength,"RoleUI","txtStrength");
         DiversityManager.setTextField(txtDeyAgility,"RoleUI","txtAgility");
         DiversityManager.setTextField(txtDeyIntellect,"RoleUI","txtIntellect");
         DiversityManager.setTextField(txtDeyStamina,"RoleUI","txtStamina");
         DiversityManager.setTextField(txtDeyAttrPoint,"RoleUI","txtAttrPoint");
         DiversityManager.setTextField(txtDeyTitle,"FastPlayerAttrPoint","txtTitle");
         cmdOK.label = DiversityManager.getString("FastPlayerAttrPoint","cmdOK");
         cmdPointAuto.label = DiversityManager.getString("FastPlayerAttrPoint","cmdAuto");
      }
      
      public function showUI() : void
      {
         this.obf_a_N_3886();
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

