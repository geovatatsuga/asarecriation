package com.sunweb.game.rpg.playerUI.druid
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.iconItem.IIconItemUI;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.iconItem.IconItemSkill;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import playerUI.DruidBoxUIMC;
   
   public class obf_S_8_3817 extends DruidBoxUIMC implements IPlayerUI, IIconItemUI
   {
      
      private var skillBar:Array;
      
      private var keys:Object;
      
      private var downKey:int;
      
      public function obf_S_8_3817()
      {
         var _loc2_:MovieClip = null;
         var _loc3_:IconItemBag = null;
         super();
         this.initDiversity();
         this.visible = false;
         this.onResize(null);
         this.skillBar = new Array();
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = this["druidSkills"]["bag" + _loc1_];
            if(_loc2_)
            {
               _loc3_ = new IconItemBag(_loc2_,this,_loc1_);
               _loc3_.addValidType(GameItemType.SKILL);
               _loc3_.lockDrag = true;
               this.skillBar.push(_loc3_);
            }
            _loc1_++;
         }
         this.initKey();
         this.obf_q_N_2525();
      }
      
      private function initKey() : void
      {
         var _loc3_:IconItemBag = null;
         this.keys = new Object();
         var _loc1_:Array = ["9","0","I","O","K","L"];
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(!obf_L_l_4100.isEmpty(_loc1_[_loc2_]))
            {
               if(_loc2_ < this.skillBar.length)
               {
                  _loc3_ = this.skillBar[_loc2_];
                  if(_loc3_)
                  {
                     this.keys[_loc1_[_loc2_]] = _loc3_;
                     _loc3_.setKeyTipInfo(_loc1_[_loc2_]);
                  }
               }
            }
            _loc2_++;
         }
      }
      
      private function obf_q_N_2525() : void
      {
         GameContext.gameStage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         GameContext.gameStage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
      }
      
      private function removerListem() : void
      {
         GameContext.gameStage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         GameContext.gameStage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
      }
      
      private function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      public function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = obf_K_e_3075.shortcutUI.y - obf_K_e_3075.shortcutUI.obf_d_g_1136;
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(this.downKey != param1.charCode)
         {
            this.downKey = param1.charCode;
            this.useIconItemByKey(String.fromCharCode(param1.charCode));
         }
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         this.downKey = 0;
      }
      
      private function useIconItemByKey(param1:String) : void
      {
         param1 = param1.toUpperCase();
         if(this.keys[param1] is IconItemBag)
         {
            this.useIconItem(this.keys[param1].haveIconItem);
         }
      }
      
      private function obf_L_t_4155() : void
      {
         var _loc1_:IconItemBag = null;
         for each(_loc1_ in this.skillBar)
         {
            _loc1_.dropIconItem();
         }
      }
      
      public function showSkill(param1:String) : void
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:IconItemSkill = null;
         var _loc2_:Object = SkillConfig.getChangePlayerSkill(param1);
         this.obf_L_t_4155();
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:Array = new Array();
         for(_loc4_ in _loc2_)
         {
            if(_loc4_ != "bsjs01")
            {
               _loc3_.push({
                  "key":_loc4_,
                  "lv":_loc2_[_loc4_]
               });
            }
         }
         _loc3_.sortOn("key");
         _loc3_.push({
            "key":"bsjs01",
            "lv":1
         });
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = SkillConfig.getSkillConfig(_loc3_[_loc5_].key);
            if(_loc6_)
            {
               _loc7_ = IconItemSkill.getNewIconItem(_loc3_[_loc5_].key,_loc3_[_loc5_].lv);
               if(_loc5_ < this.skillBar.length)
               {
                  if(_loc7_)
                  {
                     if(_loc3_[_loc5_].key == "bsjs01" && _loc5_ == _loc3_.length - 1)
                     {
                        (this.skillBar[7] as IconItemBag).pushIconItem(_loc7_);
                     }
                     else
                     {
                        (this.skillBar[_loc5_] as IconItemBag).pushIconItem(_loc7_);
                     }
                  }
               }
            }
            _loc5_++;
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
      }
      
      public function showUI() : void
      {
         this.visible = true;
         this.onResize(null);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removerListem();
      }
      
      public function getIconItemBags() : Array
      {
         return this.skillBar;
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
      }
      
      public function onDragOutIconItem(param1:IconItemBag, param2:IconItemBag, param3:IIconItemUI) : void
      {
      }
   }
}

