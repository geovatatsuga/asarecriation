package com.sunweb.game.rpg.playerUI.map
{
   import obf_g_A_3629.ChatDecoder;
   import obf_g_A_3629.obf_g_u_3212;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.farm.AIFarmHarvest;
   import com.sunweb.game.rpg.farm.LocalPlayerFarmInfo;
   import com.sunweb.game.rpg.farm.obf_0_1_N_478;
   import com.sunweb.game.rpg.map.Map;
   import com.sunweb.game.rpg.netRole.AINpc;
   import com.sunweb.game.rpg.netRole.RemotePlayer;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_0_Y_3475;
   import com.sunweb.game.rpg.team.TeamManager;
   import com.sunweb.game.rpg.team.TeamMemberInfo;
   import com.sunweb.game.rpg.world.map.MapManager;
   import com.sunweb.game.rpg.world.map.WorldMapManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.util.obf_e_P_918;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import img.FarmCollectIcon;
   import img.FarmCureIcon;
   import img.mapTeleportIcon;
   import playerUI.MapUIMC;
   
   public class MapUI extends MapUIMC implements IPlayerUI
   {
      
      private var mapSprite:Sprite = new Sprite();
      
      private var monsterSprite:Sprite = new Sprite();
      
      private var animalSprite:Sprite = new Sprite();
      
      private var playerSprite:Sprite = new Sprite();
      
      private var remoteSprite:Sprite = new Sprite();
      
      private var npcSprite:Sprite = new Sprite();
      
      private var farmSprite:Sprite = new Sprite();
      
      private var tipSprite:Sprite = new Sprite();
      
      private var titleSprite:Sprite = new Sprite();
      
      private var iconSprite:Sprite = new Sprite();
      
      private var obf_f_A_2243:Bitmap;
      
      private var worldMap:MovieClip;
      
      private var mapTime:TimeLimiter = new TimeLimiter(100);
      
      private var showFarmTimeInv:TimeLimiter = new TimeLimiter(5000);
      
      public function MapUI()
      {
         super();
         this.initDiversity();
         var _loc1_:int = cmdClose.y - 3;
         this.titleSprite.y = _loc1_;
         this.titleSprite.addChild(cmdClose);
         cmdClose.y -= _loc1_;
         this.titleSprite.addChild(cmdWorld);
         cmdWorld.y -= _loc1_;
         this.titleSprite.addChild(txtMapName);
         txtMapName.y -= _loc1_;
         this.titleSprite.addChild(txtLocation);
         txtLocation.y -= _loc1_;
         this.addChild(this.titleSprite);
         this.mapSprite.addChild(this.farmSprite);
         this.mapSprite.addChild(this.monsterSprite);
         this.mapSprite.addChild(this.animalSprite);
         this.mapSprite.addChild(this.remoteSprite);
         this.mapSprite.addChild(this.playerSprite);
         this.mapSprite.addChild(this.npcSprite);
         this.mapSprite.addChild(this.tipSprite);
         this.mapSprite.addChild(this.iconSprite);
         this.addChild(this.mapSprite);
         this.setChildIndex(npcList,this.numChildren - 1);
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(npcList.txtDeyNPCList,"MapUI","txtNPCList");
         DiversityManager.setTextField(npcList.txtDeyDoor,"MapUI","txtDoor");
         cmdWorld.label = DiversityManager.getString("MapUI","cmdWorld");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         txtMapName.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         npcList.txtList.addEventListener(TextEvent.LINK,this.obf_E_E_3099);
         npcList.txtPort.addEventListener(TextEvent.LINK,this.obf_E_E_3099);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.mapSprite.addEventListener(MouseEvent.CLICK,this.obf_k_w_2692);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClickClose);
         cmdWorld.addEventListener(MouseEvent.CLICK,this.obf_g_t_1382);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         txtMapName.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         npcList.txtList.removeEventListener(TextEvent.LINK,this.obf_E_E_3099);
         npcList.txtPort.removeEventListener(TextEvent.LINK,this.obf_E_E_3099);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.mapSprite.removeEventListener(MouseEvent.CLICK,this.obf_k_w_2692);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClickClose);
         cmdWorld.removeEventListener(MouseEvent.CLICK,this.obf_g_t_1382);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function obf_E_E_3099(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function onMouseOver(param1:Event) : void
      {
         obf_e_P_918.useDefaultCursor();
      }
      
      private function onClickClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function obf_g_t_1382(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
         obf_K_e_3075.showUI(obf_K_e_3075.worldMapUI);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.mapTime.checkTimeout() && this.visible)
         {
            this.updateSmallMap();
         }
      }
      
      private function obf_k_w_2692(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(Boolean(this.obf_f_A_2243) && Boolean(GameContext.localPlayer) && Boolean(GameContext.currentMap))
         {
            _loc2_ = this.mapSprite.mouseX / this.obf_f_A_2243.width;
            _loc3_ = this.mapSprite.mouseY / this.obf_f_A_2243.height;
            _loc4_ = _loc2_ * (GameContext.currentMap.mapWidth * Map.obf_7_7_3297);
            _loc5_ = _loc3_ * (GameContext.currentMap.mapHeight * Map.TILE_HEIGHT_IN_PIXEL);
            GameContext.localPlayer.obf_I_V_3724(_loc4_,_loc5_);
         }
      }
      
      public function showMap(param1:String) : void
      {
         if(Boolean(this.obf_f_A_2243) && this.mapSprite.contains(this.obf_f_A_2243))
         {
            this.mapSprite.removeChild(this.obf_f_A_2243);
            this.obf_f_A_2243.bitmapData.dispose();
            this.obf_f_A_2243.bitmapData = null;
         }
         txtMapName.text = WorldMapManager.getMapName(param1);
         this.obf_f_A_2243 = WorldMapManager.getSmallMap(param1);
         this.mapSprite.addChildAt(this.obf_f_A_2243,0);
         npcList.txtList.htmlText = "";
         while(this.tipSprite.numChildren > 0)
         {
            this.tipSprite.removeChildAt(0);
         }
         while(this.npcSprite.numChildren > 0)
         {
            this.npcSprite.removeChildAt(0);
         }
      }
      
      public function setMap(param1:Bitmap) : void
      {
         if(!param1)
         {
            return;
         }
         if(Boolean(this.obf_f_A_2243) && this.mapSprite.contains(this.obf_f_A_2243))
         {
            this.mapSprite.removeChild(this.obf_f_A_2243);
            this.obf_f_A_2243.bitmapData.dispose();
         }
         this.obf_f_A_2243 = param1;
         this.mapSprite.addChildAt(this.obf_f_A_2243,0);
      }
      
      public function refreshList() : void
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc7_:AINpc = null;
         var _loc8_:AINpc = null;
         var _loc9_:Array = null;
         var _loc10_:String = null;
         npcList.txtList.htmlText = "";
         npcList.txtPort.htmlText = "";
         if(!GameContext.currentMap)
         {
            return;
         }
         var _loc1_:String = "";
         var _loc2_:Array = new Array();
         for(_loc3_ in GameContext.currentMap.npcSet.obf_0_678)
         {
            _loc7_ = GameContext.currentMap.npcSet.getObject(_loc3_) as AINpc;
            if((Boolean(_loc7_)) && !JSONUtil.getBoolean(_loc7_.npcConfig,["hideInMiniMap"]))
            {
               _loc2_.push(_loc7_.npcConfig);
            }
         }
         _loc2_.sortOn("listOrder",Array.NUMERIC);
         for each(_loc4_ in _loc2_)
         {
            _loc8_ = GameContext.currentMap.npcSet.getObject(JSONUtil.getStr(_loc4_,["id"])) as AINpc;
            if(_loc8_)
            {
               _loc1_ += obf_g_u_3212.getNpcLinkCode(_loc8_.npcName,GameContext.currentMap.mapId,_loc8_.id) + "\n";
            }
         }
         npcList.txtList.htmlText = ChatDecoder.decode(_loc1_);
         npcList.scrollNpc.update();
         _loc5_ = "";
         for each(_loc6_ in MapManager.instance.mapInfo.exitArray)
         {
            if(_loc6_.toEntry.indexOf("@") != -1)
            {
               _loc9_ = _loc6_.rect.split(",");
               _loc10_ = WorldMapManager.getMapName(_loc6_.toEntry.split("@").reverse()[0]);
               if(!obf_L_l_4100.isEmpty(_loc10_))
               {
                  _loc5_ += obf_g_u_3212.getMapLinkCode(_loc10_,GameContext.currentMap.mapId,_loc9_[0] * Map.obf_7_7_3297,_loc9_[1] * Map.TILE_HEIGHT_IN_PIXEL) + "\n";
               }
            }
         }
         npcList.txtPort.htmlText = ChatDecoder.decode(_loc5_);
         npcList.scrollPort.update();
      }
      
      private function updateSmallMap() : void
      {
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc11_:LocalPlayerFarmInfo = null;
         var _loc12_:Array = null;
         var _loc13_:Object = null;
         var _loc14_:obf_0_1_N_478 = null;
         var _loc15_:TextField = null;
         var _loc16_:Array = null;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:mapTeleportIcon = null;
         var _loc20_:TextField = null;
         var _loc21_:TextFormat = null;
         var _loc22_:Object = null;
         var _loc23_:TeamMemberInfo = null;
         var _loc24_:RemotePlayer = null;
         var _loc25_:Array = null;
         var _loc26_:obf_0_Y_3475 = null;
         var _loc27_:obf_0_Y_3475 = null;
         if(!GameContext.localPlayer || !GameContext.currentMap || !this.obf_f_A_2243)
         {
            return;
         }
         var _loc1_:Number = Math.min(700 / this.obf_f_A_2243.bitmapData.width,400 / this.obf_f_A_2243.bitmapData.height);
         if(this.obf_f_A_2243.scaleX != _loc1_ || this.obf_f_A_2243.scaleY != _loc1_)
         {
            this.obf_f_A_2243.scaleX = _loc1_;
            this.obf_f_A_2243.scaleY = _loc1_;
         }
         bgBox.width = this.obf_f_A_2243.width + 50;
         bgBox.height = this.obf_f_A_2243.height + 70;
         bgBox.y = -20;
         npcList.x = bgBox.width / 2 + 2;
         this.titleSprite.y = -(bgBox.height / 2) - 10;
         cmdClose.x = bgBox.width / 2 - cmdClose.width;
         cmdWorld.x = bgBox.width / 2 - cmdWorld.width - 10;
         this.mapSprite.x = -(this.obf_f_A_2243.width / 2);
         this.mapSprite.y = -(this.obf_f_A_2243.height / 2);
         if(Boolean(this.tipSprite.numChildren == 0) && Boolean(this.obf_f_A_2243.bitmapData) && this.obf_f_A_2243.bitmapData.width > 1)
         {
            _loc10_ = [GameContext.localPlayer.fullInfo.mainFarm].concat(GameContext.localPlayer.fullInfo.extraFarmArray);
            for each(_loc11_ in _loc10_)
            {
               if(_loc11_)
               {
                  if(_loc11_.mapId == MapManager.instance.map.mapId)
                  {
                     _loc14_ = MapManager.instance.map.obf_v_P_2126.getFarm(_loc11_.farmId);
                     if(_loc14_)
                     {
                        _loc15_ = new TextField();
                        _loc15_.autoSize = TextFieldAutoSize.LEFT;
                        _loc15_.mouseEnabled = false;
                        _loc15_.selectable = false;
                        _loc15_.filters = [new DropShadowFilter(1,45,0,1,0,0,200)];
                        _loc15_.textColor = 65280;
                        DiversityManager.setTextField(_loc15_,"MapUI","myFarm",null,true);
                        _loc15_.x = _loc14_.rootX / GameContext.currentMap.mapWidth * this.obf_f_A_2243.width - _loc15_.textWidth / 2;
                        _loc15_.y = _loc14_.rootY / GameContext.currentMap.mapHeight * this.obf_f_A_2243.height;
                        this.tipSprite.addChild(_loc15_);
                     }
                  }
               }
            }
            _loc12_ = MapManager.instance.mapInfo.exitArray;
            for each(_loc13_ in _loc12_)
            {
               _loc16_ = _loc13_.rect.split(",");
               _loc17_ = _loc16_[0] / GameContext.currentMap.mapWidth * this.obf_f_A_2243.width;
               _loc18_ = _loc16_[1] / GameContext.currentMap.mapHeight * this.obf_f_A_2243.height;
               _loc19_ = new mapTeleportIcon();
               _loc19_.x = _loc17_;
               _loc19_.y = _loc18_;
               this.tipSprite.addChild(_loc19_);
               _loc20_ = new TextField();
               _loc20_.width = 200;
               _loc21_ = new TextFormat();
               _loc21_.size = 12;
               _loc20_.defaultTextFormat = _loc21_;
               _loc20_.mouseEnabled = false;
               _loc20_.text = WorldMapManager.getMapName(_loc13_.toEntry.split("@").reverse()[0]);
               _loc20_.textColor = 16777215;
               _loc20_.x = _loc17_ - _loc20_.textWidth / 2;
               _loc20_.y = _loc18_ - 30;
               _loc20_.filters = [new DropShadowFilter(1,45,0,1,0,0,3)];
               this.tipSprite.addChild(_loc20_);
            }
            this.tipSprite.addChild(new Sprite());
         }
         var _loc2_:Number = this.mapSprite.mouseX / this.obf_f_A_2243.width;
         var _loc3_:Number = this.mapSprite.mouseY / this.obf_f_A_2243.height;
         var _loc4_:int = Math.min(Math.max(_loc2_ * GameContext.currentMap.mapWidth,0),GameContext.currentMap.mapWidth);
         var _loc5_:int = Math.min(Math.max(_loc3_ * GameContext.currentMap.mapHeight / 2,0),GameContext.currentMap.mapHeight / 2);
         txtLocation.text = "X:" + _loc4_ + " Y:" + _loc5_;
         var _loc6_:int = GameContext.currentMap.mapWidth * Map.obf_7_7_3297;
         var _loc7_:int = GameContext.currentMap.mapHeight * Map.TILE_HEIGHT_IN_PIXEL;
         if(this.showFarmTimeInv.checkTimeout())
         {
            this.obf_t_w_1459();
         }
         WorldMapManager.showLocalPlayerPoint(_loc6_,_loc7_,this.obf_f_A_2243.width,this.obf_f_A_2243.height,this.playerSprite);
         WorldMapManager.showNpcPoint(_loc6_,_loc7_,this.obf_f_A_2243.width,this.obf_f_A_2243.height,this.npcSprite,GameContext.currentMap.npcSet.obf_0_678);
         WorldMapManager.drawMapObjectPoint(_loc6_,_loc7_,this.obf_f_A_2243.width,this.obf_f_A_2243.height,this.remoteSprite,GameContext.currentMap.remotePlayerSet.obf_3_C_4291,255,255);
         if(TeamManager.teamName != "")
         {
            _loc22_ = new Object();
            for each(_loc23_ in TeamManager.teamMembers)
            {
               if(_loc23_.name != GameContext.localPlayer.id)
               {
                  _loc24_ = GameContext.currentMap.remotePlayerSet.getObject(_loc23_.name) as RemotePlayer;
                  if(_loc24_)
                  {
                     _loc22_[_loc24_.id] = _loc24_;
                  }
               }
            }
            WorldMapManager.drawMapObjectPoint(_loc6_,_loc7_,this.obf_f_A_2243.width,this.obf_f_A_2243.height,this.remoteSprite,_loc22_,65280,16776960,1,3,false);
         }
         WorldMapManager.drawMapObjectPoint(_loc6_,_loc7_,this.obf_f_A_2243.width,this.obf_f_A_2243.height,this.monsterSprite,GameContext.currentMap.monsterSet.obf_3_C_4291,16711680,16711680);
         WorldMapManager.drawMapObjectPoint(_loc6_,_loc7_,this.obf_f_A_2243.width,this.obf_f_A_2243.height,this.animalSprite,GameContext.currentMap.animalSet.obf_3_C_4291,11802581,11802581);
         var _loc8_:Object = JSONUtil.getObject(MapManager.instance.mapInfo,["rules","commonRule","buffedCreatureOnMap"]);
         this.iconSprite.graphics.clear();
         for(_loc9_ in _loc8_)
         {
            _loc25_ = new Array();
            if(GameContext.localPlayer.haveBuff(int(_loc9_)))
            {
               _loc25_.push(GameContext.localPlayer);
            }
            for each(_loc26_ in GameContext.currentMap.remotePlayerSet.obf_0_678)
            {
               if(Boolean(_loc26_) && _loc26_.haveBuff(int(_loc9_)))
               {
                  _loc25_.push(_loc26_);
               }
            }
            for each(_loc27_ in GameContext.currentMap.monsterSet.obf_0_678)
            {
               if(Boolean(_loc27_) && _loc27_.haveBuff(int(_loc9_)))
               {
                  _loc25_.push(_loc27_);
               }
            }
            if(_loc25_.length > 0)
            {
               WorldMapManager.drawMapObjectIcon(_loc6_,_loc7_,this.obf_f_A_2243.width,this.obf_f_A_2243.height,this.iconSprite,_loc25_,_loc8_[_loc9_],false);
            }
         }
      }
      
      public function obf_t_w_1459() : void
      {
         var _loc3_:String = null;
         var _loc4_:AIFarmHarvest = null;
         var _loc5_:obf_0_1_N_478 = null;
         if(!GameContext.localPlayer || !GameContext.currentMap || !this.obf_f_A_2243 || this.obf_f_A_2243.bitmapData.width <= 1)
         {
            return;
         }
         var _loc1_:Array = new Array();
         var _loc2_:Array = new Array();
         for(_loc3_ in GameContext.currentMap.obf_b_h_1770.obf_0_678)
         {
            _loc4_ = GameContext.currentMap.obf_b_h_1770.getObject(_loc3_) as AIFarmHarvest;
            _loc5_ = _loc4_.getFarm();
            if(_loc5_)
            {
               if(_loc4_.currentPhaseConfig.phaseType == 2 && _loc4_.getCanStealNumber() > 0 && _loc1_.indexOf(_loc5_) == -1)
               {
                  _loc1_.push(_loc5_);
               }
               if(_loc4_.isIll && _loc2_.indexOf(_loc5_) == -1)
               {
                  _loc2_.push(_loc5_);
               }
            }
         }
         while(this.farmSprite.numChildren > 0)
         {
            this.farmSprite.removeChildAt(0);
         }
         WorldMapManager.showMapObject(GameContext.currentMap.mapWidthInPixel,GameContext.currentMap.mapHeightInPixel,this.obf_f_A_2243.width,this.obf_f_A_2243.height,this.farmSprite,_loc1_,FarmCollectIcon);
         WorldMapManager.showMapObject(GameContext.currentMap.mapWidthInPixel,GameContext.currentMap.mapHeightInPixel,this.obf_f_A_2243.width,this.obf_f_A_2243.height,this.farmSprite,_loc2_,FarmCureIcon);
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
         if(Boolean(this.obf_f_A_2243) && this.mapSprite.contains(this.obf_f_A_2243))
         {
            this.mapSprite.removeChild(this.obf_f_A_2243);
            this.obf_f_A_2243.bitmapData.dispose();
         }
         this.removeListener();
      }
   }
}

