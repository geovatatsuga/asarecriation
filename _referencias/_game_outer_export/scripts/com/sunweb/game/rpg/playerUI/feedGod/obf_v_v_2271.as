package com.sunweb.game.rpg.playerUI.feedGod
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import playerUI.FeedGodCeilUIMC;
   
   public class obf_v_v_2271 extends FeedGodCeilUIMC
   {
      
      private var _config:Object = new Object();
      
      public function obf_v_v_2271(param1:Object)
      {
         super();
         cmdYangHun.label = DiversityManager.getString("FeedGodUI","cmdYangHun");
         this._config = param1;
         this.obf_2_Y_3019();
      }
      
      public function get config() : Object
      {
         return this._config;
      }
      
      public function set config(param1:Object) : void
      {
         this._config = param1;
      }
      
      private function obf_2_Y_3019() : void
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "";
         var _loc2_:String = "";
         var _loc3_:String = "";
         for(_loc4_ in this.config.attr)
         {
            _loc2_ += RoleAttributesModifierEnum.getAttributesName(int(_loc4_)) + "\n";
            _loc3_ += RoleAttributesModifierEnum.getAttributesValueString(int(_loc4_),this.config.attr[_loc4_]) + "\n";
         }
         txtAttrName.htmlText = _loc2_;
         txtAttrs.htmlText = _loc3_;
      }
      
      public function obf_i_m_3285(param1:String = "") : void
      {
         txtName.text = param1;
      }
      
      override public function get width() : Number
      {
         return 150;
      }
   }
}

