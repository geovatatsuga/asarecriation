package obf_0_3_P_222
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.skill.SkillManager;
   import com.sunweb.game.rpg.skill.obf_l_l_940;
   import com.sunweb.game.rpg.sound.obf_q_6_3634;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.FateSkillUIMC;
   
   public class FateSkillUI extends FateSkillUIMC implements IIconItemUI, obf_0_d_4341
   {
      
      private var bags:Array;
      
      private var obf_2_g_2317:String;
      
      private var obf_H_i_805:int;
      
      private var _currentSkillPoint:int;
      
      private var fateSkillMCMap:Object;
      
      public var fateSkillMap:Object;
      
      private var _noviceSprite:Sprite;
      
      public function FateSkillUI()
      {
         var _loc2_:String = null;
         var _loc3_:IconItemBag = null;
         var _loc4_:MovieClip = null;
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         obf_n_J_1794.mouseEnabled = false;
         obf_n_J_1794.visible = false;
         this.bags = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc3_ = new IconItemBag(this["bag" + _loc1_],this,_loc1_);
            _loc3_.lockDrag = true;
            _loc3_.addValidType(GameItemType.ALL);
            this.bags.push(_loc3_);
            _loc1_++;
         }
         this.fateSkillMCMap = new Object();
         for each(_loc2_ in obf_l_l_940.fateSkillCodes)
         {
            _loc4_ = this.getChildByName(_loc2_) as MovieClip;
            if(_loc4_)
            {
               this.fateSkillMCMap[_loc2_] = _loc4_;
            }
         }
         this.obf_9_x_2484();
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"FateSkillUI","txtTitle");
         DiversityManager.setTextField(txtDeyCurrentFateLevel,"FateSkillUI","txtCurrentSkill");
         DiversityManager.setTextField(txtDeyNextFateLevel,"FateSkillUI","txtNextSkill");
         DiversityManager.setTextField(txtDeyTopFateLevel,"FateSkillUI","txtTopSkill");
         DiversityManager.setTextField(txtDeyNeedPlayerLevel,"FateSkillUI","txtNeedPlayerLevel");
         DiversityManager.setTextField(txtDeyNeedFateSkill,"FateSkillUI","txtNeedFateSkill");
         DiversityManager.setTextField(txtDeyNeedGold,"FateSkillUI","txtNeedGold");
         DiversityManager.setTextField(txtDeyNeedExp,"FateSkillUI","txtNeedExp");
         DiversityManager.setTextField(txtDeyNeedItems,"FateSkillUI","txtNeedItem");
         cmdUpFateSkill.label = DiversityManager.getString("FateSkillUI","cmdUpFateSkill");
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
         return "FateSkillUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         var _loc2_:DisplayObject = this.getChildByName(param1);
         if(!_loc2_)
         {
            return null;
         }
         return new Point(_loc2_.x,_loc2_.y);
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         return this.getChildByName(param1);
      }
      
      private function addListener() : void
      {
         var _loc1_:MovieClip = null;
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdUpFateSkill.addEventListener(MouseEvent.CLICK,this.obf_p_S_3080);
         for each(_loc1_ in this.fateSkillMCMap)
         {
            if(_loc1_)
            {
               _loc1_.addEventListener(MouseEvent.CLICK,this.obf_g_f_2910);
            }
         }
         obf_K_e_3075.addUIMouseToolTip(txtFateLevelPoint,"FateSkill_LevelPoint");
      }
      
      private function removeListener() : void
      {
         var _loc1_:MovieClip = null;
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdUpFateSkill.removeEventListener(MouseEvent.CLICK,this.obf_p_S_3080);
         for each(_loc1_ in this.fateSkillMCMap)
         {
            if(_loc1_)
            {
               _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_g_f_2910);
            }
         }
         obf_K_e_3075.removeUIMouseToolTip(txtFateLevelPoint);
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
      
      private function obf_g_f_2910(param1:Event) : void
      {
         this.selectFateSkill(param1.currentTarget.name);
      }
      
      private function obf_p_S_3080(param1:Event) : void
      {
         var _loc2_:Object = SkillConfig.getSkillConfig(this.obf_2_g_2317);
         var _loc3_:Object = JSONUtil.getObject(_loc2_,["levelInfo",this.obf_H_i_805]);
         if(!_loc3_)
         {
            return;
         }
         if(!ConditionScript.checkCondition(JSONUtil.getObject(_loc3_,["learnRule","condition"]),null,true))
         {
            return;
         }
         PlayerSkillManager.sendLearnSkill(this.obf_2_g_2317,PlayerSkillManager.obf_0_6_5_187);
         obf_q_6_3634.obf_e_J_1876("fateSkill@fs9",1);
      }
      
      public function obf_3_4_1172() : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:MovieClip = null;
         var _loc1_:String = this.obf_2_g_2317;
         this.obf_9_x_2484();
         obf_n_J_1794.visible = false;
         this.fateSkillMap = new Object();
         this._currentSkillPoint = 0;
         for(_loc2_ in this.fateSkillMCMap)
         {
            _loc4_ = this.fateSkillMCMap[_loc2_] as MovieClip;
            _loc5_ = SkillConfig.getSkillConfig(_loc2_);
            if(!(!_loc4_ || !_loc5_))
            {
               _loc6_ = PlayerSkillManager.getSkillLevel(_loc2_);
               _loc7_ = JSONUtil.getObject(_loc5_,["levelInfo",_loc6_,"learnRule","condition"]);
               this._currentSkillPoint += obf_l_l_940.getFateLevelPoint(_loc2_,_loc6_);
               if(_loc6_ > 0)
               {
                  _loc4_.gotoAndStop("Lv" + _loc6_);
                  this.fateSkillMap[_loc2_] = _loc6_;
               }
               else if(!_loc7_ || ConditionScript.obf_H_E_2430(_loc7_,"hasAllSkillLevel"))
               {
                  _loc4_.gotoAndStop("none");
               }
               else
               {
                  _loc4_.gotoAndStop("hide");
               }
               _loc8_ = _loc4_.SkillUp;
               if(_loc8_)
               {
                  _loc8_.visible = !_loc7_ || ConditionScript.obf_H_E_2430(_loc7_,"hasAllSkillLevel") && ConditionScript.obf_H_E_2430(_loc7_,"roleLevel>=");
               }
            }
         }
         _loc3_ = this._currentSkillPoint / obf_l_l_940.totalFateLevelPoint * 100;
         barFateLevelPoint.gotoAndStop(_loc3_);
         DiversityManager.setTextField(txtFateLevelPoint,"FateSkillUI","txtFatePoint",[this._currentSkillPoint,obf_l_l_940.totalFateLevelPoint],true);
         if(!obf_L_l_4100.isEmpty(_loc1_))
         {
            this.selectFateSkill(_loc1_);
         }
      }
      
      public function get currentSkillPoint() : int
      {
         return this._currentSkillPoint;
      }
      
      public function selectFateSkill(param1:String) : void
      {
         var _loc2_:MovieClip = this.fateSkillMCMap[param1];
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = PlayerSkillManager.getSkillLevel(param1);
         this.showFateSkill(param1,_loc3_);
         obf_n_J_1794.x = _loc2_.x;
         obf_n_J_1794.y = _loc2_.y;
         obf_n_J_1794.visible = true;
      }
      
      public function showFateSkill(param1:String, param2:int) : void
      {
         var _loc8_:String = null;
         var _loc9_:Object = null;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc12_:IconItem = null;
         var _loc13_:IconItemBag = null;
         this.obf_9_x_2484();
         var _loc3_:Object = SkillConfig.getSkillConfig(param1);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:Object = JSONUtil.getObject(_loc3_,["levelInfo",param2 - 1]);
         if(_loc4_)
         {
            txtCurrentFateLevel.text = _loc3_.name + " Lv" + param2;
            txtCurrentFateSkill.htmlText = _loc4_.detail;
         }
         var _loc5_:Object = JSONUtil.getObject(_loc3_,["levelInfo",param2]);
         if(!_loc5_)
         {
            return;
         }
         txtNextFateLevel.text = _loc3_.name + " Lv" + (param2 + 1);
         txtNextFateSkill.htmlText = _loc5_.detail;
         var _loc6_:Object = JSONUtil.getObject(_loc3_,["levelInfo",_loc3_.levelInfo.length - 1]);
         txtTopFateSkill.htmlText = _loc6_.detail;
         txtNeedPlayerLevel.text = JSONUtil.getInt(_loc5_,["learnRule","condition","roleLevel>="],1) + "";
         var _loc7_:Object = JSONUtil.getObject(_loc5_,["learnRule","condition","hasAllSkillLevel"]);
         var _loc14_:int = 0;
         var _loc15_:* = _loc7_;
         for(_loc8_ in _loc15_)
         {
            txtNeedFateSkill.text = SkillManager.getSkillName(_loc8_) + " Lv" + _loc7_[_loc8_];
         }
         pointGold.addChild(obf_a_f_2935.getGoldDisplay(JSONUtil.getInt(_loc5_,["learnRule","condition","gold>="])));
         txtNeedExp.text = JSONUtil.getInt(_loc5_,["learnRule","condition","sp>="]) + "";
         _loc9_ = JSONUtil.getObject(_loc5_,["learnRule","condition","itemsInBag"]);
         _loc10_ = 0;
         for(_loc11_ in _loc9_)
         {
            _loc12_ = IconItemManager.getIconItemByCode(_loc11_,"");
            if(_loc12_)
            {
               _loc12_.itemCount = _loc9_[_loc11_];
               if(_loc10_ >= this.bags.length)
               {
                  break;
               }
               _loc13_ = this.bags[_loc10_];
               _loc13_.pushIconItem(_loc12_);
               _loc10_++;
            }
         }
         obf_C_d_1907.update();
         this.obf_2_g_2317 = param1;
         this.obf_H_i_805 = param2;
         cmdUpFateSkill.enabled = true;
      }
      
      public function obf_9_x_2484() : void
      {
         var _loc1_:IconItemBag = null;
         this.obf_2_g_2317 = "";
         this.obf_H_i_805 = 0;
         for each(_loc1_ in this.bags)
         {
            _loc1_.dropIconItem();
         }
         while(pointGold.numChildren > 0)
         {
            pointGold.removeChildAt(0);
         }
         txtCurrentFateLevel.text = "";
         txtNextFateLevel.text = "";
         txtCurrentFateSkill.htmlText = "";
         txtNextFateSkill.htmlText = "";
         txtTopFateSkill.htmlText = "";
         txtNeedPlayerLevel.text = "";
         txtNeedFateSkill.text = "";
         txtNeedExp.text = "";
         cmdUpFateSkill.enabled = false;
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
         this.obf_3_4_1172();
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
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

