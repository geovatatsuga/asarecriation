package obf_E_d_1594
{
   import obf_a_F_1055.obf_0_6_b_250;
   import obf_a_F_1055.obf_b_f_2719;
   import obf_a_F_1055.obf_b_p_3604;
   import obf_a_F_1055.obf_e_g_938;
   import obf_a_F_1055.obf_o_I_4492;
   import obf_g_A_3629.ChatDecoder;
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.res.obf_J_Y_3494;
   import com.sunweb.game.res.obf_b_8_4256;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.netRole.AINpc;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.ItemShowBoxUI;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.script.MacroScript;
   import com.sunweb.game.rpg.task.TaskManager;
   import com.sunweb.game.ui.HeadIconCode;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_9_V_1635;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import playerUI.NPCTalkBoxUIMC;
   
   public class NpcTalkBoxUI extends NPCTalkBoxUIMC implements IPlayerUI, IIconItemUI, obf_0_d_4341
   {
      
      public static var obf_0_0_O_290:String = "";
      
      private var obf_0_1_C_451:AINpc;
      
      private var menus:Array;
      
      private var bags:Array;
      
      private var obf_j_0_3920:ResourceBag;
      
      private var _noviceSprite:Sprite;
      
      private var timeInv:TimeLimiter = new TimeLimiter(300);
      
      private var obf_3_u_2516:int;
      
      public function NpcTalkBoxUI(param1:AINpc)
      {
         super();
         this.initDiversity();
         obf_0_0_O_290 = "";
         this.obf_0_1_C_451 = param1;
         this.obf_0_1_C_451.refreshTask();
         obf_b_p_3604.obf_h_n_3961 = param1.id + "@" + param1.mapId;
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2 - 50;
         this.showNpcHeadIcon();
         this.addListener();
         this.refreshMenu();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
      }
      
      public function get npcId() : String
      {
         return this.obf_0_1_C_451.id;
      }
      
      public function get npcMapId() : String
      {
         return this.obf_0_1_C_451.mapId;
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
         return "NpcTalkBoxUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         return null;
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         return null;
      }
      
      private function addListener() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         try
         {
            this.obf_j_0_3920.loader.removeEventListener(obf_J_Y_3494.COMPLETE,this.obf_2_e_1785);
         }
         catch(e:Error)
         {
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.timeInv.checkTimeout() && !obf_b_p_3604.checkNpcDistance(this.obf_0_1_C_451.id,false))
         {
            obf_K_e_3075.closeUI(this);
         }
      }
      
      private function obf_2_e_1785(param1:Event) : void
      {
         this.obf_j_0_3920.loader.removeEventListener(obf_J_Y_3494.COMPLETE,this.obf_2_e_1785);
         this.showNpcHeadIcon();
      }
      
      public function showNpcHeadIcon() : void
      {
         var _loc2_:String = null;
         txtNPCName.text = this.obf_0_1_C_451.npcName + ":";
         var _loc1_:DisplayObject = ResourceManager.instance.getDisplayObject(this.obf_0_1_C_451.obf_0_5_e_341);
         while(npcImage.numChildren > 0)
         {
            npcImage.removeChildAt(0);
         }
         while(playerImage.numChildren > 0)
         {
            playerImage.removeChildAt(0);
         }
         if(_loc1_)
         {
            npcImage.addChild(_loc1_);
         }
         else
         {
            _loc2_ = obf_b_8_4256.getResIdToImport(this.obf_0_1_C_451.obf_0_5_e_341);
            this.obf_j_0_3920 = ResourceManager.instance.getBag("NpcHeadIcon",true);
            this.obf_j_0_3920.obf_z_U_2156(_loc2_);
            this.obf_j_0_3920.loader.addEventListener(obf_J_Y_3494.COMPLETE,this.obf_2_e_1785);
            this.obf_j_0_3920.load();
         }
      }
      
      public function showPlayerTalkHeadIcon() : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         txtNPCName.text = GameContext.localPlayer.id + ":";
         var _loc1_:DisplayObject = HeadIconCode.getTalkHeadIconByInt(GameContext.localPlayer.fullInfo.headIconIndex);
         while(npcImage.numChildren > 0)
         {
            npcImage.removeChildAt(0);
         }
         while(playerImage.numChildren > 0)
         {
            playerImage.removeChildAt(0);
         }
         if(_loc1_)
         {
            playerImage.addChild(_loc1_);
         }
      }
      
      public function refreshMenu() : void
      {
         var _loc1_:obf_o_I_4492 = null;
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:obf_o_I_4492 = null;
         var _loc8_:obf_o_I_4492 = null;
         var _loc9_:obf_o_I_4492 = null;
         var _loc10_:obf_o_I_4492 = null;
         var _loc11_:Object = null;
         var _loc12_:obf_e_g_938 = null;
         if(!this.obf_0_1_C_451)
         {
            return;
         }
         this.clearContent();
         this.setTalkContent(this.obf_0_1_C_451.defaultTalk);
         for each(_loc2_ in this.obf_0_1_C_451.receiveTaskMenus)
         {
            if(_loc2_.receiveRule.npcMenuReceive)
            {
               _loc7_ = new obf_o_I_4492(_loc2_.receiveRule.npcMenuReceive,_loc2_.taskId,-1,obf_o_I_4492.obf_W_W_3673);
               if(_loc2_.receiveRule.autoReceive)
               {
                  _loc1_ = _loc7_;
               }
               this.addMenu(_loc7_);
            }
         }
         for each(_loc3_ in this.obf_0_1_C_451.promptTaskMenus)
         {
            if(_loc3_.receiveRule.npcMenuReceive)
            {
               _loc8_ = new obf_o_I_4492(_loc3_.receiveRule.npcMenuReceive,_loc3_.taskId,-1,obf_o_I_4492.obf_W_W_3673);
               this.addMenu(_loc8_);
            }
         }
         for each(_loc4_ in this.obf_0_1_C_451.finishTaskMenus)
         {
            if(_loc4_.finishRule.npcMenuFinish)
            {
               _loc9_ = new obf_o_I_4492(_loc4_.finishRule.npcMenuFinish,_loc4_.taskId,-1,obf_o_I_4492.obf_A_Y_3125);
               if(_loc4_.finishRule.autoFinish)
               {
                  _loc1_ = _loc9_;
               }
               this.addMenu(_loc9_);
            }
         }
         for each(_loc5_ in this.obf_0_1_C_451.doingTaskMenus)
         {
            if(_loc5_.finishRule.npcMenuQuery)
            {
               _loc10_ = new obf_o_I_4492(_loc5_.finishRule.npcMenuQuery,_loc5_.taskId,-1,obf_o_I_4492.obf_K_6_4447);
               this.addMenu(_loc10_);
            }
         }
         for(; _loc6_ < this.obf_0_1_C_451.menus.length; _loc6_++)
         {
            _loc11_ = this.obf_0_1_C_451.menus[_loc6_];
            if(_loc11_)
            {
               if(Boolean(_loc11_.activity) && _loc11_.activity.length > 0)
               {
                  if(!obf_J_F_3431.obf_U_Q_3887(_loc11_.activity))
                  {
                     continue;
                  }
               }
               _loc12_ = new obf_e_g_938(_loc11_,_loc6_);
               this.addMenu(_loc12_);
            }
         }
         if(_loc1_)
         {
            this.obf_5_y_948(_loc1_);
         }
      }
      
      private function obf_T_5_1567(param1:DisplayObject) : void
      {
         this.obf_3_u_2516 += param1.height;
         menuContent.addChild(param1);
         bgBox.height = menuContent.y + menuContent.height + 30;
         bgBox.y = bgBox.height / 2 - 5;
      }
      
      public function addMenu(param1:obf_0_6_b_250) : void
      {
         if(param1 is obf_e_g_938)
         {
            if(Boolean((param1 as obf_e_g_938).menuConfig.hideRule) && Boolean(!ConditionScript.isEmptyPar((param1 as obf_e_g_938).menuConfig.hideRule)) && ConditionScript.checkCondition((param1 as obf_e_g_938).menuConfig.hideRule))
            {
               param1.destroy();
               return;
            }
            if(Boolean((param1 as obf_e_g_938).menuConfig.showRule) && Boolean(!ConditionScript.isEmptyPar((param1 as obf_e_g_938).menuConfig.showRule)) && !ConditionScript.checkCondition((param1 as obf_e_g_938).menuConfig.showRule))
            {
               param1.destroy();
               return;
            }
         }
         param1.addEventListener(MouseEvent.CLICK,this.onClickMenu);
         param1.obf_i_7_4475 = this;
         param1.y = this.obf_3_u_2516;
         this.menus.push(param1);
         this.obf_T_5_1567(param1);
      }
      
      public function addMenus(param1:Array) : void
      {
         var _loc2_:obf_0_6_b_250 = null;
         for each(_loc2_ in param1)
         {
            this.addMenu(_loc2_);
         }
      }
      
      public function setTalkContent(param1:String) : void
      {
         param1 = obf_K_e_3075.getSwitchString(param1);
         var _loc2_:String = ChatDecoder.decode(param1);
         txtTalkContent.htmlText = _loc2_;
         talkContentScroll.update();
         talkContentScroll.visible = talkContentScroll.enabled;
      }
      
      public function showTaskAward(param1:int) : void
      {
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc11_:int = 0;
         var _loc12_:DisplayObject = null;
         this.obf_I_2282();
         var _loc2_:Object = TaskManager.getTaskObjById(param1);
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Sprite = new Sprite();
         var _loc4_:TextField = obf_9_V_1635.getNewTextField();
         _loc4_.text = DiversityManager.getString("NpcTalkUI","txtTaskAward");
         _loc3_.addChild(_loc4_);
         var _loc5_:Array = new Array();
         for(_loc6_ in _loc2_.finishRule.onFinished)
         {
            _loc5_.push(_loc6_);
         }
         _loc5_.sort();
         _loc7_ = _loc3_.height;
         _loc8_ = 0;
         for each(_loc9_ in _loc5_)
         {
            _loc10_ = MacroScript.getMacroDisplay(_loc9_,_loc2_.finishRule.onFinished[_loc9_]);
            _loc11_ = 0;
            while(_loc11_ < _loc10_.length)
            {
               _loc12_ = _loc10_[_loc11_];
               if(_loc12_)
               {
                  if(_loc12_ is ItemShowBoxUI)
                  {
                     ItemShowBoxUI(_loc12_).dockParentUI(this,this.bags);
                  }
                  _loc12_.x = _loc11_ % 3 * 130;
                  _loc12_.y = _loc7_;
                  _loc8_ = Math.max(_loc8_,_loc12_.height);
                  if(_loc11_ % 3 == 0 && _loc11_ > 0)
                  {
                     _loc7_ += _loc8_;
                     _loc12_.y = _loc7_;
                  }
                  if(_loc11_ == _loc10_.length - 1)
                  {
                     _loc7_ += _loc8_;
                  }
                  _loc3_.addChild(_loc12_);
               }
               _loc11_++;
            }
         }
         this.obf_T_5_1567(_loc3_);
      }
      
      public function clearContent(param1:Boolean = true) : void
      {
         var _loc2_:obf_b_f_2719 = null;
         txtTalkContent.htmlText = "";
         if(param1)
         {
            this.closeAward();
         }
         for each(_loc2_ in this.menus)
         {
            if(_loc2_ is DisplayObject)
            {
               (_loc2_ as DisplayObject).removeEventListener(MouseEvent.CLICK,this.onClickMenu);
               menuContent.removeChild(_loc2_ as DisplayObject);
            }
            _loc2_.destroy();
         }
         while(menuContent.numChildren > 0)
         {
            menuContent.removeChildAt(0);
         }
         this.obf_3_u_2516 = 0;
         this.menus = new Array();
      }
      
      private function obf_I_2282() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.bags)
         {
            _loc1_.destroy();
         }
         this.bags = new Array();
      }
      
      public function closeAward() : void
      {
         this.obf_I_2282();
      }
      
      private function onClickMenu(param1:Event) : void
      {
         if(!(param1.currentTarget is obf_b_f_2719))
         {
            return;
         }
         this.obf_5_y_948(param1.currentTarget as obf_b_f_2719);
         param1.stopPropagation();
      }
      
      private function obf_5_y_948(param1:obf_b_f_2719) : void
      {
         if(obf_b_p_3604.checkNpcDistance(this.obf_0_1_C_451.id,true))
         {
            param1.obf_5_y_948();
         }
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
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
      }
      
      public function closeUI() : void
      {
         obf_K_e_3075.npcTalkBox = null;
         this.destroy();
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.clearContent();
         this.obf_0_1_C_451 = null;
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

