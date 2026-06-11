package obf_A_z_3492
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.bless.obf_G_4_4620;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.playerUI.skill.obf_b_5_962;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.PlayerBlessUIMC;
   import playerUI.SkillShowBoxUIMC;
   
   public class obf_J_X_3789 extends PlayerBlessUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var obf_p_6_3006:Object;
      
      private var _skillBoxList:Array;
      
      private var obf_0_q_764:int;
      
      private var obf_0_3_D_193:String;
      
      public function obf_J_X_3789()
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:SkillShowBoxUIMC = null;
         var _loc8_:obf_b_5_962 = null;
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.visible = false;
         this.x = GameContext.gameStage.stageWidth / 2 + 300;
         this.y = GameContext.gameStage.stageHeight / 2;
         obf_L_n_2312.mouseEnabled = false;
         obf_L_n_2312.visible = false;
         this.obf_p_6_3006 = new Object();
         var _loc1_:Array = obf_G_4_4620.getGodTypeList();
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = this.getChildByName("godTypeSkill_" + _loc2_) as MovieClip;
            if(_loc3_)
            {
               _loc4_ = obf_G_4_4620.getGodBlessList(_loc2_);
               _loc5_ = new Array();
               for each(_loc6_ in _loc4_)
               {
                  _loc7_ = _loc3_[_loc6_];
                  if(_loc7_)
                  {
                     _loc8_ = new obf_b_5_962(_loc7_,this,_loc6_);
                     _loc8_.addEventListener(obf_b_5_962.obf_F_c_4296,this.obf_B_D_1521);
                     _loc5_.push(_loc8_);
                  }
               }
               this.obf_p_6_3006[_loc2_] = _loc5_;
            }
         }
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"BlessUI","txtTitle");
         DiversityManager.setTextField(txtDeyGodLevel,"BlessUI","txtGodLevel");
         DiversityManager.setTextField(txtDeyGodXP,"BlessUI","txtSincere");
         DiversityManager.setTextField(txtDeyPrompt,"BlessUI","txtPrompt");
         cmdBless.label = DiversityManager.getString("BlessUI","cmdStartBless");
         txtGodLevelName_1.text = obf_G_4_4620.getGodLevelName(1);
         txtGodLevelName_2.text = obf_G_4_4620.getGodLevelName(2);
         txtGodLevelName_3.text = obf_G_4_4620.getGodLevelName(3);
      }
      
      public function get obf_g_C_2812() : int
      {
         return this.obf_0_q_764;
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdBless.addEventListener(MouseEvent.CLICK,this.obf_r_D_1563);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdBless.removeEventListener(MouseEvent.CLICK,this.obf_r_D_1563);
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
      
      public function obf_t_z_926() : void
      {
         obf_L_n_2312.visible = false;
         this.obf_0_3_D_193 = "";
      }
      
      private function obf_r_D_1563(param1:Event) : void
      {
         if(GameContext.localPlayer.isBlessing)
         {
            obf_K_e_3075.showUI(obf_K_e_3075.blessBoothUI);
            return;
         }
         if(obf_L_l_4100.isEmpty(this.obf_0_3_D_193))
         {
            obf_K_e_3075.showInfoOnUI(DiversityManager.getString("BlessUI","prompt_SelectBless"),this);
            return;
         }
         if(obf_K_e_3075.blessBoothUI)
         {
            obf_K_e_3075.blessBoothUI.showBless(this.obf_0_3_D_193);
         }
      }
      
      public function setGodType(param1:int) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         var _loc5_:obf_b_5_962 = null;
         var _loc6_:MovieClip = null;
         var _loc2_:Array = obf_G_4_4620.getGodTypeList();
         this.obf_0_q_764 = param1;
         for each(_loc4_ in _loc2_)
         {
            _loc6_ = this.getChildByName("godTypeSkill_" + _loc4_) as MovieClip;
            if(_loc6_)
            {
               if(_loc4_ == param1)
               {
                  _loc3_ = _loc6_;
               }
               _loc6_.visible = _loc4_ == param1;
            }
         }
         this.bags = new Array();
         this._skillBoxList = this.obf_p_6_3006[param1];
         for each(_loc5_ in this._skillBoxList)
         {
            this.bags.push(_loc5_.iconBag);
         }
         this.obf_H_P_2879();
      }
      
      private function obf_B_D_1521(param1:Event) : void
      {
         var _loc2_:obf_b_5_962 = param1.currentTarget as obf_b_5_962;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Object = PlayerSkillManager.getUpSkillCondition(_loc2_.itemCode,PlayerSkillManager.getSkillLevel(_loc2_.itemCode) + 1);
         if(ConditionScript.checkCondition(_loc3_,null,true))
         {
            PlayerSkillManager.sendLearnSkill(_loc2_.itemCode,PlayerSkillManager.obf_0_6_Q_702);
         }
      }
      
      public function obf_0_6_e_338() : void
      {
         if(JSONUtil.getValue(GameContext.localPlayer,"fullInfo","attributes") == null)
         {
            return;
         }
         txtDeyTitle.text = obf_G_4_4620.getGodTypeName(GameContext.localPlayer.fullInfo.beliefGod);
         txtGodLevel.text = obf_G_4_4620.getGodLevelName(GameContext.localPlayer.fullInfo.beliefLevel);
         txtGodXP.text = GameContext.localPlayer.fullInfo.attributes.xp + "/" + GameContext.localPlayer.fullInfo.attributes.xpMax;
      }
      
      public function obf_H_P_2879() : void
      {
         var _loc1_:obf_b_5_962 = null;
         for each(_loc1_ in this._skillBoxList)
         {
            if(_loc1_)
            {
               _loc1_.obf_y_4_1171({});
            }
         }
      }
      
      public function showUI() : void
      {
         this.obf_0_6_e_338();
         this.obf_H_P_2879();
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:String = null;
         var _loc2_:obf_b_5_962 = null;
         this.removeListener();
         for(_loc1_ in this.obf_p_6_3006)
         {
            for each(_loc2_ in this.obf_p_6_3006[_loc1_])
            {
               if(_loc2_)
               {
                  _loc2_.destroy();
               }
            }
         }
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:Point = null;
         this.obf_t_z_926();
         if(Boolean(param1) && Boolean(param1.haveIconItem) && PlayerSkillManager.obf_0_6_G_255(param1.haveIconItem.itemCode))
         {
            _loc4_ = this.globalToLocal(param1.localToGlobal(new Point()));
            obf_L_n_2312.x = _loc4_.x;
            obf_L_n_2312.y = _loc4_.y;
            obf_L_n_2312.visible = true;
            this.obf_0_3_D_193 = param1.haveIconItem.itemCode;
         }
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
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
   }
}

