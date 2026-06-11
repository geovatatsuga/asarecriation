package obf_0_5_Z_663
{
   import obf_0_7_V_532.*;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import fl.events.ScrollEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import playerUI.GenieMagicSkillUIMC;
   
   public class obf_N_h_2881 extends GenieMagicSkillUIMC implements IPlayerUI, IIconItemUI
   {
      
      private var bags:Array;
      
      public var elementBag:IconItemBag;
      
      private var magicRideBag:IconItemBag;
      
      private var obf_o_p_1892:Array;
      
      private var magicMap:Object;
      
      private var itemConfig:Array;
      
      private var obf_C_q_3434:Array;
      
      private var obf_0_6_t_281:String;
      
      private var obf_z_w_1672:int;
      
      private var obf_R_t_2229:int;
      
      private var dif:int = 2000;
      
      private var obf_B_p_1159:Number = 0;
      
      private var startDigTime:TimeLimiter;
      
      public function obf_N_h_2881()
      {
         var _loc2_:IconItemBag = null;
         super();
         this.initDiversity();
         this.visible = false;
         this.bags = new Array();
         this.magicMap = new Object();
         this.elementBag = new IconItemBag(obf_e_h_3725,this,0);
         this.elementBag.addValidType(GameItemType.ALL);
         this.elementBag.isLocked = false;
         this.bags.push(this.elementBag);
         this.magicRideBag = new IconItemBag(rideSumIcon,this,0);
         this.magicRideBag.addValidType(GameItemType.ALL);
         this.magicRideBag.isLocked = false;
         this.bags.push(this.magicRideBag);
         this.obf_o_p_1892 = new Array();
         var _loc1_:int = 1;
         while(_loc1_ < 5)
         {
            _loc2_ = new IconItemBag(this["digIcon" + _loc1_],this,_loc1_);
            _loc2_.addValidType(GameItemType.ALL);
            _loc2_.isLocked = false;
            this.obf_o_p_1892.push(_loc2_);
            this.bags.push(_loc2_);
            _loc1_++;
         }
         obf_P_Q_4429.pageSize = obf_P_Q_4429.height;
         this.itemConfig = obf_N_o_3647.getGenieMagicElementConfig().skillConfig as Array;
         this.setShowElementSkill(obf_N_o_3647.getGenieMagicElementConfig());
         this.addListener();
      }
      
      private function addListener() : void
      {
         obf_P_Q_4429.addEventListener(ScrollEvent.SCROLL,this.obf_Q_G_4209);
         cmdElemSum.addEventListener(MouseEvent.CLICK,this.obf_3_R_747);
         cmdRideSum.addEventListener(MouseEvent.CLICK,this.obf_0_1_t_589);
         cmdBless.addEventListener(MouseEvent.CLICK,this.obf_K_t_1144);
         cmdGhostSum.addEventListener(MouseEvent.CLICK,this.obf_0_2_N_679);
         cmdDig.addEventListener(MouseEvent.CLICK,this.onDig);
      }
      
      private function removeListener() : void
      {
         obf_P_Q_4429.removeEventListener(ScrollEvent.SCROLL,this.obf_Q_G_4209);
         cmdElemSum.removeEventListener(MouseEvent.CLICK,this.obf_3_R_747);
         cmdRideSum.removeEventListener(MouseEvent.CLICK,this.obf_0_1_t_589);
         cmdBless.removeEventListener(MouseEvent.CLICK,this.obf_K_t_1144);
         cmdGhostSum.removeEventListener(MouseEvent.CLICK,this.obf_0_2_N_679);
         cmdDig.removeEventListener(MouseEvent.CLICK,this.onDig);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc8_:int = 0;
         var _loc9_:IconItemBag = null;
         var _loc10_:IconItem = null;
         if(Boolean(this.startDigTime) && this.startDigTime.checkTimeout())
         {
            while(_loc8_ < this.obf_o_p_1892.length)
            {
               _loc9_ = this.obf_o_p_1892[_loc8_];
               if(!this.obf_C_q_3434)
               {
                  return;
               }
               _loc10_ = IconItemManager.getIconItemByCode(this.obf_C_q_3434[Math.floor(this.obf_C_q_3434.length * Math.random())],"");
               _loc9_.dropIconItem();
               _loc9_.pushIconItem(_loc10_);
               if(_loc8_ >= this.obf_o_p_1892.length)
               {
                  _loc8_ = 0;
               }
               _loc8_++;
            }
         }
         var _loc2_:Date = new Date();
         var _loc3_:Number = _loc2_.getTime();
         if(_loc3_ - this.obf_B_p_1159 < this.dif)
         {
            return;
         }
         this.obf_B_p_1159 = _loc3_;
         var _loc4_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$magic" + cmdElemSum.id);
         if(JSONUtil.getInt(_loc4_,["numOfDay"]) > 0)
         {
            cmdElemSum.enabled = false;
         }
         else
         {
            cmdElemSum.enabled = true;
         }
         var _loc5_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$magic" + cmdRideSum.id);
         if(JSONUtil.getInt(_loc5_,["numOfDay"]) > 0)
         {
            cmdRideSum.enabled = false;
         }
         else
         {
            cmdRideSum.enabled = true;
         }
         var _loc6_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$magic" + cmdBless.id);
         if(JSONUtil.getInt(_loc6_,["numOfDay"]) > 0)
         {
            cmdBless.enabled = false;
         }
         else
         {
            cmdBless.enabled = true;
         }
         var _loc7_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$magic" + cmdGhostSum.id);
         if(JSONUtil.getInt(_loc7_,["numOfDay"]) > 0)
         {
            cmdGhostSum.enabled = false;
         }
         else
         {
            cmdGhostSum.enabled = true;
         }
      }
      
      private function obf_Q_G_4209(param1:ScrollEvent) : void
      {
         elementPoint.scrollRect = new Rectangle(0,param1.position,obf_P_Q_4429.x - elementPoint.x,obf_P_Q_4429.height);
      }
      
      private function setShowElementSkill(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:obf_Z_4_1304 = null;
         if(!param1)
         {
            return;
         }
         while(elementPoint.numChildren > 0)
         {
            if(elementPoint.getChildAt(0) is obf_Z_4_1304)
            {
               obf_Z_4_1304(elementPoint.getChildAt(0)).destroy();
            }
            elementPoint.removeChildAt(0);
         }
         elementPoint.scrollRect = new Rectangle(0,0,obf_P_Q_4429.x - elementPoint.x,obf_P_Q_4429.height);
         var _loc3_:int = 0;
         var _loc4_:Array = param1.skillConfig as Array;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_];
            _loc7_ = new obf_Z_4_1304(_loc6_);
            _loc7_.addEventListener(obf_Z_4_1304.obf_v_y_2674,this.obf_V_Q_2027);
            _loc7_.configObj = _loc6_;
            _loc7_.setRemark(_loc6_.name);
            _loc7_.setGrade(0,_loc6_.maxLevel);
            _loc7_.setTips(_loc6_.costRemark);
            this.magicMap[_loc6_.id] = _loc7_;
            _loc7_.y = _loc2_;
            elementPoint.addChild(_loc7_);
            _loc2_ += _loc7_.height + 5;
            _loc5_++;
         }
         if(_loc2_ > obf_P_Q_4429.height)
         {
            obf_P_Q_4429.maxScrollPosition = _loc2_ - obf_P_Q_4429.height;
            obf_P_Q_4429.visible = true;
         }
         else
         {
            obf_P_Q_4429.scrollPosition = 0;
            obf_P_Q_4429.maxScrollPosition = 1;
            obf_P_Q_4429.visible = false;
         }
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
         obf_N_o_3647.sendGenieMagicUpSkill(obf_N_o_3647.obf_n_i_3999,_loc2_.id);
      }
      
      public function obf_j_j_1064(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:obf_Z_4_1304 = null;
         if(!param1)
         {
            return;
         }
         for(_loc2_ in param1)
         {
            _loc3_ = this.magicMap[_loc2_] as obf_Z_4_1304;
            if(_loc3_)
            {
               _loc3_.setGrade(param1[_loc2_],_loc3_.configObj.maxLevel);
            }
         }
      }
      
      private function showGenieMagic(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:IconItemBag = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:IconItem = null;
         var _loc2_:int = 0;
         for(_loc3_ in param1)
         {
            if(_loc2_ >= this.bags.length)
            {
               break;
            }
            _loc4_ = this.bags[_loc2_];
            _loc5_ = 0;
            while(_loc5_ < this.itemConfig.length)
            {
               if(this.itemConfig[_loc5_].id == _loc3_)
               {
                  _loc6_ = this.itemConfig[_loc5_].callCodes[param1[_loc3_] - 1];
                  _loc7_ = GameItemManager.getItemConfig(_loc6_);
                  if((Boolean(_loc7_)) && _loc7_.type == GameItemType.PET)
                  {
                     _loc8_ = IconItemManager.getIconItemByCode(_loc6_,"");
                     _loc4_.pushIconItem(_loc8_);
                     _loc2_++;
                     break;
                  }
               }
               _loc5_++;
            }
         }
      }
      
      public function showGenieMagicRideSum(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:IconItem = null;
         for(_loc2_ in param1)
         {
            _loc3_ = 0;
            while(_loc3_ < this.itemConfig.length)
            {
               if(this.itemConfig[_loc3_].id == _loc2_ && this.itemConfig[_loc3_].GenieMagicSkillTypeEnum == GenieMagicSkillTypeEnum.obf_h_3_2519)
               {
                  _loc4_ = this.itemConfig[_loc3_].callCodes[param1[_loc2_] - 1];
                  _loc5_ = IconItemManager.getIconItemByCode(_loc4_,"");
                  if(_loc5_)
                  {
                     cmdRideSum.id = _loc2_;
                     cmdRideSum._iconName = _loc5_;
                     break;
                  }
               }
               _loc3_++;
            }
         }
      }
      
      public function showGenieMagicBless(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         for(_loc2_ in param1)
         {
            _loc3_ = 0;
            while(_loc3_ < this.itemConfig.length)
            {
               if(this.itemConfig[_loc3_].id == _loc2_ && this.itemConfig[_loc3_].GenieMagicSkillTypeEnum == GenieMagicSkillTypeEnum.obf_8_o_3370)
               {
                  cmdBless.id = _loc2_;
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      public function showGenieMagicGhost(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         for(_loc3_ in param1)
         {
            _loc4_ = 0;
            while(_loc4_ < this.itemConfig.length)
            {
               if(this.itemConfig[_loc4_].id == _loc3_ && this.itemConfig[_loc4_].GenieMagicSkillTypeEnum == GenieMagicSkillTypeEnum.obf_f_L_4497)
               {
                  cmdGhostSum.id = _loc3_;
                  break;
               }
               _loc4_++;
            }
         }
      }
      
      public function showGenieMagicDig(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc2_:int = 0;
         for(_loc3_ in param1)
         {
            _loc4_ = 0;
            while(_loc4_ < this.itemConfig.length)
            {
               if(this.itemConfig[_loc4_].id == _loc3_ && this.itemConfig[_loc4_].GenieMagicSkillTypeEnum == GenieMagicSkillTypeEnum.obf_3_Y_3984)
               {
                  _loc5_ = this.itemConfig[_loc4_].itemCodes;
                  cmdDig.id = _loc3_;
                  cmdDig.itemCodes = _loc5_;
                  this.obf_z_w_1672 = param1[_loc3_];
                  break;
               }
               _loc4_++;
            }
         }
         obf_0_0_D_211.text = this.obf_R_t_2229 + "/" + this.obf_z_w_1672;
      }
      
      private function obf_3_R_747(param1:Event) : void
      {
         param1.stopPropagation();
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$magic" + param1.currentTarget.id);
         if(JSONUtil.getInt(_loc2_,["numOfDay"]) > 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("GenieMagicBoxUI","alreadyPetSum"));
            return;
         }
         if(Boolean(obf_K_e_3075.petBoxUI) && !obf_K_e_3075.petBoxUI.haveEmptyBag(1))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","needEmptyPetBag",[1]));
            return;
         }
         if(obf_K_e_3075.genieMagicSummonUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.genieMagicSummonUI);
         }
         else
         {
            obf_K_e_3075.showUI(obf_K_e_3075.genieMagicSummonUI);
         }
      }
      
      private function obf_0_1_t_589(param1:Event) : void
      {
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$magic" + param1.currentTarget.id);
         if(JSONUtil.getInt(_loc2_,["numOfDay"]) > 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("GenieMagicBoxUI","alreadyRideSum"));
            return;
         }
         if(Boolean(obf_K_e_3075.rideBoxUI) && !obf_K_e_3075.rideBoxUI.haveEmptyBag(1))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","needEmptyRideBag",[1]));
            return;
         }
         if(obf_L_l_4100.isEmpty(param1.currentTarget.id))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("GenieMagicBoxUI","ErrorWork"));
            return;
         }
         obf_N_o_3647.sendGenieMagicUseSkill(param1.currentTarget.id);
         this.magicRideBag.dropIconItem();
         this.magicRideBag.pushIconItem(param1.currentTarget._iconName);
         cmdRideSum.enabled = false;
      }
      
      private function obf_K_t_1144(param1:Event) : void
      {
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$magic" + param1.currentTarget.id);
         if(JSONUtil.getInt(_loc2_,["numOfDay"]) > 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("GenieMagicBoxUI","alreadyBless"));
            return;
         }
         if(obf_L_l_4100.isEmpty(param1.currentTarget.id))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("GenieMagicBoxUI","ErrorWork"));
            return;
         }
         obf_N_o_3647.sendGenieMagicUseSkill(param1.currentTarget.id);
      }
      
      private function obf_0_2_N_679(param1:Event) : void
      {
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$magic" + param1.currentTarget.id);
         if(JSONUtil.getInt(_loc2_,["numOfDay"]) > 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("GenieMagicBoxUI","alreadyGhostSum"));
            return;
         }
         if(obf_L_l_4100.isEmpty(param1.currentTarget.id))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("GenieMagicBoxUI","ErrorWork"));
            return;
         }
         obf_N_o_3647.sendGenieMagicUseSkill(param1.currentTarget.id);
      }
      
      private function onDig(param1:Event) : void
      {
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$magic" + param1.currentTarget.id);
         if(Boolean(obf_K_e_3075.playerBagUI) && !obf_K_e_3075.playerBagUI.haveEmptyBag(4))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("CommonPrompt","needEmptyBag",[4]));
            return;
         }
         if(this.obf_R_t_2229 >= this.obf_z_w_1672)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("GenieMagicBoxUI","alreadyDig"));
            return;
         }
         if(obf_L_l_4100.isEmpty(param1.currentTarget.id))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("GenieMagicBoxUI","ErrorWork"));
            return;
         }
         this.obf_0_6_t_281 = param1.currentTarget.id;
         this.obf_C_q_3434 = new Array();
         this.obf_C_q_3434 = param1.currentTarget.itemCodes;
         this.startDigTime = new TimeLimiter(100);
         cmdDig.enabled = false;
         setTimeout(this.sendDigCommand,1000 * 5);
      }
      
      private function sendDigCommand() : void
      {
         var _loc1_:IconItemBag = null;
         obf_N_o_3647.sendGenieMagicUseSkill(this.obf_0_6_t_281);
         this.startDigTime = null;
         cmdDig.enabled = true;
         for each(_loc1_ in this.obf_o_p_1892)
         {
            _loc1_.dropIconItem();
         }
      }
      
      public function showDigItems(param1:Object) : void
      {
         var _loc3_:IconItemBag = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:IconItemBag = null;
         var _loc7_:IconItem = null;
         var _loc2_:Array = new Array();
         for each(_loc3_ in this.obf_o_p_1892)
         {
            _loc3_.dropIconItem();
         }
         for(_loc4_ in param1)
         {
            _loc2_.push({
               "itemCode":_loc4_,
               "itemCount":param1[_loc4_]
            });
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            if(_loc5_ >= this.obf_o_p_1892.length)
            {
               break;
            }
            _loc6_ = this.obf_o_p_1892[_loc5_];
            _loc7_ = IconItemManager.getIconItemByCode(_loc2_[_loc5_].itemCode,"");
            _loc7_.itemCount = _loc2_[_loc5_].itemCount;
            _loc6_.dropIconItem();
            _loc6_.pushIconItem(_loc7_);
            _loc5_++;
         }
         obf_0_0_D_211.text = this.obf_R_t_2229 + "/" + this.obf_z_w_1672;
      }
      
      public function showUsedSkillItems(param1:Object) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:IconItem = null;
         var _loc8_:String = null;
         var _loc9_:Object = null;
         var _loc10_:IconItem = null;
         var _loc11_:PeriodCounterItemInfo = null;
         var _loc2_:int = 0;
         for(_loc3_ in param1)
         {
            _loc4_ = 0;
            for(; _loc4_ < this.itemConfig.length; _loc4_++)
            {
               if(this.itemConfig[_loc4_].id == _loc3_ && this.itemConfig[_loc4_].GenieMagicSkillTypeEnum == GenieMagicSkillTypeEnum.obf_K_z_1029)
               {
                  _loc5_ = this.itemConfig[_loc4_].callCodes[param1[_loc3_] - 1];
                  _loc6_ = GameItemManager.getItemConfig(_loc5_);
                  if(_loc6_)
                  {
                     _loc7_ = IconItemManager.getIconItemByCode(_loc5_,"");
                     this.elementBag.dropIconItem();
                     this.elementBag.pushIconItem(_loc7_);
                     cmdElemSum.id = _loc3_;
                     continue;
                  }
               }
               if(this.itemConfig[_loc4_].id == _loc3_ && this.itemConfig[_loc4_].GenieMagicSkillTypeEnum == GenieMagicSkillTypeEnum.obf_h_3_2519)
               {
                  _loc8_ = this.itemConfig[_loc4_].callCodes[param1[_loc3_] - 1];
                  _loc9_ = GameItemManager.getItemConfig(_loc8_);
                  if(_loc9_)
                  {
                     _loc10_ = IconItemManager.getIconItemByCode(_loc8_,"");
                     this.magicRideBag.dropIconItem();
                     this.magicRideBag.pushIconItem(_loc10_);
                     continue;
                  }
               }
               if(this.itemConfig[_loc4_].id == _loc3_ && this.itemConfig[_loc4_].GenieMagicSkillTypeEnum == GenieMagicSkillTypeEnum.obf_3_Y_3984)
               {
                  _loc11_ = obf_Y_F_1424.getCounter("$magic" + _loc3_);
                  if(_loc11_)
                  {
                     this.obf_R_t_2229 = _loc11_.numOfDay;
                  }
               }
            }
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
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtGenieSum,"GenieMagicBoxUI","txtGenieSum");
         DiversityManager.setTextField(txtRideMagicSum,"GenieMagicBoxUI","txtRideMagicSum");
         DiversityManager.setTextField(txtGenieBless,"GenieMagicBoxUI","txtGenieBless");
         DiversityManager.setTextField(txtGhostSum,"GenieMagicBoxUI","txtGhostSum");
         DiversityManager.setTextField(txtDryDig,"GenieMagicBoxUI","txtDryDig");
         cmdElemSum.label = DiversityManager.getString("GenieMagicBoxUI","cmdSummon");
         cmdRideSum.label = DiversityManager.getString("GenieMagicBoxUI","cmdSummon");
         cmdBless.label = DiversityManager.getString("GenieMagicBoxUI","cmdBless");
         cmdGhostSum.label = DiversityManager.getString("GenieMagicBoxUI","cmdSummon");
         cmdDig.label = DiversityManager.getString("GenieMagicBoxUI","cmdDig");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.startDigTime = null;
      }
      
      public function getIconItemBags() : Array
      {
         return this.bags;
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

