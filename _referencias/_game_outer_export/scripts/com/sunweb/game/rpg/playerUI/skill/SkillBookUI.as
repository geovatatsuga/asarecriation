package com.sunweb.game.rpg.playerUI.skill
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.skill.obf_M_F_3694;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.utils.JSONUtil;
   import fl.events.ScrollEvent;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import playerUI.SkillBookUIMC;
   
   public class SkillBookUI extends SkillBookUIMC implements IIconItemUI, obf_0_d_4341
   {
      
      private var obf_C_0_1218:Array;
      
      private var obf_0___Y_275:Array;
      
      private var obf_0___g_367:Object;
      
      private var defaultSkill:IconItemBag;
      
      private var treePages:Array;
      
      private var currentTreeIndex:int;
      
      private var obf_0_2_u_63:DisplayObjectContainer;
      
      private var obf_l_i_4037:int;
      
      private var _noviceSprite:Sprite;
      
      public function SkillBookUI()
      {
         var _loc2_:IconItemBag = null;
         super();
         this.initDiversity();
         this.cacheAsBitmap = true;
         chkAutoCastSkill.visible = !WorldConfig.getValue("functionSwitch","autoCastSkill");
         this.x = GameContext.gameStage.stageWidth / 2 + 180;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         obf_3_B_2905.pageSize = obf_3_B_2905.height;
         this.jobSkill_6.txtRoleSkill.mouseEnabled = false;
         this.jobSkill_6.txtChangeSkill.mouseEnabled = false;
         this.defaultSkill = new IconItemBag(defaultSkillBag,this,0);
         this.defaultSkill.addValidType(GameItemType.SKILL);
         this.obf_C_0_1218 = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 12)
         {
            if(this["skillBag" + _loc1_])
            {
               _loc2_ = new IconItemBag(this["skillBag" + _loc1_],this,0);
               _loc2_.addValidType(GameItemType.SKILL);
               this.obf_C_0_1218.push(_loc2_);
            }
            _loc1_++;
         }
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"SkillBookUI","txtTitle");
         DiversityManager.setTextField(txtDeySkillPoint,"SkillBookUI","txtSkillPoint");
         DiversityManager.setTextField(txtDeyOtherSkill,"SkillBookUI","txtOtherSkill");
         DiversityManager.setTextField(txtDeyDefaultSkill,"SkillBookUI","txtDefaultSkill");
         chkAutoCastSkill.label = DiversityManager.getString("SkillBookUI","chkAutoCastSkill");
         DiversityManager.setTextField(this.jobSkill_6.txtRoleSkill,"SkillBookUI","txtRoleSkill");
         DiversityManager.setTextField(this.jobSkill_6.txtChangeSkill,"SkillBookUI","txtChangeSkill");
      }
      
      public function set noviceSprite(param1:Sprite) : void
      {
         this._noviceSprite = param1;
      }
      
      public function get noviceSprite() : Sprite
      {
         return this._noviceSprite;
      }
      
      public function get novicePromptName() : String
      {
         return "SkillBookUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         var _loc2_:DisplayObject = null;
         var _loc4_:IconItemBag = null;
         var _loc3_:Array = this.getIconItemBags();
         for each(_loc4_ in _loc3_)
         {
            if(Boolean(_loc4_.haveIconItem) && _loc4_.haveIconItem.itemCode == param1)
            {
               _loc2_ = _loc4_;
               break;
            }
         }
         if(!_loc2_)
         {
            return null;
         }
         return this.globalToLocal(_loc2_.localToGlobal(new Point(16,16)));
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         return this.getSkillIconBag(param1);
      }
      
      public function get allSkillBox() : Object
      {
         return this.obf_0___g_367;
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         obf_3_B_2905.addEventListener(ScrollEvent.SCROLL,this.obf_0_4_C_520);
         chkAutoCastSkill.addEventListener(MouseEvent.CLICK,this.obf_A_N_4175);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         obf_3_B_2905.removeEventListener(ScrollEvent.SCROLL,this.obf_0_4_C_520);
         chkAutoCastSkill.removeEventListener(MouseEvent.CLICK,this.obf_A_N_4175);
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
      
      private function obf_0_4_C_520(param1:Event) : void
      {
         if(!this.obf_0_2_u_63)
         {
            return;
         }
         this.obf_0_2_u_63.scrollRect = null;
         this.obf_0_2_u_63.scrollRect = new Rectangle(this.currentTreeIndex * (this.obf_l_i_4037 / this.treePages.length),obf_3_B_2905.scrollPosition,this.obf_l_i_4037 / this.treePages.length,obf_3_B_2905.height);
      }
      
      private function obf_c_8_824(param1:Event) : void
      {
         this.currentTreeIndex = JSONUtil.getInt(param1.currentTarget,["index"]);
         this.obf_0_0_F_676();
      }
      
      private function obf_A_N_4175(param1:Event) : void
      {
         PlayerSkillManager.enableAutoSkill = chkAutoCastSkill.selected;
      }
      
      public function getSkillIconBag(param1:String) : IconItemBag
      {
         var _loc3_:IconItemBag = null;
         var _loc2_:Array = this.getIconItemBags();
         for each(_loc3_ in _loc2_)
         {
            if(Boolean(_loc3_.haveIconItem) && _loc3_.haveIconItem.itemCode == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function obf_0_0_F_676() : void
      {
         var _loc2_:TableButton = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.treePages.length)
         {
            _loc2_ = this.treePages[_loc1_] as TableButton;
            if(_loc2_)
            {
               _loc2_.gotoAndStop(_loc1_ == this.currentTreeIndex ? 2 : 1);
            }
            _loc1_++;
         }
         this.obf_0_2_u_63.scrollRect = new Rectangle(this.currentTreeIndex * (this.obf_l_i_4037 / this.treePages.length),obf_3_B_2905.scrollPosition,this.obf_l_i_4037 / this.treePages.length,obf_3_B_2905.height);
      }
      
      public function obf_0_5_m_711() : void
      {
         var _loc1_:String = null;
         var _loc2_:IconItemBag = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc8_:String = null;
         var _loc9_:obf_b_5_962 = null;
         var _loc10_:String = null;
         var _loc11_:Object = null;
         var _loc12_:String = null;
         var _loc13_:Object = null;
         var _loc14_:Object = null;
         this.refreshSkillPoint();
         for(_loc1_ in this.obf_0___g_367)
         {
            _loc9_ = this.obf_0___g_367[_loc1_] as obf_b_5_962;
            if(_loc9_)
            {
               _loc9_.obf_y_4_1171();
            }
         }
         for each(_loc2_ in this.obf_C_0_1218)
         {
            if(_loc2_)
            {
               _loc2_.dropIconItem();
            }
         }
         this.obf_d_y_3738(IconItemSkill.getNewIconItem(WorldConfig.getDefaultAttackSkillCode(GameContext.localPlayer.fullInfo.jobCode),1));
         if(obf_K_e_3075.playerFullInfoUI)
         {
            _loc4_ = obf_K_e_3075.playerFullInfoUI.getEquipBindSkills();
         }
         if(obf_K_e_3075.constellationUI)
         {
            _loc6_ = obf_K_e_3075.constellationUI.getEquipBindSkills();
         }
         _loc3_ = _loc4_.concat(_loc6_);
         if(Boolean(_loc3_) && _loc3_.length > 0)
         {
            for each(_loc10_ in _loc3_)
            {
               _loc11_ = SkillConfig.getSkillConfig(_loc10_);
               if(_loc11_)
               {
                  if(JSONUtil.getInt(_loc11_,["type"]) != obf_M_F_3694.obf_u_8_4559)
                  {
                     this.obf_d_y_3738(IconItemSkill.getNewIconItem(_loc10_,1));
                  }
               }
            }
         }
         if(PlayerSkillManager.obf_y_V_1989)
         {
            for(_loc12_ in PlayerSkillManager.obf_y_V_1989)
            {
               _loc13_ = SkillConfig.getSkillConfig(_loc12_);
               if(JSONUtil.getInt(_loc13_,["type"]) != obf_M_F_3694.obf_u_8_4559)
               {
                  this.obf_d_y_3738(IconItemSkill.getNewIconItem(_loc12_,PlayerSkillManager.obf_y_V_1989[_loc12_]));
               }
            }
         }
         var _loc7_:Object = obf_K_e_3075.fateSkillUI.fateSkillMap;
         for(_loc8_ in _loc7_)
         {
            _loc14_ = SkillConfig.getSkillConfig(_loc8_);
            if(_loc14_)
            {
               if(JSONUtil.getInt(_loc14_,["type"]) != obf_M_F_3694.obf_u_8_4559)
               {
                  this.obf_d_y_3738(IconItemSkill.getNewIconItem(_loc8_,_loc7_[_loc8_]));
               }
            }
         }
      }
      
      public function refreshSkillPoint() : void
      {
         txtSkillPoint.text = PlayerSkillManager.getOverSkillPoint() + "";
      }
      
      public function obf_d_y_3738(param1:IconItemSkill) : void
      {
         var _loc2_:IconItemBag = null;
         var _loc3_:Object = null;
         if(!param1)
         {
            return;
         }
         for each(_loc2_ in this.obf_C_0_1218)
         {
            if(_loc2_)
            {
               if(!_loc2_.haveIconItem)
               {
                  _loc3_ = SkillConfig.getSkillConfig(param1.itemCode);
                  if(_loc3_)
                  {
                     _loc2_.lockDrag = JSONUtil.getInt(_loc3_,["type"]) == obf_M_F_3694.obf_u_8_4559;
                     _loc2_.pushIconItem(param1);
                     return;
                  }
               }
            }
         }
      }
      
      public function setDefaultSkill(param1:String) : void
      {
         var _loc2_:int = PlayerSkillManager.getSkillLevel(param1);
         var _loc3_:IconItemSkill = IconItemSkill.getNewIconItem(param1,_loc2_);
         if(_loc3_)
         {
            this.defaultSkill.dropIconItem();
            this.defaultSkill.pushIconItem(_loc3_);
         }
      }
      
      public function setJob(param1:int) : void
      {
         var _loc7_:String = null;
         var _loc8_:* = undefined;
         var _loc9_:TableButton = null;
         var _loc10_:obf_b_5_962 = null;
         var _loc2_:int = 0;
         while(_loc2_ < 7)
         {
            if(this["jobSkill_" + _loc2_])
            {
               if(this.contains(this["jobSkill_" + _loc2_]))
               {
                  this.removeChild(this["jobSkill_" + _loc2_]);
               }
            }
            _loc2_++;
         }
         this.obf_0_2_u_63 = this["jobSkill_" + param1];
         if(!this.obf_0_2_u_63)
         {
            return;
         }
         var _loc3_:int = param1 * 2;
         while(_loc3_ < param1 * 2 + 2)
         {
            _loc8_ = _loc3_;
            if(_loc3_ == 10)
            {
               _loc8_ = "a";
            }
            if(_loc3_ == 11)
            {
               _loc8_ = "b";
            }
            if(_loc3_ == 10 || _loc3_ == 11)
            {
               this.obf_0_2_u_63["z" + _loc8_ + "y"].visible = !WorldConfig.getValue("functionSwitch","ultimateSkill");
               this.obf_0_2_u_63["z" + _loc8_ + "z"].visible = !WorldConfig.getValue("functionSwitch","ultimateSkill");
            }
            _loc3_++;
         }
         this.obf_0_2_u_63.scrollRect = null;
         this.obf_l_i_4037 = this.obf_0_2_u_63.width;
         obf_3_B_2905.maxScrollPosition = Math.max(this.obf_0_2_u_63.height - obf_3_B_2905.height,0);
         this.addChild(this.obf_0_2_u_63);
         var _loc4_:Object = PlayerSkillManager.getSkillBookPage(param1 + "");
         if(!_loc4_)
         {
            return;
         }
         this.treePages = new Array();
         var _loc5_:Array = PlayerSkillManager.getJobSkillTree(param1);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc9_ = new TableButton();
            _loc9_.width = 80;
            _loc9_.txtLabel.text = _loc5_[_loc6_];
            _loc9_.gotoAndStop(1);
            _loc9_.index = _loc6_;
            _loc9_.x = pointTreePage.width;
            _loc9_.addEventListener(MouseEvent.CLICK,this.obf_c_8_824);
            pointTreePage.addChild(_loc9_);
            this.treePages.push(_loc9_);
            _loc6_++;
         }
         this.currentTreeIndex = 0;
         this.obf_0___g_367 = new Object();
         this.obf_0___Y_275 = new Array();
         for(_loc7_ in _loc4_)
         {
            if(this.obf_0_2_u_63[_loc7_])
            {
               _loc10_ = new obf_b_5_962(this.obf_0_2_u_63[_loc7_],this,_loc4_[_loc7_]);
               _loc10_.addEventListener(obf_b_5_962.obf_F_c_4296,this.obf_B_D_1521);
               this.obf_0___Y_275.push(_loc10_.iconBag);
               this.obf_0___g_367[_loc4_[_loc7_]] = _loc10_;
            }
         }
         this.obf_0_0_F_676();
         if(Boolean(this._noviceSprite) && this.contains(this._noviceSprite))
         {
            this.setChildIndex(this._noviceSprite,this.numChildren - 1);
         }
      }
      
      private function obf_B_D_1521(param1:Event) : void
      {
         var _loc2_:obf_b_5_962 = param1.currentTarget as obf_b_5_962;
         if(!_loc2_)
         {
            return;
         }
         if(PlayerSkillManager.getOverSkillPoint() < 1)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("SkillBookUI","promptNoMoreSkillPoint"));
            return;
         }
         var _loc3_:Object = PlayerSkillManager.getUpSkillCondition(_loc2_.itemCode,PlayerSkillManager.getSkillLevel(_loc2_.itemCode) + 1);
         if(ConditionScript.checkCondition(_loc3_,null,true))
         {
            PlayerSkillManager.sendLearnSkill(_loc2_.itemCode,PlayerSkillManager.obf_c_c_4538);
         }
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function getIconItemBags() : Array
      {
         return this.obf_C_0_1218.concat(this.obf_0___Y_275,this.defaultSkill);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var skillBag:IconItemBag = null;
         var otherBag:IconItemBag = null;
         var thisCmd:TableButton = null;
         this.removeListener();
         for each(skillBag in this.obf_0___Y_275)
         {
            if(skillBag)
            {
               skillBag.destroy();
            }
         }
         for each(otherBag in this.obf_C_0_1218)
         {
            if(otherBag)
            {
               otherBag.destroy();
            }
         }
         this.defaultSkill.destroy();
         for each(thisCmd in this.treePages)
         {
            try
            {
               thisCmd.removeEventListener(MouseEvent.CLICK,this.obf_c_8_824);
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         if(!param1 || !param1.haveIconItem)
         {
            return;
         }
         if(param1.haveIconItem.itemType == GameItemType.SKILL && PlayerSkillManager.skillCanAutoCast(param1.haveIconItem.itemCode))
         {
            PlayerSkillManager.setAutoSkills([param1.haveIconItem.itemCode],!PlayerSkillManager.skillIsAuto(param1.haveIconItem.itemCode));
            PlayerSkillManager.obf_G_D_4059();
         }
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         var _loc4_:IconItemSkill = null;
         if(!param1)
         {
            return;
         }
         if(param1 == this.defaultSkill && param2 is IconItemSkill)
         {
            _loc4_ = param2 as IconItemSkill;
            PlayerSkillManager.setDefaultAttackSkill(_loc4_.itemCode);
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

