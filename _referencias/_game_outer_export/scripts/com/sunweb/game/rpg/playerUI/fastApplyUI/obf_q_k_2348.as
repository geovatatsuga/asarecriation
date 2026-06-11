package com.sunweb.game.rpg.playerUI.fastApplyUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.PlayerSkillFastApplyUIMC;
   
   public class obf_q_k_2348 extends PlayerSkillFastApplyUIMC implements IIconItemUI
   {
      
      private var skillBag:IconItemBag;
      
      private var _skillCode:String;
      
      private var obf_0_4_x_593:int;
      
      private var _skillConfig:Object;
      
      public function obf_q_k_2348(param1:String)
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2 + 350;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.skillBag = new IconItemBag(bagSkill,this,0);
         this.skillBag.addValidType(GameItemType.SKILL);
         this._skillCode = param1;
         this.obf_0_4_x_593 = PlayerSkillManager.getSkillLevel(this._skillCode);
         this._skillConfig = SkillConfig.getSkillConfig(this._skillCode);
         this.skillBag.pushIconItem(IconItemSkill.getNewIconItem(param1,Math.max(this.obf_0_4_x_593,1)));
         txtSkill.text = JSONUtil.getStr(this._skillConfig,["name"]);
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         cmdSkill.addEventListener(MouseEvent.CLICK,this.obf_E_2_4420);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         cmdSkill.removeEventListener(MouseEvent.CLICK,this.obf_E_2_4420);
      }
      
      private function obf_E_2_4420(param1:Event) : void
      {
         if(!this._skillConfig)
         {
            return;
         }
         if(this.obf_0_4_x_593 >= JSONUtil.getInt(this._skillConfig,["levelInfo","length"]))
         {
            return;
         }
         var _loc2_:Object = PlayerSkillManager.getUpSkillCondition(this._skillCode,this.obf_0_4_x_593 + 1);
         if(!ConditionScript.checkCondition(_loc2_,null,true))
         {
            return;
         }
         PlayerSkillManager.sendLearnSkill(this._skillCode,PlayerSkillManager.obf_c_c_4538);
         obf_X_t_4110.closeFastApplyUI(this);
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
         DiversityManager.setTextField(txtDeyTitle,"FastSkillUI","txtTitle");
         cmdSkill.label = DiversityManager.getString("FastSkillUI","cmdOK");
      }
      
      public function getIconItemBags() : Array
      {
         return [this.skillBag];
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function destroy() : void
      {
         this.removeListener();
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

