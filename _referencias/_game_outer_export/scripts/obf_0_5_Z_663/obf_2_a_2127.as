package obf_0_5_Z_663
{
   import obf_0_7_V_532.obf_N_o_3647;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.RoleAttributesModifierEnum;
   import fl.events.ScrollEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   import playerUI.GenieMagicBloodUIMC;
   
   public class obf_2_a_2127 extends GenieMagicBloodUIMC implements IPlayerUI
   {
      
      private var attr:Object;
      
      private var obf_b_O_1210:Object = new Object();
      
      private var obf_I_p_3143:Object;
      
      private var talentConfig:Object = new Object();
      
      private var obf_W_3_2013:Array = new Array();
      
      public function obf_2_a_2127()
      {
         super();
         this.initDiversity();
         this.visible = false;
         this.obf_I_p_3143 = new Object();
         this.talentConfig = obf_N_o_3647.getGenieMagicTalentConfig();
         this.setShowSkill(obf_N_o_3647.getGenieMagicBloodConfig());
         obf_i_C_3008.pageSize = obf_i_C_3008.height;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.underline = true;
         txtSkill.setTextFormat(_loc1_);
         this.addListener();
      }
      
      private function addListener() : void
      {
         obf_i_C_3008.addEventListener(ScrollEvent.SCROLL,this.obf_M_c_909);
         cmdTalent.addEventListener(MouseEvent.CLICK,this.obf_H_5_912);
         obf_K_e_3075.addUIMouseToolTip(cmdTalent,"cmdTalent");
         obf_K_e_3075.addUIMouseToolTip(txtSkill,"showTxtGenieMagicSkill");
      }
      
      private function removeListener() : void
      {
         obf_i_C_3008.removeEventListener(ScrollEvent.SCROLL,this.obf_M_c_909);
         cmdTalent.removeEventListener(MouseEvent.CLICK,this.obf_H_5_912);
         obf_K_e_3075.removeUIMouseToolTip(cmdTalent);
         obf_K_e_3075.removeUIMouseToolTip(txtSkill);
      }
      
      private function obf_M_c_909(param1:ScrollEvent) : void
      {
         pointBlood.scrollRect = new Rectangle(0,param1.position,obf_i_C_3008.x - pointBlood.x,obf_i_C_3008.height - 5);
      }
      
      private function setShowSkill(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:obf_Z_4_1304 = null;
         if(!param1)
         {
            return;
         }
         while(pointBlood.numChildren > 0)
         {
            if(pointBlood.getChildAt(0) is obf_Z_4_1304)
            {
               obf_Z_4_1304(pointBlood.getChildAt(0)).destroy();
            }
            pointBlood.removeChildAt(0);
         }
         pointBlood.scrollRect = new Rectangle(0,0,obf_i_C_3008.x - pointBlood.x,obf_i_C_3008.height - 5);
         var _loc3_:int = 0;
         var _loc4_:Array = param1.attrConfig as Array;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_];
            _loc7_ = new obf_Z_4_1304(_loc6_);
            _loc7_.addEventListener(obf_Z_4_1304.obf_v_y_2674,this.obf_V_Q_2027);
            _loc7_.setRemark(_loc6_.explain);
            _loc7_.setGrade(0,_loc6_.maxLevel);
            _loc7_.setTips(_loc6_.costRemark);
            _loc7_.configObj = _loc6_;
            this.obf_I_p_3143[_loc6_.attrEnum] = _loc7_;
            _loc7_.y = _loc2_;
            pointBlood.addChild(_loc7_);
            _loc2_ += _loc7_.height + 5;
            _loc5_++;
         }
         if(_loc2_ > obf_i_C_3008.height)
         {
            obf_i_C_3008.maxScrollPosition = _loc2_ - obf_i_C_3008.height;
            obf_i_C_3008.visible = true;
         }
         else
         {
            obf_i_C_3008.scrollPosition = 0;
            obf_i_C_3008.maxScrollPosition = 1;
            obf_i_C_3008.visible = false;
         }
      }
      
      public function obf_v_E_1606(param1:Object) : void
      {
         var _loc4_:Number = NaN;
         var _loc6_:* = undefined;
         var _loc7_:obf_Z_4_1304 = null;
         if(!param1)
         {
            return;
         }
         var _loc2_:String = "";
         var _loc3_:String = "";
         var _loc5_:int = 0;
         for(_loc6_ in param1)
         {
            if(_loc5_ > 0)
            {
               _loc3_ += "\n";
               _loc2_ += "\n";
            }
            _loc7_ = this.obf_I_p_3143[_loc6_] as obf_Z_4_1304;
            if(_loc7_)
            {
               _loc7_.setGrade(param1[_loc6_],_loc7_.configObj.maxLevel);
               _loc4_ = obf_N_o_3647.talentLevel > 0 ? Number(this.talentConfig.turnRate[obf_N_o_3647.talentLevel - 1]) : 0;
               _loc3_ += RoleAttributesModifierEnum.getAttributesName(_loc6_);
               _loc2_ += RoleAttributesModifierEnum.getAttributesValueString(_loc6_,_loc7_.configObj.addValue * param1[_loc6_] * _loc4_,true);
               _loc5_++;
            }
         }
         DiversityManager.setTextField(this.txtGenieTalentLv,"GenieMagicBoxUI","txtGenieTalentLv",[obf_N_o_3647.talentLevel > 0 ? obf_N_o_3647.talentLevel : 0],true);
         DiversityManager.setTextField(this.txtChance,"GenieMagicBoxUI","txtChance",[((obf_N_o_3647.talentLevel > 0 ? this.talentConfig.turnRate[obf_N_o_3647.talentLevel - 1] : this.talentConfig.turnRate[0]) * 100).toFixed(2)],true);
         txtAttrName.text = _loc3_;
         txtAttr.text = _loc2_;
      }
      
      private function obf_V_Q_2027(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc2_:Object = param1.currentTarget.configObj;
         if(!_loc2_)
         {
            return;
         }
         for(_loc3_ in _loc2_.upItems)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc3_) < _loc2_.upItems[_loc3_])
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("GenieMagicBoxUI","prompt_NoMoreMaterial",[GameItemManager.getItemName(_loc3_) + " x" + _loc2_.upItems[_loc3_]]));
               return;
            }
         }
         obf_N_o_3647.sendGenieMagicBloodUpSkill(_loc2_.attrEnum,obf_N_o_3647.obf_k_r_3706);
      }
      
      private function obf_H_5_912(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc2_:Object = this.talentConfig;
         for(_loc3_ in _loc2_.upItems)
         {
            if(obf_K_e_3075.playerBagUI.getItemCount(_loc3_) < _loc2_.upItems[_loc3_])
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("GenieMagicBoxUI","prompt_NoMoreMaterial",[GameItemManager.getItemName(_loc3_) + " x" + _loc2_.upItems[_loc3_]]));
               return;
            }
         }
         if(obf_N_o_3647.talentLevel >= this.talentConfig.turnRate.length)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("GenieMagicBoxUI","talentMaxLv"));
            return;
         }
         obf_N_o_3647.sendGenieMagictalentUpSkill(obf_N_o_3647.obf_0_5_C_356);
      }
      
      private function showTalent(param1:Object) : void
      {
         DiversityManager.setTextField(this.txtGenieTalentLv,"GenieMagicBoxUI","txtGenieTalentLv",[obf_N_o_3647.talentLevel > 0 ? obf_N_o_3647.talentLevel : 0],true);
         DiversityManager.setTextField(this.txtChance,"GenieMagicBoxUI","txtChance",[(obf_N_o_3647.talentLevel > 0 ? this.talentConfig.turnRate[obf_N_o_3647.talentLevel - 1] : 0) * 100],true);
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
         txtAttr.text = "";
         txtSkill.htmlText = "<A HREF=\'event:#\'>" + DiversityManager.getString("GenieMagicBoxUI","txtSkill") + "</a>";
         DiversityManager.setTextField(txtStone,"GenieMagicBoxUI","txtStone");
         cmdTalent.label = DiversityManager.getString("GenieMagicBoxUI","cmdTalent");
         DiversityManager.setTextField(txtskillAttr,"GenieMagicBoxUI","txtskillAttr");
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
         this.removeListener();
      }
   }
}

