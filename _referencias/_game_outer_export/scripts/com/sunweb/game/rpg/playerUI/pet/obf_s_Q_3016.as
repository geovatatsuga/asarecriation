package com.sunweb.game.rpg.playerUI.pet
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.role.SkillConfig;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.PetSkillBoxMC;
   
   public class obf_s_Q_3016 extends PetSkillBoxMC
   {
      
      public static const obf_V_6_2382:String = "forgetPetSkill";
      
      private var _iconBag:IconItemBag;
      
      public function obf_s_Q_3016(param1:IIconItemUI)
      {
         super();
         this.initDiversity();
         this._iconBag = new IconItemBag(iconBar,param1,0);
         this._iconBag.addValidType(GameItemType.SKILL);
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         cmdReset.label = DiversityManager.getString("PetUI","cmdClearSkill");
      }
      
      private function addListener() : void
      {
         cmdReset.addEventListener(MouseEvent.CLICK,this.obf_q_u_1749);
      }
      
      private function removeListener() : void
      {
         cmdReset.removeEventListener(MouseEvent.CLICK,this.obf_q_u_1749);
      }
      
      public function get iconBag() : IconItemBag
      {
         return this._iconBag;
      }
      
      private function obf_q_u_1749(param1:Event) : void
      {
         this.dispatchEvent(new Event(obf_V_6_2382));
      }
      
      public function setSkill(param1:String, param2:int) : void
      {
         var _loc3_:Object = SkillConfig.getSkillConfig(param1);
         var _loc4_:IconItemSkill = IconItemSkill.getNewIconItem(param1,param2);
         if(!_loc3_ || !_loc4_ || !this._iconBag)
         {
            return;
         }
         this._iconBag.lockDrag = true;
         this._iconBag.pushIconItem(_loc4_);
      }
      
      public function obf_L_t_4155() : void
      {
         if(!this._iconBag)
         {
            return;
         }
         this._iconBag.dropIconItem();
      }
      
      public function destroy() : void
      {
         this.removeListener();
         if(Boolean(this._iconBag) && this._iconBag.parent == this)
         {
            this._iconBag.destroy();
            this.removeChild(this._iconBag);
         }
         this._iconBag = null;
      }
   }
}

