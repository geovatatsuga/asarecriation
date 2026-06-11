package com.sunweb.game.rpg.playerUI.map
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.netRole.obf_U_6_3454;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.obf_0_d_4341;
   import com.sunweb.game.rpg.playerUI.managers.obf_9_7_2639;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.map.WorldMapManager;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import img.MapSelfIcon;
   import playerUI.WorldMapUIMC;
   
   public class WorldMapUI extends WorldMapUIMC implements IPlayerUI, obf_0_d_4341
   {
      
      private var obf_a_b_1184:MovieClip;
      
      private var obf_y_W_4208:TimeLimiter;
      
      private var obf_h_4674:MovieClip = new MapSelfIcon();
      
      private var _noviceSprite:Sprite;
      
      private var pframeIndex:int = 0;
      
      private var frameTimeInv:TimeLimiter = new TimeLimiter(200);
      
      public function WorldMapUI()
      {
         super();
         this.initDiversity();
         this.obf_a_b_1184 = ResourceManager.instance.getMovieClip("worldMap@map");
         this.addChildAt(this.obf_a_b_1184,0);
         this.obf_h_4674.mouseEnabled = false;
         this.obf_h_4674.mouseChildren = false;
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
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
         return "WorldMapUI";
      }
      
      public function getTargetPoint(param1:String) : Point
      {
         var _loc3_:Rectangle = null;
         var _loc2_:DisplayObject = this.getHighLightDisplayObject(param1);
         if(_loc2_)
         {
            _loc3_ = _loc2_.getBounds(this.obf_a_b_1184);
            return new Point(_loc3_.left + _loc3_.width / 2,_loc3_.top + _loc3_.height / 2);
         }
         this.pframeIndex = -1;
         return null;
      }
      
      public function getHighLightDisplayObject(param1:String) : DisplayObject
      {
         var _loc4_:DisplayObject = null;
         var _loc2_:String = param1 == "mainCity" ? WorldMapManager.getLandMainCityCode(GameContext.currentMap.mapId) : param1;
         var _loc3_:String = WorldMapManager.getMapInLandCode(_loc2_);
         if(this.obf_a_b_1184.currentLabel == "world")
         {
            if(Boolean(this.obf_a_b_1184.worldBox) && Boolean(this.obf_a_b_1184.worldBox.world_btn))
            {
               _loc4_ = this.obf_a_b_1184.worldBox.world_btn.getChildByName("btn_" + _loc3_);
            }
         }
         else if(this.obf_a_b_1184.currentLabel == _loc3_)
         {
            if(Boolean(this.obf_a_b_1184.landMap) && Boolean(this.obf_a_b_1184.landMap.maps))
            {
               _loc4_ = this.obf_a_b_1184.landMap.maps.getChildByName(_loc2_);
            }
         }
         else
         {
            _loc4_ = this.obf_a_b_1184.getChildByName("btn_world");
         }
         return _loc4_;
      }
      
      private function addListener() : void
      {
         this.obf_a_b_1184.addEventListener(MouseEvent.CLICK,this.obf_k_w_2692);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function removeListener() : void
      {
         this.obf_a_b_1184.removeEventListener(MouseEvent.CLICK,this.obf_k_w_2692);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc3_:Rectangle = null;
         if(!this.visible || !this.frameTimeInv.checkTimeout())
         {
            return;
         }
         if(this.pframeIndex != this.obf_a_b_1184.currentFrame)
         {
            this.pframeIndex = this.obf_a_b_1184.currentFrame;
            obf_9_7_2639.obf_L_s_2876(this);
         }
         var _loc2_:DisplayObject = this.getMapDisplayInWorldMap(GameContext.currentMap.mapId,GameContext.currentMap.worldMC);
         if(_loc2_)
         {
            if(!this.obf_h_4674.parent)
            {
               this.obf_a_b_1184.addChild(this.obf_h_4674);
            }
            _loc3_ = _loc2_.getBounds(this.obf_a_b_1184);
            this.obf_h_4674.x = _loc3_.left + _loc3_.width / 2;
            this.obf_h_4674.y = _loc3_.top + _loc3_.height / 2;
         }
         else if(this.obf_h_4674.parent)
         {
            this.obf_a_b_1184.removeChild(this.obf_h_4674);
         }
      }
      
      private function getMapDisplayInWorldMap(param1:String, param2:String) : DisplayObject
      {
         var _loc3_:DisplayObject = null;
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:* = 0;
         var _loc4_:Array = [this.obf_a_b_1184.worldBox,this.obf_a_b_1184];
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_)
            {
               if(!obf_L_l_4100.isEmpty(param2) && _loc5_.hasOwnProperty(param2))
               {
                  _loc3_ = _loc5_.getChildByName(param2);
                  if(_loc3_)
                  {
                     return _loc3_;
                  }
               }
               else
               {
                  _loc6_ = param1.length;
                  while(_loc6_ > 0)
                  {
                     _loc3_ = _loc5_.getChildByName(param1.substr(0,_loc6_));
                     if(_loc3_)
                     {
                        return _loc3_;
                     }
                     _loc6_--;
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public function setTeleportCDTime(param1:int) : void
      {
         this.obf_y_W_4208 = new TimeLimiter(param1);
      }
      
      private function obf_k_w_2692(param1:Event) : void
      {
         var _loc2_:SimpleButton = null;
         if(param1.target is SimpleButton)
         {
            _loc2_ = param1.target as SimpleButton;
            if(_loc2_.name.indexOf("btn") == -1)
            {
               GameContext.localPlayer.obf_0_8_r_450(_loc2_.name,obf_U_6_3454.obf_L_K_2966,null);
            }
            else if(_loc2_.name == "btn_close")
            {
               obf_K_e_3075.closeUI(this);
            }
         }
      }
      
      public function teleportToMap(param1:String) : void
      {
         var _loc2_:Object = WorldMapManager.getMapConfig(param1);
         if(!_loc2_)
         {
            WindowManager.showMessageBox(DiversityManager.getString("WorldMapUI","mapNotOpen"));
            return;
         }
         if(!_loc2_.canTeleport)
         {
            WindowManager.showMessageBox(DiversityManager.getString("WorldMapUI","mapNotTeleport"));
            return;
         }
         if(GameContext.localPlayer.fullInfo.attributes.sp < int(NumberConfig.getSettingObject("spCostPerTeleport")))
         {
            WindowManager.showMessageBox(DiversityManager.getString("CommonPrompt","noMoreSP"));
            return;
         }
         if(!this.obf_L_c_4251())
         {
            if(!(Boolean(obf_K_e_3075.playerBagUI) && obf_K_e_3075.playerBagUI.getItemCount(WorldConfig.getStringSetting("mapTeleportItem")) > 0))
            {
               WindowManager.showMessageBox(DiversityManager.getString("WorldMapUI","teleportCD"));
               return;
            }
            WindowManager.showConfirmBox(DiversityManager.getString("WorldMapUI","confirmUseItemTeleport"),this.confirmTeleport,[param1,true]);
         }
         else
         {
            GameContext.localPlayer.obf_0_6_S_694(param1);
            obf_K_e_3075.closeUI(this);
         }
      }
      
      private function confirmTeleport(param1:Object) : void
      {
         if(param1.confirm)
         {
            GameContext.localPlayer.obf_0_6_S_694.apply(null,param1.par);
            obf_K_e_3075.closeUI(this);
         }
      }
      
      public function obf_L_c_4251() : Boolean
      {
         return !this.obf_y_W_4208 || this.obf_y_W_4208.checkTimeout(true);
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
         if(this.obf_a_b_1184)
         {
            this.obf_a_b_1184.gotoAndStop(WorldMapManager.getMapInLandCode(GameContext.currentMap.mapId));
         }
         obf_9_7_2639.obf_L_s_2876(this);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         if(this.contains(this.obf_a_b_1184))
         {
            this.removeChild(this.obf_a_b_1184);
         }
      }
   }
}

