package obf_e_7_2635
{
   import ControlClass.MJCheckBox;
   import obf_r_4635.obf_R_6_1363;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemExpendable;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.managers.ButtonToItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.world.MonsterInfoUtil;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import com.sunweb.game.utils.obf_l_y_733;
   import fl.data.DataProvider;
   import fl.events.ScrollEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import playerUI.BotUIMC;
   
   public class BotUI extends BotUIMC implements IIconItemUI, obf_0_d_4341
   {
      
      private const rangePage:int = 500;
      
      private var _bags:Array;
      
      private var skillBags:Array;
      
      private var hpPercentItemBags:Array;
      
      private var mpPercentItemBags:Array;
      
      private var petHpPercentItemBags:Array;
      
      private var petMpPercentItemBags:Array;
      
      private var timeUseBags:Array;
      
      public var sIndex:int;
      
      private var _noviceSprite:Sprite;
      
      private var timeInv:TimeLimiter;
      
      public function BotUI()
      {
         var _loc5_:MovieClip = null;
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         var _loc8_:MovieClip = null;
         var _loc9_:IconItemBag = null;
         var _loc10_:IconItemBag = null;
         var _loc11_:IconItemBag = null;
         var _loc12_:IconItemBag = null;
         var _loc13_:MovieClip = null;
         var _loc14_:IconItemBag = null;
         var _loc15_:MovieClip = null;
         var _loc16_:IconItemBag = null;
         this.timeInv = new TimeLimiter(1000);
         super();
         this.initDiversity();
         if(!ButtonToItemManager.getBTIConfig("addRobotTime"))
         {
            chkAutoAddBotTime.visible = false;
         }
         if(!ButtonToItemManager.getBTIConfig("addPlayerDbExp"))
         {
            chkAutoAddPlayerExp.visible = false;
         }
         if(!ButtonToItemManager.getBTIConfig("addPetDbExp"))
         {
            chkAutoAddPetExp.visible = false;
         }
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         inputHpPercent.text = obf_R_6_1363.hpPercentToUseItem + "";
         inputMpPercent.text = obf_R_6_1363.mpPercentToUseItem + "";
         inputPetHpPercent.text = obf_R_6_1363.petHpPercentToUseItem + "";
         inputPetMpPercent.text = obf_R_6_1363.petMpPercentToUseItem + "";
         chkPickUpAll.selected = true;
         this._bags = new Array();
         this.hpPercentItemBags = new Array();
         this.mpPercentItemBags = new Array();
         this.petHpPercentItemBags = new Array();
         this.petMpPercentItemBags = new Array();
         var _loc1_:int = 1;
         while(_loc1_ <= 2)
         {
            _loc5_ = this["bagHpPercent" + _loc1_] as MovieClip;
            if(_loc5_)
            {
               _loc9_ = new IconItemBag(_loc5_,this,0);
               _loc9_.addValidType(GameItemType.EXPENDABLE | GameItemType.SKILL);
               this.hpPercentItemBags.push(_loc9_);
               this._bags.push(_loc9_);
            }
            _loc6_ = this["bagMpPercent" + _loc1_] as MovieClip;
            if(_loc6_)
            {
               _loc10_ = new IconItemBag(_loc6_,this,0);
               _loc10_.addValidType(GameItemType.EXPENDABLE | GameItemType.SKILL);
               this.mpPercentItemBags.push(_loc10_);
               this._bags.push(_loc10_);
            }
            _loc7_ = this["bagPetHpPercent" + _loc1_] as MovieClip;
            if(_loc7_)
            {
               _loc11_ = new IconItemBag(_loc7_,this,0);
               _loc11_.addValidType(GameItemType.EXPENDABLE | GameItemType.SKILL);
               this.petHpPercentItemBags.push(_loc11_);
               this._bags.push(_loc11_);
            }
            _loc8_ = this["bagPetMpPercent" + _loc1_] as MovieClip;
            if(_loc8_)
            {
               _loc12_ = new IconItemBag(_loc8_,this,0);
               _loc12_.addValidType(GameItemType.EXPENDABLE | GameItemType.SKILL);
               this.petMpPercentItemBags.push(_loc12_);
               this._bags.push(_loc12_);
            }
            _loc1_++;
         }
         this.skillBags = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            _loc13_ = this["bagSkill" + _loc2_];
            if(_loc13_)
            {
               _loc14_ = new IconItemBag(_loc13_,this,_loc2_);
               _loc14_.addValidType(GameItemType.SKILL);
               this.skillBags.push(_loc14_);
               this._bags.push(_loc14_);
            }
            _loc2_++;
         }
         this.timeUseBags = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < 4)
         {
            _loc15_ = this["bagTimeUse" + _loc3_];
            if(_loc15_)
            {
               _loc16_ = new IconItemBag(_loc15_,this,_loc3_);
               _loc16_.addValidType(GameItemType.ALL);
               this.timeUseBags.push(_loc16_);
               this._bags.push(_loc16_);
            }
            _loc3_++;
         }
         scrollBotRadius.minScrollPosition = 1;
         scrollBotRadius.maxScrollPosition = 3;
         scrollBotRadius.pageSize = 1;
         DiversityManager.setTextField(txtBotRadius,"BotUI","txtRange",[int(obf_R_6_1363.botRadius / this.rangePage)],true);
         var _loc4_:Array = [{
            "label":DiversityManager.getString("BotUI","pickUpRank_Lv1"),
            "data":[GameItemRank.NOMAL,GameItemRank.MAGIC,GameItemRank.LEGEND,GameItemRank.FANTASY,GameItemRank.EPIC,GameItemRank.obf_f_l_943,GameItemRank.obf_C_G_3598]
         },{
            "label":DiversityManager.getString("BotUI","pickUpRank_Lv2"),
            "data":[GameItemRank.MAGIC,GameItemRank.FANTASY,GameItemRank.LEGEND,GameItemRank.EPIC,GameItemRank.obf_f_l_943,GameItemRank.obf_C_G_3598]
         },{
            "label":DiversityManager.getString("BotUI","pickUpRank_Lv3"),
            "data":[GameItemRank.FANTASY,GameItemRank.LEGEND,GameItemRank.EPIC,GameItemRank.obf_f_l_943,GameItemRank.obf_C_G_3598]
         },{
            "label":DiversityManager.getString("BotUI","pickUpRank_Lv4"),
            "data":[GameItemRank.LEGEND,GameItemRank.EPIC,GameItemRank.obf_f_l_943,GameItemRank.obf_C_G_3598]
         },{
            "label":DiversityManager.getString("BotUI","pickUpRank_Lv5"),
            "data":[GameItemRank.EPIC,GameItemRank.obf_f_l_943,GameItemRank.obf_C_G_3598]
         }];
         listEquipRank.dataProvider = new DataProvider(_loc4_);
         listEquipRank.selectedIndex = 0;
         listOtherRank.dataProvider = new DataProvider(_loc4_);
         listOtherRank.selectedIndex = 0;
         listCallAnimalSkill.dataProvider = new DataProvider([DiversityManager.getString("BotUI","null")]);
         listCallAnimalSkill.selectedIndex = 0;
         scrollMonsterList.pageSize = scrollMonsterList.height;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"BotUI","txtTitle");
         DiversityManager.setTextField(txtDeyMapMonster,"BotUI","txtMapMonsterList");
         DiversityManager.setTextField(txtDeyHpPercentUse,"BotUI","txtPercentUse");
         DiversityManager.setTextField(txtDeyMpPercentUse,"BotUI","txtPercentUse");
         DiversityManager.setTextField(txtDeyPetHpPercentUse,"BotUI","txtPercentUse");
         DiversityManager.setTextField(txtDeyPetMpPercentUse,"BotUI","txtPercentUse");
         DiversityManager.setTextField(txtUseItemPrompt,"BotUI","txtUseItemPrompt");
         DiversityManager.setTextField(txtDeyBotRadius,"BotUI","txtBotRadius");
         DiversityManager.setTextField(txtDeySkill,"BotUI","txtSkill");
         DiversityManager.setTextField(txtDeyPickUp,"BotUI","txtPickUp");
         DiversityManager.setTextField(txtDeyTimeLeft1,"BotUI","txtTimeLeft1");
         DiversityManager.setTextField(txtDeyTimeLeft2,"BotUI","txtTimeLeft2");
         DiversityManager.setTextField(txtDeyPrompt1,"BotUI","txtPrompt1");
         DiversityManager.setTextField(txtDeyPrompt2,"BotUI","txtPrompt2");
         DiversityManager.setTextField(txtDeyTimeUse,"BotUI","txtTimeUse");
         DiversityManager.setTextField(txtDeyTimeUse0,"BotUI","txtTimeUseM");
         DiversityManager.setTextField(txtDeyTimeUse1,"BotUI","txtTimeUseM");
         DiversityManager.setTextField(txtDeyTimeUse2,"BotUI","txtTimeUseM");
         DiversityManager.setTextField(txtDeyTimeUse3,"BotUI","txtTimeUseM");
         DiversityManager.setTextField(txtDeyAntoAnimal,"BotUI","txtDeyAntoAnimal");
         cmdRefreshMonster.label = DiversityManager.getString("BotUI","cmdRefreshMonster");
         cmdAddBotTime.label = DiversityManager.getString("BotUI","cmdBotTime");
         cmdBotAction.label = DiversityManager.getString("BotUI","cmdStartBot");
         chkHpPercent.label = DiversityManager.getString("BotUI","chkHpPercent");
         chkMpPercent.label = DiversityManager.getString("BotUI","chkMpPercent");
         chkPetHpPercent.label = DiversityManager.getString("BotUI","chkPetHpPercent");
         chkPetMpPercent.label = DiversityManager.getString("BotUI","chkPetMpPercent");
         chkPickUpAll.label = DiversityManager.getString("BotUI","chkPickUpAll");
         chkPickUpEquip.label = DiversityManager.getString("BotUI","chkPickUpEquip");
         chkPickUpOther.label = DiversityManager.getString("BotUI","chkPickUpOther");
         chkAutoRepairEquip.label = DiversityManager.getString("BotUI","chkAutoRepairEquip");
         chkAutoPerfectRepair.label = DiversityManager.getString("BotUI","chkAutoPerfectRepair");
         chkAutoAddBotTime.label = DiversityManager.getString("BotUI","chkAutoAddBotTime");
         chkAutoAddPlayerExp.label = DiversityManager.getString("BotUI","chkAutoAddPlayerExp");
         chkAutoAddPetExp.label = DiversityManager.getString("BotUI","chkAutoAddPetExp");
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
         return "BotUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         var _loc2_:DisplayObject = this[param1];
         if(!_loc2_)
         {
            return null;
         }
         return new Point(_loc2_.x + _loc2_.width / 2,_loc2_.y + _loc2_.height / 2);
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         return JSONUtil.getObject(this,[param1]) as DisplayObject;
      }
      
      public function saveConfig() : void
      {
         var _loc1_:Object = new Object();
         _loc1_.are = obf_R_6_1363.autoRepairEqu;
         _loc1_.aps = obf_R_6_1363.autoPerfectRepairEqu;
         _loc1_.abt = obf_R_6_1363.autoAddBotTime;
         _loc1_.ape = obf_R_6_1363.autoAddPlayerExpTime;
         _loc1_.app = obf_R_6_1363.autoAddPetExpTime;
         _loc1_.brr = obf_R_6_1363.botRadius;
         _loc1_.hpp = obf_R_6_1363.hpPercentToUseItem;
         _loc1_.hpi = obf_R_6_1363.hpPercentItemsCode;
         _loc1_.hpe = obf_R_6_1363.enabledHpPercentItem;
         _loc1_.mpp = obf_R_6_1363.mpPercentToUseItem;
         _loc1_.mpi = obf_R_6_1363.mpPercentItemsCode;
         _loc1_.mpe = obf_R_6_1363.enabledMpPercentItem;
         _loc1_.phpp = obf_R_6_1363.petHpPercentToUseItem;
         _loc1_.phpi = obf_R_6_1363.petHpPercentItemsCode;
         _loc1_.phpe = obf_R_6_1363.enabledPetHpPercentItem;
         _loc1_.pmpp = obf_R_6_1363.petMpPercentToUseItem;
         _loc1_.pmpi = obf_R_6_1363.petMpPercentItemsCode;
         _loc1_.pmpe = obf_R_6_1363.enabledPetMpPercentItem;
         _loc1_.ask = obf_R_6_1363.useSkills;
         _loc1_.tou = obf_R_6_1363.timeToUse;
         _loc1_.pia = chkPickUpAll.selected;
         _loc1_.pie = chkPickUpEquip.selected;
         _loc1_.pio = chkPickUpOther.selected;
         _loc1_.per = listEquipRank.selectedIndex;
         _loc1_.por = listOtherRank.selectedIndex;
         _loc1_.call = listCallAnimalSkill.selectedIndex;
         GameContext.userConfig.bot = _loc1_;
         GameContext.saveConfig();
      }
      
      public function useUserConfig() : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc9_:Object = null;
         var _loc20_:IconItem = null;
         var _loc21_:IconItem = null;
         var _loc22_:IconItem = null;
         var _loc23_:IconItem = null;
         var _loc24_:int = 0;
         var _loc25_:IconItemSkill = null;
         var _loc26_:int = 0;
         var _loc27_:Object = null;
         var _loc28_:IconItem = null;
         var _loc1_:Array = WorldConfig.getValue("botConfig","playerHpItems") as Array;
         obf_R_6_1363.autoHpPercentItems = new Array();
         for each(_loc2_ in _loc1_)
         {
            obf_R_6_1363.autoHpPercentItems.push({
               "type":GameItemType.EXPENDABLE,
               "code":_loc2_
            });
         }
         _loc3_ = WorldConfig.getValue("botConfig","playerMpItems") as Array;
         obf_R_6_1363.autoMpPercentItems = new Array();
         for each(_loc4_ in _loc3_)
         {
            obf_R_6_1363.autoMpPercentItems.push({
               "type":GameItemType.EXPENDABLE,
               "code":_loc4_
            });
         }
         _loc5_ = WorldConfig.getValue("botConfig","petHpItems") as Array;
         obf_R_6_1363.autoPetHpPercentItems = new Array();
         for each(_loc6_ in _loc5_)
         {
            obf_R_6_1363.autoPetHpPercentItems.push({
               "type":GameItemType.EXPENDABLE,
               "code":_loc6_
            });
         }
         _loc7_ = WorldConfig.getValue("botConfig","petMpItems") as Array;
         obf_R_6_1363.autoPetMpPercentItems = new Array();
         for each(_loc8_ in _loc7_)
         {
            obf_R_6_1363.autoPetMpPercentItems.push({
               "type":GameItemType.EXPENDABLE,
               "code":_loc8_
            });
         }
         _loc9_ = GameContext.userConfig.bot;
         if(!_loc9_)
         {
            this.setPercentUseItem();
            this.saveConfig();
            return;
         }
         obf_R_6_1363.autoRepairEqu = JSONUtil.getBoolean(_loc9_,["are"]);
         chkAutoRepairEquip.selected = obf_R_6_1363.autoRepairEqu;
         obf_R_6_1363.autoPerfectRepairEqu = JSONUtil.getBoolean(_loc9_,["aps"]);
         chkAutoPerfectRepair.selected = obf_R_6_1363.autoPerfectRepairEqu;
         obf_R_6_1363.autoAddBotTime = JSONUtil.getBoolean(_loc9_,["abt"]);
         chkAutoAddBotTime.selected = obf_R_6_1363.autoAddBotTime;
         obf_R_6_1363.autoAddPlayerExpTime = JSONUtil.getBoolean(_loc9_,["ape"]);
         chkAutoAddPlayerExp.selected = obf_R_6_1363.autoAddPlayerExpTime;
         obf_R_6_1363.autoAddPetExpTime = JSONUtil.getBoolean(_loc9_,["app"]);
         chkAutoAddPetExp.selected = obf_R_6_1363.autoAddPetExpTime;
         obf_R_6_1363.botRadius = _loc9_.brr;
         scrollBotRadius.scrollPosition = int(obf_R_6_1363.botRadius / this.rangePage);
         DiversityManager.setTextField(txtBotRadius,"BotUI","txtRange",[scrollBotRadius.scrollPosition],true);
         chkHpPercent.selected = JSONUtil.getBoolean(_loc9_,["hpe"]);
         inputHpPercent.text = JSONUtil.getStr(_loc9_,["hpp"]);
         var _loc10_:Array = JSONUtil.getObject(_loc9_,["hpi"],[]) as Array;
         var _loc11_:int = 0;
         while(_loc11_ < _loc10_.length && _loc11_ < this.hpPercentItemBags.length)
         {
            if(!obf_L_l_4100.isEmpty(_loc10_[_loc11_].code))
            {
               if(_loc10_[_loc11_].type == GameItemType.SKILL)
               {
                  _loc20_ = IconItemSkill.getNewIconItem(_loc10_[_loc11_].code,1);
               }
               else
               {
                  _loc20_ = IconItemManager.getIconItemByCode(_loc10_[_loc11_].code,"");
               }
               if(_loc20_)
               {
                  this.hpPercentItemBags[_loc11_].pushIconItem(_loc20_);
               }
            }
            _loc11_++;
         }
         chkMpPercent.selected = JSONUtil.getBoolean(_loc9_,["mpe"]);
         inputMpPercent.text = JSONUtil.getStr(_loc9_,["mpp"]);
         var _loc12_:Array = JSONUtil.getObject(_loc9_,["mpi"],[]) as Array;
         var _loc13_:int = 0;
         while(_loc13_ < _loc12_.length && _loc13_ < this.mpPercentItemBags.length)
         {
            if(!obf_L_l_4100.isEmpty(_loc12_[_loc13_].code))
            {
               if(_loc12_[_loc13_].type == GameItemType.SKILL)
               {
                  _loc21_ = IconItemSkill.getNewIconItem(_loc12_[_loc13_].code,1);
               }
               else
               {
                  _loc21_ = IconItemManager.getIconItemByCode(_loc12_[_loc13_].code,"");
               }
               if(_loc21_)
               {
                  this.mpPercentItemBags[_loc13_].pushIconItem(_loc21_);
               }
            }
            _loc13_++;
         }
         chkPetHpPercent.selected = JSONUtil.getBoolean(_loc9_,["phpe"]);
         inputPetHpPercent.text = JSONUtil.getStr(_loc9_,["phpp"]);
         var _loc14_:Array = JSONUtil.getObject(_loc9_,["phpi"],[]) as Array;
         var _loc15_:int = 0;
         while(_loc15_ < _loc14_.length && _loc15_ < this.petHpPercentItemBags.length)
         {
            if(!obf_L_l_4100.isEmpty(_loc14_[_loc15_].code))
            {
               if(_loc14_[_loc15_].type == GameItemType.SKILL)
               {
                  _loc22_ = IconItemSkill.getNewIconItem(_loc14_[_loc15_].code,1);
               }
               else
               {
                  _loc22_ = IconItemManager.getIconItemByCode(_loc14_[_loc15_].code,"");
               }
               if(_loc22_)
               {
                  this.petHpPercentItemBags[_loc15_].pushIconItem(_loc22_);
               }
            }
            _loc15_++;
         }
         chkPetMpPercent.selected = JSONUtil.getBoolean(_loc9_,["pmpe"]);
         inputPetMpPercent.text = JSONUtil.getStr(_loc9_,["pmpp"]);
         var _loc16_:Array = JSONUtil.getObject(_loc9_,["pmpi"],[]) as Array;
         var _loc17_:int = 0;
         while(_loc17_ < _loc16_.length && _loc17_ < this.petMpPercentItemBags.length)
         {
            if(!obf_L_l_4100.isEmpty(_loc16_[_loc17_].code))
            {
               if(_loc16_[_loc17_].type == GameItemType.SKILL)
               {
                  _loc23_ = IconItemSkill.getNewIconItem(_loc16_[_loc17_].code,1);
               }
               else
               {
                  _loc23_ = IconItemManager.getIconItemByCode(_loc16_[_loc17_].code,"");
               }
               if(_loc23_)
               {
                  this.petMpPercentItemBags[_loc17_].pushIconItem(_loc23_);
               }
            }
            _loc17_++;
         }
         this.setPercentUseItem();
         var _loc18_:Array = JSONUtil.getObject(_loc9_,["ask"]) as Array;
         if(_loc18_)
         {
            _loc24_ = 0;
            while(_loc24_ < _loc18_.length && _loc24_ < this.skillBags.length)
            {
               _loc25_ = IconItemSkill.getNewIconItem(_loc18_[_loc24_],1);
               if(_loc25_)
               {
                  (this.skillBags[_loc24_] as IconItemBag).pushIconItem(_loc25_);
               }
               _loc24_++;
            }
            obf_R_6_1363.setUseSkills(_loc18_);
         }
         var _loc19_:Array = JSONUtil.getObject(_loc9_,["tou"]) as Array;
         if(_loc19_)
         {
            _loc26_ = 0;
            while(_loc26_ < _loc19_.length && _loc26_ < this.timeUseBags.length)
            {
               _loc27_ = _loc19_[_loc26_];
               if(!(!_loc27_ || obf_L_l_4100.isEmpty(_loc27_.code)))
               {
                  if(_loc27_.type == GameItemType.SKILL)
                  {
                     _loc28_ = IconItemSkill.getNewIconItem(_loc27_.code,1);
                  }
                  else
                  {
                     _loc28_ = IconItemManager.getIconItemByCode(_loc27_.code,"");
                  }
                  if(_loc28_)
                  {
                     this.timeUseBags[_loc26_].pushIconItem(_loc28_);
                  }
                  this["inputTimeUse" + _loc26_].text = _loc27_.time + "";
               }
               _loc26_++;
            }
         }
         this.setTimeToUse();
         chkPickUpAll.selected = JSONUtil.getBoolean(_loc9_,["pia"],true);
         chkPickUpEquip.selected = JSONUtil.getBoolean(_loc9_,["pie"]);
         chkPickUpOther.selected = JSONUtil.getBoolean(_loc9_,["pio"]);
         listEquipRank.selectedIndex = JSONUtil.getInt(_loc9_,["per"]);
         listOtherRank.selectedIndex = JSONUtil.getInt(_loc9_,["por"]);
         this.setPickUp();
         this.sIndex = JSONUtil.getInt(_loc9_,["call"]);
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         chkAutoRepairEquip.addEventListener(MouseEvent.CLICK,this.obf_0_0_H_716);
         chkAutoPerfectRepair.addEventListener(MouseEvent.CLICK,this.obf_0_0_H_716);
         chkAutoAddBotTime.addEventListener(MouseEvent.CLICK,this.obf_0_0_H_716);
         chkAutoAddPlayerExp.addEventListener(MouseEvent.CLICK,this.obf_0_0_H_716);
         chkAutoAddPetExp.addEventListener(MouseEvent.CLICK,this.obf_0_0_H_716);
         inputHpPercent.addEventListener(Event.CHANGE,this.obf_0_4_f_480);
         inputMpPercent.addEventListener(Event.CHANGE,this.obf_0_4_f_480);
         chkHpPercent.addEventListener(MouseEvent.CLICK,this.obf_0_4_f_480);
         chkMpPercent.addEventListener(MouseEvent.CLICK,this.obf_0_4_f_480);
         inputPetHpPercent.addEventListener(Event.CHANGE,this.obf_0_4_f_480);
         inputPetMpPercent.addEventListener(Event.CHANGE,this.obf_0_4_f_480);
         chkPetHpPercent.addEventListener(MouseEvent.CLICK,this.obf_0_4_f_480);
         chkPetMpPercent.addEventListener(MouseEvent.CLICK,this.obf_0_4_f_480);
         chkPickUpAll.addEventListener(MouseEvent.CLICK,this.obf_2_s_2286);
         chkPickUpEquip.addEventListener(MouseEvent.CLICK,this.obf_2_s_2286);
         chkPickUpOther.addEventListener(MouseEvent.CLICK,this.obf_2_s_2286);
         listEquipRank.addEventListener(Event.CHANGE,this.obf_2_s_2286);
         listOtherRank.addEventListener(Event.CHANGE,this.obf_2_s_2286);
         listCallAnimalSkill.addEventListener(Event.CHANGE,this.onClickCall);
         cmdBotAction.addEventListener(MouseEvent.CLICK,this.onStartOrStopBot);
         cmdAddBotTime.addEventListener(MouseEvent.CLICK,this.obf_J_n_2989);
         cmdRefreshMonster.addEventListener(MouseEvent.CLICK,this.obf_N_f_2552);
         pointMonsterList.addEventListener(MouseEvent.CLICK,this.obf_0_S_2290);
         scrollMonsterList.addEventListener(ScrollEvent.SCROLL,this.onScrollMonsterList);
         scrollBotRadius.addEventListener(ScrollEvent.SCROLL,this.obf_9_S_3424);
         inputTimeUse0.addEventListener(Event.CHANGE,this.obf_u_Y_1637);
         inputTimeUse1.addEventListener(Event.CHANGE,this.obf_u_Y_1637);
         inputTimeUse2.addEventListener(Event.CHANGE,this.obf_u_Y_1637);
         inputTimeUse3.addEventListener(Event.CHANGE,this.obf_u_Y_1637);
         inputHpPercent.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputHpPercent.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputMpPercent.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputMpPercent.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputPetHpPercent.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputPetHpPercent.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputPetMpPercent.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputPetMpPercent.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputTimeUse0.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputTimeUse0.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputTimeUse1.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputTimeUse1.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputTimeUse2.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputTimeUse2.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputTimeUse3.addEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputTimeUse3.addEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         chkAutoRepairEquip.removeEventListener(MouseEvent.CLICK,this.obf_0_0_H_716);
         chkAutoPerfectRepair.removeEventListener(MouseEvent.CLICK,this.obf_0_0_H_716);
         chkAutoAddBotTime.removeEventListener(MouseEvent.CLICK,this.obf_0_0_H_716);
         chkAutoAddPlayerExp.removeEventListener(MouseEvent.CLICK,this.obf_0_0_H_716);
         chkAutoAddPetExp.removeEventListener(MouseEvent.CLICK,this.obf_0_0_H_716);
         inputHpPercent.removeEventListener(Event.CHANGE,this.obf_0_4_f_480);
         inputMpPercent.removeEventListener(Event.CHANGE,this.obf_0_4_f_480);
         chkHpPercent.removeEventListener(MouseEvent.CLICK,this.obf_0_4_f_480);
         chkMpPercent.removeEventListener(MouseEvent.CLICK,this.obf_0_4_f_480);
         inputPetHpPercent.removeEventListener(Event.CHANGE,this.obf_0_4_f_480);
         inputPetMpPercent.removeEventListener(Event.CHANGE,this.obf_0_4_f_480);
         chkPetHpPercent.removeEventListener(MouseEvent.CLICK,this.obf_0_4_f_480);
         chkPetMpPercent.removeEventListener(MouseEvent.CLICK,this.obf_0_4_f_480);
         chkPickUpAll.removeEventListener(MouseEvent.CLICK,this.obf_2_s_2286);
         chkPickUpEquip.removeEventListener(MouseEvent.CLICK,this.obf_2_s_2286);
         chkPickUpOther.removeEventListener(MouseEvent.CLICK,this.obf_2_s_2286);
         listEquipRank.removeEventListener(Event.CHANGE,this.obf_2_s_2286);
         listOtherRank.removeEventListener(Event.CHANGE,this.obf_2_s_2286);
         listCallAnimalSkill.removeEventListener(Event.CHANGE,this.onClickCall);
         cmdBotAction.removeEventListener(MouseEvent.CLICK,this.onStartOrStopBot);
         cmdAddBotTime.removeEventListener(MouseEvent.CLICK,this.obf_J_n_2989);
         cmdRefreshMonster.removeEventListener(MouseEvent.CLICK,this.obf_N_f_2552);
         pointMonsterList.removeEventListener(MouseEvent.CLICK,this.obf_0_S_2290);
         scrollMonsterList.removeEventListener(ScrollEvent.SCROLL,this.onScrollMonsterList);
         scrollBotRadius.removeEventListener(ScrollEvent.SCROLL,this.obf_9_S_3424);
         inputTimeUse0.removeEventListener(Event.CHANGE,this.obf_u_Y_1637);
         inputTimeUse1.removeEventListener(Event.CHANGE,this.obf_u_Y_1637);
         inputTimeUse2.removeEventListener(Event.CHANGE,this.obf_u_Y_1637);
         inputTimeUse3.removeEventListener(Event.CHANGE,this.obf_u_Y_1637);
         inputHpPercent.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputHpPercent.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputMpPercent.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputMpPercent.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputPetHpPercent.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputPetHpPercent.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputPetMpPercent.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputPetMpPercent.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputTimeUse0.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputTimeUse0.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputTimeUse1.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputTimeUse1.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputTimeUse2.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputTimeUse2.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
         inputTimeUse3.removeEventListener(KeyboardEvent.KEY_DOWN,this.obf_m_I_3657);
         inputTimeUse3.removeEventListener(KeyboardEvent.KEY_UP,this.obf_m_I_3657);
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
      
      private function obf_m_I_3657(param1:Event) : void
      {
         param1.stopPropagation();
      }
      
      private function onStartOrStopBot(param1:Event) : void
      {
         this.startOrStopBot();
      }
      
      public function startOrStopBot() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         if(!obf_R_6_1363.isRuning)
         {
            _loc1_ = obf_R_6_1363.getTimeLeftInSec();
            _loc2_ = _loc1_[0] + _loc1_[1];
            if(_loc2_ <= 0)
            {
               ButtonToItemManager.useBTIById("addRobotTime");
               return;
            }
            this.setTimeToUse();
            this.setBotMonsterList();
            obf_R_6_1363.startBot();
         }
         else
         {
            obf_R_6_1363.stopBot();
         }
      }
      
      private function obf_N_f_2552(param1:Event) : void
      {
         this.obf_N_J_4091();
      }
      
      private function obf_J_n_2989(param1:Event) : void
      {
         ButtonToItemManager.useBTIById("addRobotTime");
      }
      
      private function obf_0_0_H_716(param1:Event) : void
      {
         obf_R_6_1363.autoRepairEqu = chkAutoRepairEquip.selected;
         obf_R_6_1363.autoPerfectRepairEqu = chkAutoPerfectRepair.selected;
         obf_R_6_1363.autoAddBotTime = chkAutoAddBotTime.selected;
         obf_R_6_1363.autoAddPlayerExpTime = chkAutoAddPlayerExp.selected;
         obf_R_6_1363.autoAddPetExpTime = chkAutoAddPetExp.selected;
         this.saveConfig();
      }
      
      private function obf_0_4_f_480(param1:Event) : void
      {
         this.setPercentUseItem();
         this.saveConfig();
      }
      
      private function obf_u_Y_1637(param1:Event) : void
      {
         this.setOneTimeToUse(int(param1.currentTarget.name.charAt(param1.currentTarget.name.length)));
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(!this.timeInv.checkTimeout())
         {
            return;
         }
         var _loc2_:Array = obf_R_6_1363.getTimeLeftInSec();
         txtTimeLeft1.text = obf_l_y_733.getTimeStringSec(Math.max(_loc2_[0],0) * 1000);
         txtTimeLeft2.text = obf_l_y_733.getTimeStringSec(Math.max(_loc2_[1],0) * 1000);
      }
      
      private function obf_9_S_3424(param1:Event) : void
      {
         var _loc2_:int = Math.round(scrollBotRadius.scrollPosition);
         obf_R_6_1363.botRadius = _loc2_ * this.rangePage;
         DiversityManager.setTextField(txtBotRadius,"BotUI","txtRange",[_loc2_],true);
      }
      
      private function obf_2_s_2286(param1:Event) : void
      {
         this.setPickUp();
         this.saveConfig();
      }
      
      private function onClickCall(param1:Event) : void
      {
         this.sIndex = listCallAnimalSkill.selectedIndex;
         this.saveConfig();
      }
      
      private function obf_0_S_2290(param1:Event) : void
      {
         this.setBotMonsterList();
      }
      
      public function obf_n_E_2173() : void
      {
         var _loc1_:IconItemBag = null;
         if(!this.visible)
         {
            return;
         }
         for each(_loc1_ in this._bags)
         {
            if(_loc1_.haveIconItem)
            {
               if(_loc1_.haveIconItem is IconItemSkill)
               {
                  IconItemSkill(_loc1_.haveIconItem).level = PlayerSkillManager.getSkillLevel(_loc1_.haveIconItem.itemCode);
               }
               else
               {
                  _loc1_.haveIconItem.itemCount = obf_K_e_3075.playerBagUI.getItemCount(_loc1_.haveIconItem.itemCode);
                  if(_loc1_.haveIconItem.itemCount <= 0)
                  {
                     _loc1_.haveIconItem.countTextColor = 16711680;
                  }
                  else
                  {
                     _loc1_.haveIconItem.countTextColor = 16777215;
                  }
               }
            }
         }
      }
      
      public function setBotMonsterList() : void
      {
         var _loc3_:MJCheckBox = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < pointMonsterList.numChildren)
         {
            _loc3_ = pointMonsterList.getChildAt(_loc2_) as MJCheckBox;
            if(_loc3_)
            {
               if(!_loc3_.selected)
               {
                  _loc1_.push(_loc3_.name);
               }
            }
            _loc2_++;
         }
         obf_R_6_1363.setExcludedCodeList(_loc1_);
      }
      
      public function setUseSkill() : void
      {
         var _loc2_:IconItemBag = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.skillBags)
         {
            if(_loc2_.haveIconItem)
            {
               _loc1_.push(_loc2_.haveIconItem.itemCode);
            }
         }
         obf_R_6_1363.setUseSkills(_loc1_);
      }
      
      public function setPercentUseItem() : void
      {
         var _loc2_:IconItemBag = null;
         var _loc3_:Array = null;
         var _loc4_:IconItemBag = null;
         var _loc5_:Array = null;
         var _loc6_:IconItemBag = null;
         var _loc7_:Array = null;
         var _loc8_:IconItemBag = null;
         obf_R_6_1363.hpPercentToUseItem = int(inputHpPercent.text);
         obf_R_6_1363.mpPercentToUseItem = int(inputMpPercent.text);
         obf_R_6_1363.petHpPercentToUseItem = int(inputPetHpPercent.text);
         obf_R_6_1363.petMpPercentToUseItem = int(inputPetMpPercent.text);
         obf_R_6_1363.enabledHpPercentItem = chkHpPercent.selected;
         obf_R_6_1363.enabledMpPercentItem = chkMpPercent.selected;
         obf_R_6_1363.enabledPetHpPercentItem = chkPetHpPercent.selected;
         obf_R_6_1363.enabledPetMpPercentItem = chkPetMpPercent.selected;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.hpPercentItemBags)
         {
            if(!(!_loc2_ || !_loc2_.haveIconItem))
            {
               _loc1_.push({
                  "type":_loc2_.haveIconItem.itemType,
                  "code":_loc2_.haveIconItem.itemCode
               });
            }
         }
         obf_R_6_1363.hpPercentItemsCode = _loc1_;
         _loc3_ = new Array();
         for each(_loc4_ in this.mpPercentItemBags)
         {
            if(!(!_loc4_ || !_loc4_.haveIconItem))
            {
               _loc3_.push({
                  "type":_loc4_.haveIconItem.itemType,
                  "code":_loc4_.haveIconItem.itemCode
               });
            }
         }
         obf_R_6_1363.mpPercentItemsCode = _loc3_;
         _loc5_ = new Array();
         for each(_loc6_ in this.petHpPercentItemBags)
         {
            if(!(!_loc6_ || !_loc6_.haveIconItem))
            {
               _loc5_.push({
                  "type":_loc6_.haveIconItem.itemType,
                  "code":_loc6_.haveIconItem.itemCode
               });
            }
         }
         obf_R_6_1363.petHpPercentItemsCode = _loc5_;
         _loc7_ = new Array();
         for each(_loc8_ in this.petMpPercentItemBags)
         {
            if(!(!_loc8_ || !_loc8_.haveIconItem))
            {
               _loc7_.push({
                  "type":_loc8_.haveIconItem.itemType,
                  "code":_loc8_.haveIconItem.itemCode
               });
            }
         }
         obf_R_6_1363.petMpPercentItemsCode = _loc7_;
      }
      
      public function setTimeToUse() : void
      {
         var _loc3_:Object = null;
         var _loc4_:IconItemBag = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < this.timeUseBags.length)
         {
            _loc3_ = new Object();
            _loc4_ = this.timeUseBags[_loc2_];
            if((Boolean(_loc4_)) && Boolean(_loc4_.haveIconItem))
            {
               _loc3_.type = _loc4_.haveIconItem.itemType;
               _loc3_.code = _loc4_.haveIconItem.itemCode;
            }
            _loc3_.time = int(this["inputTimeUse" + _loc2_].text);
            _loc1_.push(_loc3_);
            _loc2_++;
         }
         obf_R_6_1363.setTimeToUseList(_loc1_);
      }
      
      public function setOneTimeToUse(param1:uint) : void
      {
         if(param1 >= this.timeUseBags.length)
         {
            return;
         }
         var _loc2_:IconItemBag = this.timeUseBags[param1];
         var _loc3_:Object = new Object();
         _loc3_.time = int(obf_L_l_4100.obf_I_C_3435(this["inputTimeUse" + param1].text));
         if(Boolean(_loc2_) && Boolean(_loc2_.haveIconItem))
         {
            _loc3_.type = _loc2_.haveIconItem.itemType;
            _loc3_.code = _loc2_.haveIconItem.itemCode;
         }
         obf_R_6_1363.setTimeToUse(_loc3_,param1);
         this.saveConfig();
      }
      
      public function setPickUp() : void
      {
         var _loc1_:int = 0;
         if(chkPickUpAll.selected)
         {
            _loc1_ = GameItemType.ALL;
         }
         if(chkPickUpEquip.selected)
         {
            _loc1_ |= GameItemType.EQUIPMENT;
         }
         if(chkPickUpOther.selected)
         {
            _loc1_ = _loc1_ | GameItemType.EXPENDABLE | GameItemType.COLLECTION;
         }
         obf_R_6_1363.pickUpItemType = _loc1_;
         if(listEquipRank.selectedItem)
         {
            obf_R_6_1363.pickUpEquipRank = listEquipRank.selectedItem.data;
         }
         if(listOtherRank.selectedItem)
         {
            obf_R_6_1363.pickUpOtherRank = listOtherRank.selectedItem.data;
         }
      }
      
      public function obf_N_J_4091() : void
      {
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:MJCheckBox = null;
         var _loc1_:Array = MapManager.instance.getMonsterCodeList();
         pointMonsterList.scrollRect = new Rectangle(0,0,scrollMonsterList.x - pointMonsterList.x,scrollMonsterList.height);
         while(pointMonsterList.numChildren > 0)
         {
            pointMonsterList.removeChildAt(0);
         }
         var _loc2_:Array = JSONUtil.getObject(obf_R_6_1363,["excludedList"],[]) as Array;
         var _loc3_:int = 0;
         var _loc4_:int = WorldConfig.getValue("botConfig","excludedBossLevel");
         for each(_loc5_ in _loc1_)
         {
            _loc6_ = MonsterInfoUtil.getMonsterInfo(_loc5_);
            if(!(_loc4_ > 0 && JSONUtil.getInt(_loc6_,["bossLevel"]) >= _loc4_))
            {
               _loc7_ = new MJCheckBox();
               _loc7_.name = _loc5_;
               _loc7_.label = MonsterInfoUtil.getMonsterName(_loc5_);
               _loc7_.selected = _loc2_.indexOf(_loc5_) == -1;
               _loc7_.width = scrollMonsterList.x - pointMonsterList.x;
               _loc7_.y = pointMonsterList.numChildren * 20;
               pointMonsterList.addChild(_loc7_);
               _loc3_ = _loc7_.y + 20;
            }
         }
         scrollMonsterList.maxScrollPosition = 0;
         if(_loc3_ > scrollMonsterList.height)
         {
            scrollMonsterList.maxScrollPosition = _loc3_ - scrollMonsterList.height;
         }
      }
      
      private function onScrollMonsterList(param1:Event) : void
      {
         pointMonsterList.scrollRect = new Rectangle(0,scrollMonsterList.scrollPosition,scrollMonsterList.x - pointMonsterList.x,scrollMonsterList.height);
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
         this.obf_N_J_4091();
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.obf_n_E_2173();
      }
      
      public function getIconItemBags() : Array
      {
         return this._bags;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this._bags)
         {
            _loc1_.destroy();
         }
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         if(!param1)
         {
            return;
         }
         if(param2 is IconItemExpendable || param2 is IconItemSkill)
         {
            if(this.hpPercentItemBags.indexOf(param1) > -1 || this.mpPercentItemBags.indexOf(param1) > -1 || this.petMpPercentItemBags.indexOf(param1) > -1 || this.petHpPercentItemBags.indexOf(param1) > -1)
            {
               param1.dropIconItem();
               param1.pushIconItem(param2);
               this.setPercentUseItem();
               this.saveConfig();
            }
            if(this.timeUseBags.indexOf(param1) > -1)
            {
               param1.dropIconItem();
               param1.pushIconItem(param2);
               this.setOneTimeToUse(param1.itemIndex);
            }
         }
         if(param2 is IconItemSkill && this.skillBags.indexOf(param1) > -1)
         {
            param1.dropIconItem();
            param1.pushIconItem(param2);
            this.setUseSkill();
            this.saveConfig();
         }
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(this.hpPercentItemBags.indexOf(param1) > -1 || this.mpPercentItemBags.indexOf(param1) > -1 || this.petMpPercentItemBags.indexOf(param1) > -1 || this.petHpPercentItemBags.indexOf(param1) > -1)
         {
            param1.dropIconItem();
            this.setPercentUseItem();
            this.saveConfig();
         }
         if(this.timeUseBags.indexOf(param1) > -1)
         {
            param1.dropIconItem();
            this.setOneTimeToUse(param1.itemIndex);
         }
         if(this.skillBags.indexOf(param1) > -1)
         {
            param1.dropIconItem();
            this.setUseSkill();
            this.saveConfig();
         }
      }
   }
}

