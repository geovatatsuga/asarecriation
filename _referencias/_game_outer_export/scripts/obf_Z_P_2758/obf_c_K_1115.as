package obf_Z_P_2758
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.fateTurntable.obf_3_i_1942;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.MoulageTypeUIMC;
   
   public class obf_c_K_1115 extends MoulageTypeUIMC
   {
      
      public static const obf_N_I_1539:String = "MoulageType_EVENT";
      
      public var _config:Object;
      
      public function obf_c_K_1115(param1:IPlayerUI, param2:Object)
      {
         super();
         this._config = param2;
         this.obf_k_T_4034();
         this.addListener();
         txtLv.mouseEnabled = false;
         txtAttr.mouseEnabled = false;
      }
      
      private function addListener() : void
      {
         cmdUp.addEventListener(MouseEvent.CLICK,this.obf_C_N_3764);
         cmdUp.addEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         cmdUp.addEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
      }
      
      private function removeListener() : void
      {
         cmdUp.removeEventListener(MouseEvent.CLICK,this.obf_C_N_3764);
         cmdUp.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_G_k_3294);
         cmdUp.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_6_b_2643);
      }
      
      private function obf_C_N_3764(param1:Event) : void
      {
         dispatchEvent(new Event(obf_N_I_1539));
      }
      
      private function obf_G_k_3294(param1:MouseEvent) : void
      {
         var _loc2_:GameTipUI = new GameTipUI("moulageTypeUITip");
         var _loc3_:int = 150;
         var _loc4_:String = DiversityManager.getString("FateTurntableUI","moulageTypeUITip");
         _loc2_.addTipInfo(_loc4_,_loc3_,0);
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_6_b_2643(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("moulageTypeUITip");
      }
      
      private function obf_k_T_4034() : void
      {
         var _loc7_:String = null;
         this.clear();
         cmdUp.gotoAndStop(this._config.id + 1);
         txtLv.text = this._config.level + "";
         var _loc1_:Array = obf_3_i_1942.allFateArr.sortOn("id",Array.NUMERIC);
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:Object = new Object();
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            if(_loc1_[_loc3_].id == this._config.id)
            {
               _loc2_ = _loc1_[_loc3_].attr;
            }
            _loc3_++;
         }
         var _loc4_:String = "";
         var _loc5_:int = 1;
         var _loc6_:uint = 16777215;
         if(this._config.level > 0)
         {
            if(obf_K_e_3075.obf_P_2_4217._result[this._config.id] == 1)
            {
               _loc5_ = 2;
               _loc6_ = 3407616;
            }
            else if(obf_K_e_3075.obf_P_2_4217._result[this._config.id] == 2)
            {
               _loc5_ = 0;
               _loc6_ = 16711680;
            }
            for(_loc7_ in _loc2_)
            {
               _loc4_ = RoleAttributesModifierEnum.getAttributesName(int(_loc7_)) + RoleAttributesModifierEnum.getAttributesValueString(int(_loc7_),_loc2_[_loc7_] * this._config.level * _loc5_,true) + "\r";
            }
         }
         txtAttr.textColor = _loc6_;
         txtAttr.text = _loc4_;
      }
      
      private function clear() : void
      {
         txtLv.text = "";
         txtAttr.text = "";
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

