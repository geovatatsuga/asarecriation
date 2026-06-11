package com.sunweb.game.rpg.playerUI.glyph
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.glyph.obf_Q_J_3925;
   import com.sunweb.game.utils.JSONUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.GlyphBoxMC;
   
   public class obf_o_8_2436 extends GlyphBoxMC
   {
      
      public static var obf_E_I_4373:String = "onClickGlyphBox";
      
      public var obf_b_s_2997:int;
      
      public var _lv:int;
      
      public var obf_l_T_3060:int;
      
      public var _mp:int;
      
      public function obf_o_8_2436()
      {
         super();
         this.initDiversity();
         this.obf_x_v_2806();
      }
      
      private function initDiversity() : void
      {
         DiversityManager.setTextField(txtQuality,"roomBoxUI","txtQuality");
         cmdGlyph.label = DiversityManager.getString("roomBoxUI","cmdGlyph");
      }
      
      private function obf_x_v_2806() : void
      {
         cmdGlyph.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function removerListen() : void
      {
         cmdGlyph.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         dispatchEvent(new Event(obf_E_I_4373));
      }
      
      public function setName(param1:int) : void
      {
         this.obf_b_s_2997 = param1;
         txtName.text = JSONUtil.getStr(obf_Q_J_3925.getGlyphList(param1),["name"]);
      }
      
      public function setPullulate(param1:int, param2:int, param3:int) : void
      {
         this._lv = param2;
         this.obf_l_T_3060 = param1;
         var _loc4_:Array = JSONUtil.getObject(obf_Q_J_3925.getGlyphList(param3),["levelList"]) as Array;
         if(!_loc4_)
         {
            return;
         }
         var _loc5_:int = JSONUtil.getInt(_loc4_[param2],["value"]);
         this._mp = _loc5_;
         DiversityManager.setTextField(txtCurPullulate,"roomBoxUI","txtCurPullulate",[param1,_loc5_]);
         this.setPentacle(param2,param3);
      }
      
      public function setPentacle(param1:int, param2:int) : void
      {
         var _loc3_:String = "";
         var _loc4_:int = 0;
         while(_loc4_ < param1)
         {
            _loc3_ += "★";
            _loc4_++;
         }
         var _loc5_:String = "";
         var _loc6_:int = param1;
         while(_loc6_ < (JSONUtil.getObject(obf_Q_J_3925.getGlyphList(param2),["levelList"]) as Array).length - 1)
         {
            _loc5_ += "☆";
            _loc6_++;
         }
         txtPentacle.htmlText = _loc3_ + "<font color=\'#999999\'>" + _loc5_ + "</font>";
      }
      
      override public function get height() : Number
      {
         return 58;
      }
      
      public function destroy() : void
      {
         this.removerListen();
      }
   }
}

