package com.sunweb.game.rpg.playerUI
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.iconItem.IconItemMotion;
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.iconItem.obf_U_N_1827;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import playerUI.ShortcutUIMC;
   
   public class ShortcutUI extends ShortcutUIMC implements IIconItemUI
   {
      
      private var bags:Array;
      
      private var bagGroup:Array;
      
      private var showGroups:int;
      
      private var keys:Object;
      
      private var downKey:int;
      
      public var obf_d_g_1136:int = 0;
      
      public function ShortcutUI()
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:IconItemBag = null;
         super();
         this.cacheAsBitmap = true;
         this.bags = new Array();
         this.bagGroup = new Array();
         var _loc1_:int = 1;
         while(_loc1_ <= 4)
         {
            _loc2_ = new Array();
            _loc3_ = 0;
            while(_loc3_ < 10)
            {
               _loc4_ = this["iconBox" + _loc1_]["iconBox"]["bag" + _loc3_];
               if(_loc4_)
               {
                  _loc4_.gotoAndPlay("hide");
                  _loc5_ = new IconItemBag(_loc4_,this,_loc3_);
                  _loc5_.addValidType(GameItemType.ALL);
                  _loc5_.isLocked = false;
                  _loc2_.push(_loc5_);
                  this.bags.push(_loc5_);
               }
               _loc3_++;
            }
            this.bagGroup.push(_loc2_);
            _loc1_++;
         }
         this.initKey();
         this.setShowGroup(0);
         this.addListener();
         this.onResize(null);
      }
      
      private function initKey() : void
      {
         var _loc3_:int = 0;
         var _loc4_:IconItemBag = null;
         this.keys = new Object();
         var _loc1_:Array = [["1","2","3","4","5","6","7","8","9","0"],["Q","W","E","R","A","S","D","F"]];
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_[_loc2_].length)
            {
               if(!obf_L_l_4100.isEmpty(_loc1_[_loc2_][_loc3_]))
               {
                  if(_loc2_ < this.bagGroup.length)
                  {
                     if(_loc3_ < this.bagGroup[_loc2_].length)
                     {
                        _loc4_ = this.bagGroup[_loc2_][_loc3_];
                        if(_loc4_)
                        {
                           this.keys[_loc1_[_loc2_][_loc3_]] = _loc4_;
                           _loc4_.setKeyTipInfo(_loc1_[_loc2_][_loc3_]);
                        }
                     }
                  }
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
      }
      
      private function addListener() : void
      {
         GameContext.gameStage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         GameContext.gameStage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         cmdShowBox.addEventListener(MouseEvent.CLICK,this.onClickShowGroup);
         cmdHideBox.addEventListener(MouseEvent.CLICK,this.onClickHideGroup);
      }
      
      private function removeListener() : void
      {
         GameContext.gameStage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         GameContext.gameStage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         cmdShowBox.removeEventListener(MouseEvent.CLICK,this.onClickShowGroup);
         cmdHideBox.removeEventListener(MouseEvent.CLICK,this.onClickHideGroup);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight - 40;
      }
      
      private function onClickShowGroup(param1:Event) : void
      {
         this.setShowGroup(this.showGroups + 1);
         this.saveConfig();
      }
      
      private function onClickHideGroup(param1:Event) : void
      {
         this.setShowGroup(this.showGroups - 1);
         this.saveConfig();
      }
      
      public function haveItemIcon(param1:int, param2:String, param3:String = null) : Boolean
      {
         var _loc4_:IconItemBag = null;
         for each(_loc4_ in this.bags)
         {
            if(_loc4_.haveIconItem)
            {
               if(_loc4_.haveIconItem.itemType == param1 && _loc4_.haveIconItem.itemCode == param2 && _loc4_.haveIconItem.itemId == param3)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function setShowGroup(param1:int) : void
      {
         var _loc3_:MovieClip = null;
         param1 = Math.min(this.bagGroup.length - 1,Math.max(0,param1));
         this.showGroups = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this.bagGroup.length)
         {
            _loc3_ = this["iconBox" + (_loc2_ + 1)] as MovieClip;
            if(_loc3_)
            {
               if(_loc2_ <= param1)
               {
                  if(_loc3_.currentLabel == "hide")
                  {
                     _loc3_.gotoAndPlay("show");
                  }
               }
               else if(_loc3_.currentLabel == "show")
               {
                  _loc3_.gotoAndPlay("hide");
               }
            }
            _loc2_++;
         }
         this.obf_d_g_1136 = (param1 + 1) * 40;
         if(obf_K_e_3075.obf_G_K_2049)
         {
            obf_K_e_3075.obf_G_K_2049.onResize(null);
         }
         if(obf_K_e_3075.druidBoxUI)
         {
            obf_K_e_3075.druidBoxUI.onResize(null);
         }
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(this.downKey != param1.charCode)
         {
            this.downKey = param1.charCode;
            this.useIconItemByKey(String.fromCharCode(param1.charCode));
         }
      }
      
      private function useIconItemByKey(param1:String) : void
      {
         param1 = param1.toUpperCase();
         if(this.keys[param1] is IconItemBag)
         {
            this.useIconItem(this.keys[param1].haveIconItem);
         }
      }
      
      private function useIconItem(param1:IconItem) : void
      {
         if(!param1)
         {
            return;
         }
         if(GameItemType.contrastType(GameItemType.EXPENDABLE,param1.itemType) || GameItemType.contrastType(GameItemType.EQUIPMENT,param1.itemType))
         {
            if(!obf_L_l_4100.isEmpty(param1.itemId))
            {
               obf_K_e_3075.playerBagUI.useItemById(param1.itemId);
            }
            else
            {
               obf_K_e_3075.playerBagUI.useItemByCode(param1.itemCode);
            }
         }
         else
         {
            param1.useIcon();
         }
      }
      
      public function recheckIconItem() : void
      {
         var _loc1_:IconItemBag = null;
         var _loc2_:Object = null;
         for each(_loc1_ in this.bags)
         {
            if(!(!_loc1_.haveIconItem || _loc1_.haveIconItem is IconItemMotion))
            {
               if(_loc1_.haveIconItem is IconItemSkill)
               {
                  (_loc1_.haveIconItem as IconItemSkill).level = PlayerSkillManager.getSkillLevel(_loc1_.haveIconItem.itemCode);
               }
               else
               {
                  _loc2_ = GameItemManager.getItemConfig(_loc1_.haveIconItem.itemCode);
                  if(Boolean(_loc2_) && _loc2_.stackSize > 1)
                  {
                     _loc1_.haveIconItem.itemCount = obf_K_e_3075.playerBagUI.getItemCount(_loc1_.haveIconItem.itemCode);
                  }
               }
            }
         }
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         this.downKey = 0;
      }
      
      public function setIconItemToBag(param1:IconItem, param2:String) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc3_:IconItemBag = this[param2];
         if(_loc3_)
         {
            _loc3_.dropIconItem();
            _loc3_.pushIconItem(param1);
         }
      }
      
      public function setUserConfigIconItemBag() : void
      {
         var _loc2_:int = 0;
         var _loc3_:IconItemBag = null;
         var _loc4_:Array = null;
         var _loc5_:IconItem = null;
         var _loc1_:Object = GameContext.userConfig.sht;
         if(_loc1_)
         {
            this.setShowGroup(JSONUtil.getInt(_loc1_,["g"]));
            _loc2_ = 0;
            while(_loc2_ < this.bags.length)
            {
               _loc3_ = this.bags[_loc2_];
               _loc4_ = _loc1_["k" + _loc2_];
               if((Boolean(_loc4_)) && _loc4_.length > 0)
               {
                  if((_loc4_[0] & GameItemType.SKILL) > 0)
                  {
                     _loc5_ = IconItemSkill.getNewIconItem(_loc4_[1],1);
                  }
                  else if((_loc4_[0] & GameItemType.MOTION) > 0)
                  {
                     _loc5_ = IconItemMotion.getNewIconItem(_loc4_[1]);
                  }
                  else if((_loc4_[0] & GameItemType.PET) > 0)
                  {
                     _loc5_ = obf_U_N_1827.getNewIconItem(_loc4_[1],_loc4_[2]);
                  }
                  else if(_loc4_.length >= 3)
                  {
                     _loc5_ = IconItemManager.getIconItemByCode(_loc4_[1],_loc4_[2]);
                  }
                  if(_loc5_)
                  {
                     _loc3_.pushIconItem(_loc5_);
                  }
               }
               else
               {
                  _loc3_.dropIconItem();
               }
               _loc2_++;
            }
         }
      }
      
      public function setUserDefaultSkillIconItemBag() : void
      {
         var _loc1_:IconItemSkill = null;
         var _loc2_:IconItemBag = null;
         if(GameContext.localPlayer)
         {
            if(obf_L_l_4100.isEmpty(GameContext.userConfig.dasc))
            {
               _loc1_ = IconItemSkill.getNewIconItem(WorldConfig.getDefaultAttackSkillCode(GameContext.localPlayer.fullInfo.jobCode),1);
               if(_loc1_)
               {
                  _loc2_ = this.bags[0];
                  if(_loc2_.haveIconItem)
                  {
                     _loc2_.dropIconItem();
                  }
                  _loc2_.pushIconItem(_loc1_);
               }
               GameContext.userConfig.dasc = WorldConfig.getDefaultAttackSkillCode(GameContext.localPlayer.fullInfo.jobCode);
               this.saveConfig();
            }
         }
      }
      
      public function saveConfig() : void
      {
         var _loc3_:IconItemBag = null;
         var _loc1_:Object = GameContext.userConfig.sht;
         if(!_loc1_)
         {
            _loc1_ = new Object();
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.bags.length)
         {
            _loc3_ = this.bags[_loc2_];
            _loc1_["k" + _loc2_] = _loc3_.haveIconItem != null ? [_loc3_.haveIconItem.itemType,_loc3_.haveIconItem.itemCode,_loc3_.haveIconItem.itemId] : [];
            _loc2_++;
         }
         _loc1_.g = this.showGroups;
         GameContext.userConfig.sht = _loc1_;
         GameContext.saveConfig();
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
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         var _loc1_:IconItemBag = null;
         this.removeListener();
         for each(_loc1_ in this.bags)
         {
            if(_loc1_)
            {
               _loc1_.destroy();
            }
         }
         this.bags = null;
      }
      
      public function getIconItemBags() : Array
      {
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ <= this.showGroups)
         {
            _loc1_ = _loc1_.concat(this.bagGroup[_loc2_]);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function clickIconItemBag(param1:IconItemBag, param2:Boolean, param3:Boolean) : void
      {
         if(!this.contains(param1))
         {
            return;
         }
         this.useIconItem(param1.haveIconItem);
      }
      
      public function dbclickIconItemBag(param1:IconItemBag) : void
      {
      }
      
      public function onDragInIconItem(param1:IconItemBag, param2:IconItem, param3:IconItemBag) : void
      {
         var _loc4_:IconItem = null;
         if(!param1 || !this.contains(param1) || param1 == param3)
         {
            param2.destroy();
            return;
         }
         if(param1.haveIconItem != null)
         {
            _loc4_ = param1.haveIconItem.clone();
         }
         param1.dropIconItem();
         param1.pushIconItem(param2);
         if(GameItemType.contrastType(GameItemType.EXPENDABLE,param2.itemType))
         {
            param2.itemCount = obf_K_e_3075.playerBagUI.getItemCount(param2.itemCode);
         }
         if(this.contains(param3))
         {
            param3.dropIconItem();
            if(_loc4_)
            {
               param3.pushIconItem(_loc4_);
            }
         }
         this.saveConfig();
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
         if(!param3 || param3 == this && !param2)
         {
            param1.dropIconItem();
            this.saveConfig();
         }
      }
   }
}

