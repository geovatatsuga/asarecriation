package com.sunweb.game.rpg.playerUI.glyph
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.glyph.obf_Q_J_3925;
   import com.sunweb.game.rpg.playerUI.GameTipManager;
   import com.sunweb.game.rpg.playerUI.GameTipUI;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import playerUI.RoomBoxUIMC;
   
   public class obf_Q_m_1583 extends RoomBoxUIMC implements IPlayerUI
   {
      
      private static var mouseTipMap:Dictionary = new Dictionary();
      
      private var obf_z_Z_1294:Object;
      
      public var redAttrArr:Array = new Array();
      
      public function obf_Q_m_1583()
      {
         super();
         this.visible = false;
         this.initDiversity();
         this.obf_z_Z_1294 = new Object();
         this.initRoom();
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.underline = true;
         txtLook.setTextFormat(_loc1_);
         this.addUIMouseToolTip(txtLook,0);
      }
      
      public static function clone(param1:*) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public function initRoom() : void
      {
         var _loc2_:Object = null;
         var _loc3_:obf_o_8_2436 = null;
         while(pointMC.numChildren > 0)
         {
            pointMC.removeChildAt(0);
         }
         var _loc1_:int = 0;
         for each(_loc2_ in obf_Q_J_3925.glyphList)
         {
            _loc3_ = new obf_o_8_2436();
            _loc3_.setName(_loc2_.kind);
            _loc3_.setPullulate(0,0,_loc2_.kind);
            _loc3_.addEventListener(obf_o_8_2436.obf_E_I_4373,this.obf_G_G_3426);
            _loc3_.y = _loc3_.height * _loc1_;
            pointMC.addChild(_loc3_);
            this.obf_z_Z_1294[_loc3_.obf_b_s_2997] = _loc3_;
            _loc1_++;
         }
      }
      
      public function getRoomObj() : Object
      {
         return this.obf_z_Z_1294;
      }
      
      private function obf_G_G_3426(param1:Event) : void
      {
         var _loc2_:obf_o_8_2436 = param1.target as obf_o_8_2436;
         obf_K_e_3075.depictBoxUI.setCurrDepictGlyph(_loc2_.obf_b_s_2997,_loc2_._lv,_loc2_.obf_l_T_3060);
         obf_K_e_3075.glyphBoxUI.showDepict();
      }
      
      public function obf_0_4_I_321(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:obf_o_8_2436 = this.obf_z_Z_1294[param1] as obf_o_8_2436;
         if(_loc4_)
         {
            _loc4_.setPullulate(param3,param2,param1);
         }
      }
      
      public function getCurrGlyph(param1:int) : obf_o_8_2436
      {
         return this.obf_z_Z_1294[param1] as obf_o_8_2436;
      }
      
      private function addUIMouseToolTip(param1:InteractiveObject, param2:int) : void
      {
         mouseTipMap[param1] = param2;
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
      }
      
      private function removeUIMouseToolTip(param1:InteractiveObject) : void
      {
         var mouseTipObj:InteractiveObject = param1;
         delete mouseTipMap[mouseTipObj];
         try
         {
            mouseTipObj.removeEventListener(MouseEvent.MOUSE_OVER,this.obf_Z_l_1286);
            mouseTipObj.removeEventListener(MouseEvent.MOUSE_OUT,this.obf_0_6_9_109);
         }
         catch(e:Error)
         {
         }
      }
      
      private function obf_Z_l_1286(param1:MouseEvent) : void
      {
         var _loc4_:obf_o_8_2436 = null;
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc9_:Object = null;
         var _loc10_:Number = NaN;
         var _loc2_:GameTipUI = new GameTipUI("roomMouseTip");
         var _loc3_:int = 200;
         this.redAttrArr = [];
         for each(_loc4_ in this.obf_z_Z_1294)
         {
            _loc5_ = obf_Q_J_3925.getGlyphList(_loc4_.obf_b_s_2997);
            if(_loc5_)
            {
               _loc6_ = _loc5_.levelList;
               if(_loc6_)
               {
                  _loc7_ = JSONUtil.getObject(_loc6_[_loc4_._lv],["attr"]);
                  if(_loc7_)
                  {
                     for(_loc8_ in _loc7_)
                     {
                        this.obf_3_m_883(int(_loc8_),_loc7_[_loc8_]);
                     }
                  }
               }
            }
         }
         if(Boolean(this.redAttrArr) && this.redAttrArr.length > 0)
         {
            for each(_loc9_ in this.redAttrArr)
            {
               _loc10_ = GameItemManager.getItemQualityValue(_loc9_.value,0);
               _loc2_.addTipInfo("<FONT color=\'#" + obf_0_3_0_538.obf_T_N_2235.toString(16) + "\'>" + RoleAttributesModifierEnum.getAttributesName(_loc9_.attr) + "</FONT>",_loc3_,_loc2_.maxRow + 1);
               _loc2_.addTipInfo("<P align=\'right\'><FONT color=\'#" + obf_0_3_0_538.obf_T_N_2235.toString(16) + "\'>" + RoleAttributesModifierEnum.getAttributesValueString(_loc9_.attr,_loc10_) + "</FONT></P>",_loc3_,_loc2_.maxRow);
            }
         }
         GameTipManager.showTip(_loc2_);
      }
      
      private function obf_0_6_9_109(param1:MouseEvent) : void
      {
         GameTipManager.closeTip("roomMouseTip");
      }
      
      public function obf_3_m_883(param1:int, param2:Number) : void
      {
         var _loc5_:Object = null;
         var _loc3_:Boolean = false;
         var _loc4_:Object = new Object();
         for each(_loc5_ in this.redAttrArr)
         {
            if(_loc5_.attr == param1)
            {
               _loc5_.value += param2;
               _loc3_ = true;
            }
         }
         if(!_loc3_)
         {
            _loc4_["attr"] = param1;
            _loc4_["value"] = param2;
            this.redAttrArr.push(_loc4_);
         }
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
      }
      
      public function get uiIndex() : int
      {
         return 0;
      }
      
      public function initDiversity() : void
      {
         txtLook.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("roomBoxUI","txtLook") + "</a>";
         DiversityManager.setTextField(txtExplain,"roomBoxUI","txtExplain");
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:obf_o_8_2436 = null;
         this.removeUIMouseToolTip(txtLook);
         for each(_loc1_ in this.obf_z_Z_1294)
         {
            _loc1_.removeEventListener(obf_o_8_2436.obf_E_I_4373,this.obf_G_G_3426);
            _loc1_.destroy();
            _loc1_ = null;
         }
         while(pointMC.numChildren > 0)
         {
            pointMC.removeChildAt(0);
         }
      }
   }
}

