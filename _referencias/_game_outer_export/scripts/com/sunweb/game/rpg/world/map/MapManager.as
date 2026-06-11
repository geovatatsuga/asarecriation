package com.sunweb.game.rpg.world.map
{
   import com.adobe.serialization.json.JSON;
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.res.obf_J_Y_3494;
   import com.sunweb.game.res.obf_e_4650;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.farm.AIFarmHarvest;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.map.Map;
   import com.sunweb.game.rpg.map.obf_z_T_3316;
   import com.sunweb.game.rpg.netRole.AINpc;
   import com.sunweb.game.rpg.netRole.AIObjectsBufferManager;
   import com.sunweb.game.rpg.netRole.RemotePlayer;
   import com.sunweb.game.rpg.netRole.RemotePlayerBuffer;
   import com.sunweb.game.rpg.netRole.obf_9_c_4534;
   import com.sunweb.game.rpg.netRole.obf_T_L_801;
   import com.sunweb.game.rpg.playerUI.managers.VersionConfig;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.role.obf_0_Y_3475;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.skill.SkillManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.util.digraph.obf_h_8_875;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import gs.TweenLite;
   import gs.easing.obf_u_l_3524;
   
   public class MapManager extends EventDispatcher
   {
      
      private static var _instance:MapManager;
      
      private static var _mapBags:Array = new Array();
      
      private var _map:Map;
      
      private var _mapInfo:Object;
      
      private var _createMapId:String;
      
      private var _mapState:String;
      
      private var _mapInfoBag:ResourceBag;
      
      private var _smallMapBitmapData:BitmapData;
      
      private var _smallMapMatrix:Matrix = new Matrix();
      
      private var uiTween:TweenLite;
      
      private var obf_p_f_1209:uint;
      
      private var throughMapConfig:Array;
      
      private var refreshNpcTime:TimeLimiter = new TimeLimiter(2000);
      
      private var selectedRecentList:Array;
      
      private var currentRecentIndex:int;
      
      private var autoPickTimeInv:TimeLimiter = new TimeLimiter(300);
      
      private var obf_x_r_3569:String;
      
      private var obf_0_4_y_550:int;
      
      private var obf_c_r_2283:int;
      
      public function MapManager()
      {
         super();
         MapManager._instance = this;
      }
      
      public static function get instance() : MapManager
      {
         return _instance;
      }
      
      private static function getMapBag(param1:String) : ResourceBag
      {
         var _loc2_:ResourceBag = null;
         var _loc3_:int = 0;
         while(_loc3_ < _mapBags.length)
         {
            if(_mapBags[_loc3_] == param1)
            {
               _loc2_ = ResourceManager.instance.getBag(param1,true);
               _mapBags.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
         if(!_loc2_)
         {
            _loc2_ = ResourceManager.instance.getBag(param1,true);
         }
         _mapBags.push(param1);
         if(_mapBags.length > 2)
         {
            ResourceManager.instance.destroyBag(_mapBags.shift() as String);
         }
         return _loc2_;
      }
      
      public function get map() : Map
      {
         return this._map;
      }
      
      public function get mapInfo() : Object
      {
         return this._mapInfo;
      }
      
      public function get mapState() : String
      {
         return this._mapState;
      }
      
      public function showMapFastMoveBlur(param1:obf_0_Y_3475, param2:int, param3:int) : void
      {
         var rct:Rectangle = null;
         var dbp:BitmapData = null;
         var v:Number = NaN;
         var ap:Number = NaN;
         var thisDbp:BitmapData = null;
         var display:Bitmap = null;
         var mapObject:obf_0_Y_3475 = param1;
         var targetX:int = param2;
         var targetY:int = param3;
         if(!this._map)
         {
            return;
         }
         try
         {
            rct = mapObject.bodySprite.getRect(mapObject.bodySprite);
            dbp = new BitmapData(Math.min(rct.width,1000),Math.min(rct.height,1000),true,0);
            dbp.draw(mapObject.bodySprite,new Matrix(1,0,0,1,-rct.x,-rct.y));
            if(!dbp)
            {
               return;
            }
            v = 0.3;
            ap = 0.8;
            while(v <= 0.5)
            {
               thisDbp = dbp.clone();
               if(thisDbp)
               {
                  display = new Bitmap(thisDbp);
                  display.alpha = ap;
                  display.x = mapObject.rootPX + rct.x;
                  display.y = mapObject.rootPY + rct.y;
                  this._map.addChild(display);
                  this.uiTween = TweenLite.to(display,v,{
                     "x":targetX + rct.x,
                     "y":targetY + rct.y,
                     "onComplete":this.obf_0_3_y_696,
                     "onCompleteParams":[display]
                  });
               }
               v += 0.1;
               ap -= 0.2;
            }
            dbp.dispose();
         }
         catch(e:Error)
         {
         }
      }
      
      public function showMapFastMoveObject(param1:obf_0_Y_3475, param2:int, param3:int, param4:Number) : void
      {
         if(!this._map)
         {
            return;
         }
         var _loc5_:Rectangle = param1.getRect(param1);
         var _loc6_:BitmapData = new BitmapData(Math.min(_loc5_.width,1000),Math.min(_loc5_.height,1000),true,0);
         _loc6_.draw(param1.bodySprite,new Matrix(1,0,0,1,-_loc5_.x,-_loc5_.y));
         if(!_loc6_)
         {
            return;
         }
         var _loc7_:Bitmap = new Bitmap(_loc6_);
         _loc7_.x = param1.rootPX + _loc5_.x;
         _loc7_.y = param1.rootPY + _loc5_.y;
         this._map.addChild(_loc7_);
         this.uiTween = TweenLite.to(_loc7_,param4,{
            "x":param2 + _loc5_.x,
            "y":param3 + _loc5_.y,
            "ease":obf_u_l_3524.easeOut,
            "onComplete":this.obf_0_3_y_696,
            "onCompleteParams":[_loc7_]
         });
      }
      
      private function obf_0_3_y_696(param1:Bitmap) : void
      {
         if(Boolean(this._map) && this._map.contains(param1))
         {
            this._map.removeChild(param1);
         }
         param1.bitmapData.dispose();
      }
      
      public function createMap(param1:String) : void
      {
         clearTimeout(this.obf_p_f_1209);
         this.release();
         this._createMapId = param1;
         this._mapState = MapState.LOADING_INFO;
         this._mapInfoBag = ResourceManager.instance.getBag(param1,true);
         this._mapInfoBag.loader.addEventListener(obf_J_Y_3494.COMPLETE,this.onMapInfoLoadComplete);
         this._mapInfoBag.loader.addEventListener(obf_J_Y_3494.obf_9_a_1908,this.onMapInfoLoadError);
         this._mapInfoBag.obf_z_U_2156("m" + param1);
         if(this._mapInfoBag.loader.loadingState == obf_e_4650.COMPLETE)
         {
            this.obf_p_f_1209 = setTimeout(this.onMapInfoLoadComplete,500,null);
         }
         else
         {
            this._mapInfoBag.load();
         }
      }
      
      private function onMapInfoLoadComplete(param1:obf_J_Y_3494) : void
      {
         this._mapInfoBag.loader.removeEventListener(obf_J_Y_3494.COMPLETE,this.onMapInfoLoadComplete);
         this._mapInfoBag.loader.removeEventListener(obf_J_Y_3494.obf_9_a_1908,this.onMapInfoLoadError);
         var _loc2_:String = ResourceManager.instance.getText("m" + this._createMapId);
         if(obf_L_l_4100.isEmpty(_loc2_))
         {
            throw new Error("map \'" + this._createMapId + "\' config is null!");
         }
         this._mapInfo = com.adobe.serialization.json.JSON.decode(_loc2_);
         if(VersionConfig.isPVEMap(this._createMapId) && JSONUtil.getBoolean(this._mapInfo,["rules","pkRule","enablePK"]))
         {
            this._mapInfo.rules.pkRule.enablePK = false;
            _loc2_ = com.adobe.serialization.json.JSON.encode(this._mapInfo);
         }
         this._map = new Map(_loc2_);
         this.loadMapData();
      }
      
      private function onMapInfoLoadError(param1:Event) : void
      {
         this._mapInfoBag.load();
      }
      
      private function loadMapData() : void
      {
         var _loc1_:ResourceBag = getMapBag(this._map.mapId);
         this._map.resourceBag = _loc1_;
         var _loc2_:int = 0;
         while(_loc2_ < this._map.resourcesToImport.length)
         {
            _loc1_.obf_z_U_2156(this._map.resourcesToImport[_loc2_]);
            _loc2_++;
         }
         this._mapState = MapState.LOADING_DATA;
         var _loc3_:MapManagerEvent = new MapManagerEvent(MapManagerEvent.MAP_START_LOAD);
         _loc3_.mapBag = _loc1_;
         this.dispatchEvent(_loc3_);
         if(_loc1_.loader.loadingState == obf_e_4650.COMPLETE)
         {
            this.onMapDataLoadComplete(null);
         }
         else
         {
            _loc1_.loader.addEventListener(obf_J_Y_3494.COMPLETE,this.onMapDataLoadComplete);
            _loc1_.load();
         }
      }
      
      private function onMapDataLoadComplete(param1:obf_J_Y_3494) : void
      {
         var mwe:MapManagerEvent;
         var e:obf_J_Y_3494 = param1;
         this._mapState = MapState.ISDONE;
         try
         {
            e.target.removeEventListener(obf_J_Y_3494.COMPLETE,this.onMapDataLoadComplete);
         }
         catch(e:Error)
         {
         }
         mwe = new MapManagerEvent(MapManagerEvent.MAP_CREATE_COMPLETE);
         mwe.map = this._map;
         this.dispatchEvent(mwe);
      }
      
      public function obf_5_G_1974() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Boolean = false;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:AINpc = null;
         var _loc6_:AINpc = null;
         if(!this.map || this._mapState != MapState.ISDONE)
         {
            return;
         }
         for each(_loc1_ in this.mapInfo.npcList)
         {
            _loc2_ = true;
            _loc3_ = JSONUtil.getObject(_loc1_,["activity"]) as Array;
            if(Boolean(_loc3_) && _loc3_.length > 0)
            {
               _loc2_ = obf_J_F_3431.obf_U_Q_3887(_loc3_);
            }
            _loc4_ = JSONUtil.getObject(_loc1_,["mapLineIndex"]) as Array;
            if((Boolean(_loc4_)) && _loc4_.length > 0)
            {
               if(_loc4_.indexOf(GameContext.localPlayer.fullInfo.lineIndex) == -1)
               {
                  this.map.npcSet.removeObject(this.map.npcSet.getObject(_loc1_.id),true);
                  continue;
               }
            }
            if(_loc2_ && (!_loc1_.showIf || ConditionScript.checkCondition(_loc1_.showIf,GameContext.localPlayer.dynamicVars)) && (!_loc1_.hideIf || com.adobe.serialization.json.JSON.encode(_loc1_.hideIf) == "{}" || !ConditionScript.checkCondition(_loc1_.hideIf,GameContext.localPlayer.dynamicVars)))
            {
               if(!this.map.npcSet.getObject(_loc1_.id))
               {
                  _loc5_ = new AINpc(_loc1_,this.map.mapId);
                  this.map.npcSet.addObject(_loc5_);
               }
            }
            else
            {
               _loc6_ = this.map.npcSet.getObject(_loc1_.id) as AINpc;
               if(_loc6_)
               {
                  this.map.npcSet.removeObject(_loc6_,true);
                  if(Boolean(obf_K_e_3075.npcTalkBox) && obf_K_e_3075.npcTalkBox.npcId == _loc1_.id)
                  {
                     obf_K_e_3075.closeUI(obf_K_e_3075.npcTalkBox);
                  }
               }
            }
         }
      }
      
      public function getThroughMapArray(param1:String, param2:String) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:obf_h_8_875 = null;
         var _loc6_:Object = null;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         if(!this.throughMapConfig || this.throughMapConfig.length == 0)
         {
            this.throughMapConfig = com.adobe.serialization.json.JSON.decode(ResourceManager.instance.getText("iml")) as Array;
         }
         if(!this.throughMapConfig || this.throughMapConfig.length == 0)
         {
            return null;
         }
         for each(_loc6_ in this.throughMapConfig)
         {
            _loc3_ = int(_loc6_.maps.indexOf(param1));
            _loc4_ = int(_loc6_.maps.indexOf(param2));
            if(!(_loc3_ == -1 || _loc4_ == -1))
            {
               _loc5_ = new obf_h_8_875(_loc6_.maps);
               for each(_loc7_ in _loc6_.links)
               {
                  _loc5_.obf_N_z_2177(_loc7_[0],_loc7_[1]);
               }
               _loc8_ = _loc5_.getShortestPath(_loc3_,_loc4_);
               _loc9_ = new Array();
               for each(_loc10_ in _loc8_)
               {
                  _loc9_.push(_loc6_.maps[_loc10_]);
               }
               return _loc9_.length > 0 ? _loc9_ : null;
            }
         }
         return null;
      }
      
      public function release() : void
      {
         var thisRemote:RemotePlayer = null;
         try
         {
            this._mapInfoBag.loader.removeEventListener(obf_J_Y_3494.COMPLETE,this.onMapInfoLoadComplete);
            this._mapInfoBag.loader.removeEventListener(obf_J_Y_3494.obf_9_a_1908,this.onMapInfoLoadError);
            this._map.resourceBag.loader.removeEventListener(obf_J_Y_3494.COMPLETE,this.onMapDataLoadComplete);
         }
         catch(e:Error)
         {
         }
         if(this._map)
         {
            for each(thisRemote in this._map.remotePlayerSet.obf_0_678)
            {
               if(thisRemote.isInStage)
               {
                  RemotePlayerBuffer.addRemoteToBuffer(thisRemote);
               }
               if(RemotePlayerBuffer.getRemoteFromBuffer(thisRemote.id) == thisRemote)
               {
                  this._map.remotePlayerSet.removeObject(thisRemote);
               }
            }
            if(this._map.parent)
            {
               this._map.parent.removeChild(this._map);
            }
            this._map.setListener(null);
            this._map.destroy();
         }
         this._map = null;
         if(this._smallMapBitmapData)
         {
            this._smallMapBitmapData.dispose();
         }
         AIObjectsBufferManager.clearBag();
      }
      
      public function refreshNPCTask() : void
      {
      }
      
      public function doRefreshNPCTask() : void
      {
         var _loc1_:String = null;
         if(Boolean(this.refreshNpcTime) && this.refreshNpcTime.checkTimeout())
         {
            if(this._map)
            {
               for(_loc1_ in this._map.npcSet.obf_0_678)
               {
                  AINpc(this._map.npcSet.obf_0_678[_loc1_]).refreshTask();
               }
            }
         }
      }
      
      public function seleteRecentTarget(param1:String = "") : void
      {
         var _loc2_:obf_0_Y_3475 = null;
         if(!this._map)
         {
            return;
         }
         if(!this.selectedRecentList)
         {
            this.selectedRecentList = new Array();
         }
         if(obf_L_l_4100.isEmpty(param1))
         {
            _loc2_ = this.getSkillTargetPlayer(PlayerSkillManager.defaultAttackSkillCode,500,this.selectedRecentList);
         }
         if(!_loc2_ && obf_L_l_4100.isEmpty(param1))
         {
            _loc2_ = this.getSkillTargetAnimal(PlayerSkillManager.defaultAttackSkillCode,500,this.selectedRecentList);
         }
         if(!_loc2_)
         {
            _loc2_ = this.getRecentMonster(param1,500,this.selectedRecentList);
         }
         if(_loc2_)
         {
            GameContext.localPlayer.selectTarget(_loc2_);
            this.selectedRecentList.push(_loc2_.id);
         }
         else
         {
            this.clearRecentList();
         }
      }
      
      public function clearRecentList() : void
      {
         this.selectedRecentList = new Array();
      }
      
      public function getRecentMonster(param1:String = "", param2:int = 500, param3:Array = null, param4:Array = null, param5:int = 0) : obf_T_L_801
      {
         var _loc6_:obf_T_L_801 = null;
         var _loc8_:String = null;
         var _loc9_:obf_T_L_801 = null;
         var _loc10_:int = 0;
         if(!this._map)
         {
            return null;
         }
         var _loc7_:int = int.MAX_VALUE;
         if(param1 == "*")
         {
            param1 = "";
         }
         for(_loc8_ in this._map.monsterSet.obf_3_C_4291)
         {
            _loc9_ = this._map.monsterSet.getObject(_loc8_) as obf_T_L_801;
            if(!(!_loc9_ || _loc9_.isDead))
            {
               if(!(param5 > 0 && JSONUtil.getInt(_loc9_.config,["bossLevel"]) >= param5))
               {
                  if(!(Boolean(param4) && param4.indexOf(_loc9_.monsterCode) > -1))
                  {
                     if(!(Boolean(param3) && param3.indexOf(_loc8_) > -1))
                     {
                        if(!(!obf_L_l_4100.isEmpty(param1) && param1.indexOf(_loc9_.monsterCode) == -1 && param1.indexOf(_loc9_.obf_w_I_2773) == -1))
                        {
                           _loc10_ = GameContext.localPlayer.getLineDistance(_loc9_);
                           if(_loc10_ <= param2)
                           {
                              if(_loc10_ < _loc7_ && SkillManager.instance.checkTarget(SkillConfig.getSkillConfig(WorldConfig.getDefaultAttackSkillCode(GameContext.localPlayer.fullInfo.jobCode)),_loc9_))
                              {
                                 _loc6_ = _loc9_;
                                 _loc7_ = _loc10_;
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         return _loc6_;
      }
      
      public function getSkillTargetPlayer(param1:String, param2:int = 500, param3:Array = null) : RemotePlayer
      {
         var _loc4_:RemotePlayer = null;
         var _loc6_:String = null;
         var _loc7_:RemotePlayer = null;
         var _loc8_:int = 0;
         if(!this._map)
         {
            return null;
         }
         var _loc5_:int = int.MAX_VALUE;
         for(_loc6_ in this._map.remotePlayerSet.obf_3_C_4291)
         {
            _loc7_ = this._map.remotePlayerSet.getObject(_loc6_) as RemotePlayer;
            if(!(!_loc7_ || _loc7_.isDead))
            {
               if(!(Boolean(param3) && param3.indexOf(_loc6_) > -1))
               {
                  _loc8_ = GameContext.localPlayer.getLineDistance(_loc7_);
                  if(_loc8_ <= param2)
                  {
                     if(_loc8_ < _loc5_ && SkillManager.instance.checkTarget(SkillConfig.getSkillConfig(param1),_loc7_))
                     {
                        _loc4_ = _loc7_;
                        _loc5_ = _loc8_;
                     }
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public function getSkillTargetAnimal(param1:String, param2:int = 500, param3:Array = null) : obf_9_c_4534
      {
         var _loc4_:obf_9_c_4534 = null;
         var _loc6_:String = null;
         var _loc7_:obf_9_c_4534 = null;
         var _loc8_:int = 0;
         if(!this._map)
         {
            return null;
         }
         var _loc5_:int = int.MAX_VALUE;
         for(_loc6_ in this._map.animalSet.obf_3_C_4291)
         {
            _loc7_ = this._map.animalSet.getObject(_loc6_) as obf_9_c_4534;
            if(!(!_loc7_ || _loc7_.isDead))
            {
               if(!(Boolean(param3) && param3.indexOf(_loc6_) > -1))
               {
                  if(_loc7_ != GameContext.localPlayer.obf_F_o_1931)
                  {
                     _loc8_ = GameContext.localPlayer.getLineDistance(_loc7_);
                     if(_loc8_ <= param2)
                     {
                        if(_loc8_ < _loc5_ && SkillManager.instance.checkTarget(SkillConfig.getSkillConfig(param1),_loc7_))
                        {
                           _loc4_ = _loc7_;
                           _loc5_ = _loc8_;
                        }
                     }
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public function getMonsterCodeList() : Array
      {
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc1_:Array = new Array();
         var _loc2_:Array = JSONUtil.getObject(this._mapInfo,["monsterRule","monsterArray"]) as Array;
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = JSONUtil.getStr(_loc3_,["code"]);
            if(_loc1_.indexOf(_loc4_) == -1)
            {
               _loc1_.push(_loc4_);
            }
         }
         return _loc1_;
      }
      
      public function getRecentFarmHarvest(param1:String = "", param2:Array = null) : AIFarmHarvest
      {
         var _loc4_:AIFarmHarvest = null;
         var _loc5_:String = null;
         var _loc6_:AIFarmHarvest = null;
         var _loc7_:int = 0;
         if(!this._map || !GameContext.localPlayer)
         {
            return null;
         }
         if(param1 == "*")
         {
            param1 = "";
         }
         var _loc3_:int = int.MAX_VALUE;
         for(_loc5_ in this._map.obf_b_h_1770.obf_3_C_4291)
         {
            _loc6_ = this._map.obf_b_h_1770.getObject(_loc5_) as AIFarmHarvest;
            _loc7_ = GameContext.localPlayer.getLineDistance(_loc6_);
            if(_loc7_ < _loc3_)
            {
               _loc3_ = _loc7_;
               if(param1 == "" || param1.indexOf(_loc6_.obf_R_J_2909) > -1 || param1.indexOf(_loc6_.obf_i_H_2166) > -1)
               {
                  if(!param2 || param2.indexOf(_loc6_.id) == -1)
                  {
                     _loc4_ = _loc6_;
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public function autoPickUpItem() : void
      {
         var _loc1_:obf_z_T_3316 = null;
         if(this.autoPickTimeInv.checkTimeout() && Boolean(this._map))
         {
            _loc1_ = this.getMapItemInSight();
            if(_loc1_)
            {
               GameContext.bagItemManager.sendPickUpItem(_loc1_.id);
            }
         }
      }
      
      public function getMapItemInSight(param1:int = 16777215, param2:Object = null, param3:Boolean = true, param4:int = 350) : obf_z_T_3316
      {
         var _loc5_:String = null;
         var _loc6_:obf_z_T_3316 = null;
         var _loc7_:Object = null;
         var _loc8_:Array = null;
         if(!this._map || !GameContext.localPlayer)
         {
            return null;
         }
         var _loc9_:int = 0;
         var _loc10_:* = this._map.itemSet.obf_3_C_4291;
         while(true)
         {
            for(_loc5_ in _loc10_)
            {
               _loc6_ = this._map.itemSet.getObject(_loc5_) as obf_z_T_3316;
               if(_loc6_)
               {
                  if(!(param3 && _loc6_.isInProtection))
                  {
                     if(GameContext.localPlayer.getLineDistance(_loc6_) <= param4)
                     {
                        _loc7_ = GameItemManager.getItemConfig(_loc6_.code);
                        if(_loc7_)
                        {
                           if(GameItemType.contrastType(param1,_loc7_.type))
                           {
                              if(!param2)
                              {
                                 break;
                              }
                              _loc8_ = param2[_loc7_.type];
                              if(!((Boolean(_loc8_)) && Boolean(_loc8_.length > 0) && _loc8_.indexOf(_loc7_.rank) == -1))
                              {
                                 break;
                              }
                           }
                        }
                     }
                  }
               }
            }
            return null;
         }
         return _loc6_;
      }
      
      public function checkSkillRule(param1:String) : Boolean
      {
         if(!this._mapInfo)
         {
            return false;
         }
         if(Boolean(this._mapInfo.rules) && Boolean(this._mapInfo.rules.skillRule))
         {
            if(this._mapInfo.rules.skillRule.enabledSkills)
            {
               if(this._mapInfo.rules.skillRule.enabledSkills.length == 0)
               {
                  return true;
               }
               if(this._mapInfo.rules.skillRule.enabledSkills.indexOf(param1) > -1)
               {
                  return true;
               }
               return false;
            }
            if(this._mapInfo.rules.skillRule.disabledSkills)
            {
               if(this._mapInfo.rules.skillRule.disabledSkills.indexOf(param1) > -1)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function checkExpendableRule(param1:String) : Boolean
      {
         if(!this._mapInfo)
         {
            return false;
         }
         if(Boolean(this._mapInfo.rules) && Boolean(this._mapInfo.rules.expendableRule))
         {
            if(this._mapInfo.rules.expendableRule.enabledItems)
            {
               if(this._mapInfo.rules.expendableRule.enabledItems.length == 0)
               {
                  return true;
               }
               if(this._mapInfo.rules.expendableRule.enabledItems.indexOf(param1) > -1)
               {
                  return true;
               }
               return false;
            }
            if(this._mapInfo.rules.expendableRule.disabledItems)
            {
               if(this._mapInfo.rules.expendableRule.disabledItems.indexOf(param1) > -1)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function obf_C_O_3385() : Boolean
      {
         if(!this._mapInfo)
         {
            return false;
         }
         return !JSONUtil.getBoolean(this._mapInfo,["rules","commonRule","disableRide"]);
      }
      
      public function setMyMapDPSRank(param1:int, param2:String) : void
      {
         this.obf_x_r_3569 = param2;
         this.obf_0_4_y_550 = param1;
      }
      
      public function setMyMapDPSValue(param1:int) : void
      {
         this.obf_c_r_2283 = param1;
      }
      
      public function getMyMapDPSRank() : int
      {
         if(!this.map || this.map.mapId != this.obf_x_r_3569)
         {
            return 0;
         }
         return this.obf_0_4_y_550;
      }
      
      public function getMyDPSValue() : int
      {
         if(!this.map || this.map.mapId != this.obf_x_r_3569)
         {
            return 0;
         }
         return this.obf_c_r_2283;
      }
   }
}

