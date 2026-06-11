package com.sunweb.game.rpg.playerUI.skill
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.skill.obf_M_F_3694;
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import playerUI.SkillShowBoxUIMC;
   
   public class obf_b_5_962 extends EventDispatcher
   {
      
      public static const obf_F_c_4296:String = "SkillShowBox_Click_Up";
      
      public static const obf_d_E_4181:String = "SkillShowBox_Click_Down";
      
      public static const obf_J_Q_3700:String = "SkillShowBox_Button_Click";
      
      public static const obf_K_w_1992:String = "SkillShowBox_Button_MouseOver";
      
      public static const obf_c_7_1394:String = "SkillShowBox_Button_MouseOut";
      
      private var obf_0_l_3733:SkillShowBoxUIMC;
      
      private var _iconBag:IconItemBag;
      
      private var _skillCode:String;
      
      public function obf_b_5_962(param1:SkillShowBoxUIMC, param2:IIconItemUI, param3:String)
      {
         super(this);
         if(!param1)
         {
            throw new Error("Null SkillShowBox!");
         }
         this._skillCode = param3;
         this.obf_0_l_3733 = param1;
         this._iconBag = new IconItemBag(this.obf_0_l_3733.iconBag,param2,0);
         this._iconBag.addValidType(GameItemType.ALL);
         this.obf_0_l_3733.setChildIndex(this._iconBag,0);
         this.obf_y_4_1171();
         this.initDiversity();
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
      }
      
      public function obf_y_4_1171(param1:Object = null) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         var _loc2_:IconItemSkill = IconItemSkill.getNewIconItem(this._skillCode,1);
         if(!_loc2_)
         {
            return;
         }
         if(PlayerSkillManager.obf_0_6_G_255(this._skillCode))
         {
            _loc2_.level = PlayerSkillManager.getSkillLevel(this._skillCode);
            _loc2_.itemCount = _loc2_.level;
         }
         this._iconBag.dropIconItem();
         this._iconBag.pushIconItem(_loc2_);
         if(!PlayerSkillManager.obf_0_6_G_255(this._skillCode) && Boolean(_loc2_))
         {
            _loc2_.filters = [obf_9_V_1635.getGrayFilter()];
         }
         var _loc3_:Object = SkillConfig.getSkillConfig(this._skillCode);
         if(!_loc3_)
         {
            return;
         }
         if(_loc3_.type == obf_M_F_3694.obf_u_8_4559 || _loc3_.type == obf_M_F_3694.obf_0_7_O_353 || !PlayerSkillManager.obf_0_6_G_255(this._skillCode))
         {
            this._iconBag.lockDrag = true;
         }
         else
         {
            this._iconBag.lockDrag = false;
         }
         this.obf_0_l_3733.cmdUp.visible = false;
         if(_loc2_.level < _loc3_.levelInfo.length || !PlayerSkillManager.obf_0_6_G_255(this._skillCode))
         {
            if(!param1)
            {
               param1 = PlayerSkillManager.getUpSkillCondition(this._skillCode,PlayerSkillManager.getSkillLevel(this._skillCode) + 1);
            }
            if(ConditionScript.checkCondition(param1))
            {
               this.obf_0_l_3733.cmdUp.visible = true;
            }
         }
      }
      
      public function get operationButton() : MainButton
      {
         return this.obf_0_l_3733.cmdOperation;
      }
      
      public function get cmdUpButton() : SimpleButton
      {
         return this.obf_0_l_3733.cmdUp;
      }
      
      public function get iconBag() : IconItemBag
      {
         return this._iconBag;
      }
      
      public function get itemCode() : String
      {
         if(!this._iconBag || !this._iconBag.haveIconItem)
         {
            return "";
         }
         return this._iconBag.haveIconItem.itemCode;
      }
      
      private function addListener() : void
      {
         this.obf_0_l_3733.cmdUp.addEventListener(MouseEvent.CLICK,this.obf_s_m_2457);
         this.obf_0_l_3733.cmdUp.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.obf_0_l_3733.cmdUp.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.obf_0_l_3733.cmdOperation.addEventListener(MouseEvent.CLICK,this.onClickButton);
         this.obf_0_l_3733.cmdOperation.addEventListener(MouseEvent.MOUSE_OVER,this.obf_M_1_4329);
         this.obf_0_l_3733.cmdOperation.addEventListener(MouseEvent.MOUSE_OUT,this.obf_X_7_2611);
      }
      
      private function removeListener() : void
      {
         this.obf_0_l_3733.cmdUp.removeEventListener(MouseEvent.CLICK,this.obf_s_m_2457);
         this.obf_0_l_3733.cmdUp.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.obf_0_l_3733.cmdUp.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this.obf_0_l_3733.cmdOperation.removeEventListener(MouseEvent.CLICK,this.onClickButton);
      }
      
      private function onMouseOver(param1:Event) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("SkillUpCondition");
         var _loc3_:int = 200;
         _loc2_.addTipInfo("<P align=\'center\'><font color=\'#FFFF00\'>" + DiversityManager.getString("PlayerSkillPrompt","learnSkillPrompt_Title") + "</font></P>",_loc3_,0);
         var _loc4_:Object = PlayerSkillManager.getUpSkillCondition(this._skillCode,PlayerSkillManager.getSkillLevel(this._skillCode) + 1);
         _loc2_.addTipInfo(ConditionScript.getConditionsHTML(_loc4_),_loc3_,_loc2_.maxRow + 1);
         GameTipManager.showTip(_loc2_);
      }
      
      private function onMouseOut(param1:Event) : void
      {
         GameTipManager.closeTip("SkillUpCondition");
      }
      
      private function obf_s_m_2457(param1:Event) : void
      {
         this.dispatchEvent(new Event(obf_F_c_4296));
      }
      
      private function obf_0_j_3636(param1:Event) : void
      {
         this.dispatchEvent(new Event(obf_d_E_4181));
      }
      
      private function onClickButton(param1:Event) : void
      {
         this.dispatchEvent(new Event(obf_J_Q_3700));
      }
      
      private function obf_M_1_4329(param1:Event) : void
      {
         this.dispatchEvent(new Event(obf_K_w_1992));
      }
      
      private function obf_X_7_2611(param1:Event) : void
      {
         this.dispatchEvent(new Event(obf_c_7_1394));
      }
      
      public function destroy() : void
      {
         this.removeListener();
         if(this._iconBag)
         {
            this._iconBag.destroy();
         }
      }
   }
}

