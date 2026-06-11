package com.sunweb.game.rpg.world.map
{
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.res.obf_A_P_806;
   import com.sunweb.game.res.obf_J_Y_3494;
   import com.sunweb.game.res.obf_b_8_4256;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.farm.obf_0_1_N_478;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.map.MapObject;
   import com.sunweb.game.rpg.netRole.AINpc;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import img.MapDestination;
   import img.MapSelfIcon;
   
   public class WorldMapManager
   {
      
      private static var worldMapObject:Object;
      
      private static var maps:Object;
      
      private static var mapnames:Object;
      
      private static var mapInLand:Object;
      
      private static var smallMaps:Object = new Object();
      
      public function WorldMapManager()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         worldMapObject = param1;
         maps = new Object();
         mapnames = new Object();
         mapInLand = new Object();
         for each(_loc2_ in worldMapObject.lands)
         {
            for each(_loc3_ in _loc2_.regions)
            {
               for each(_loc4_ in _loc3_.maps)
               {
                  maps[_loc4_.mapId] = _loc4_;
                  mapnames[_loc4_.mapName] = _loc4_;
                  mapInLand[_loc4_.mapId] = _loc2_.landCode;
               }
            }
         }
      }
      
      public static function getAllLandCodes() : Array
      {
         var _loc2_:Object = null;
         if(!worldMapObject)
         {
            return null;
         }
         var _loc1_:Array = new Array();
         for each(_loc2_ in worldMapObject.lands)
         {
            _loc1_.push(JSONUtil.getStr(_loc2_,["landCode"]));
         }
         return _loc1_;
      }
      
      public static function getLandMainCityCode(param1:String) : String
      {
         var _loc3_:Object = null;
         if(!worldMapObject || !worldMapObject.lands)
         {
            return "";
         }
         var _loc2_:String = getMapInLandCode(param1);
         for each(_loc3_ in worldMapObject.lands)
         {
            if(_loc3_.landCode == _loc2_)
            {
               return _loc3_.landMainMapId;
            }
         }
         return "";
      }
      
      public static function getMapConfig(param1:String) : Object
      {
         return maps[param1];
      }
      
      public static function getMapInLandCode(param1:String) : String
      {
         return mapInLand[param1];
      }
      
      public static function getMapNConfig(param1:String) : Object
      {
         return mapnames[param1];
      }
      
      public static function getLandName(param1:String) : String
      {
         var _loc2_:Object = null;
         if(!param1 || param1 == "")
         {
            return "";
         }
         for each(_loc2_ in worldMapObject.lands)
         {
            if(_loc2_.landCode == param1)
            {
               return _loc2_.landName;
            }
         }
         return "";
      }
      
      public static function getMapName(param1:String) : String
      {
         var _loc2_:Object = maps[param1];
         return _loc2_ != null ? _loc2_.mapName : "";
      }
      
      public static function getMapId(param1:String) : String
      {
         return getMapNConfig(param1) != null ? getMapNConfig(param1).mapId : "";
      }
      
      public static function getSmallMap(param1:String) : Bitmap
      {
         var _loc3_:ResourceBag = null;
         var _loc2_:Object = smallMaps["SmallMap_" + param1];
         if(_loc2_ == null)
         {
            _loc2_ = new Object();
            _loc2_.maps = new Array();
            _loc2_.mapId = param1;
            _loc2_.bag = ResourceManager.instance.getBag("SmallMap_" + param1,true);
            _loc3_ = _loc2_.bag;
            _loc3_.obf_z_U_2156(obf_b_8_4256.getResIdToImport(getSmallMapRes(param1)));
            _loc3_.loader.addEventListener(obf_J_Y_3494.COMPLETE,onMapLoaded);
            _loc3_.load();
            smallMaps[_loc3_.name] = _loc2_;
         }
         var _loc4_:Bitmap = new Bitmap(new BitmapData(1,1,true,0));
         _loc2_.maps.push(_loc4_);
         return _loc4_;
      }
      
      private static function onMapLoaded(param1:obf_J_Y_3494) : void
      {
         var mapObj:Object;
         var newMapData:BitmapData = null;
         var thisBitmap:Bitmap = null;
         var e:obf_J_Y_3494 = param1;
         var thisLoader:obf_A_P_806 = e.target as obf_A_P_806;
         thisLoader.removeEventListener(obf_J_Y_3494.COMPLETE,onMapLoaded);
         mapObj = smallMaps[thisLoader.bag.name];
         if(mapObj != null)
         {
            newMapData = ResourceManager.instance.getBitmapData(getSmallMapRes(mapObj.mapId));
            if(newMapData)
            {
               if(Boolean(GameContext.currentMap) && GameContext.currentMap.mapId == mapObj.mapId)
               {
                  GameContext.currentMap.minimap = newMapData;
               }
               for each(thisBitmap in mapObj.maps)
               {
                  try
                  {
                     if(thisBitmap.bitmapData.width > 0)
                     {
                        thisBitmap.bitmapData.dispose();
                        thisBitmap.bitmapData = newMapData.clone();
                     }
                  }
                  catch(e:Error)
                  {
                  }
               }
            }
         }
         delete smallMaps[thisLoader.bag.name];
         ResourceManager.instance.destroyBag(thisLoader.bag.name);
      }
      
      private static function getSmallMapRes(param1:String) : String
      {
         var _loc2_:String = "";
         if(Boolean(maps) && Boolean(maps[param1]) && Boolean(maps[param1].previewMapResId))
         {
            _loc2_ = maps[param1].previewMapResId;
         }
         return _loc2_;
      }
      
      public static function drawMapObjectPoint(param1:int, param2:int, param3:int, param4:int, param5:Sprite, param6:Object, param7:uint, param8:uint, param9:uint = 1, param10:uint = 2, param11:Boolean = true) : void
      {
         var _loc12_:MapInteractiveObject = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         if(param11)
         {
            param5.graphics.clear();
         }
         for each(_loc12_ in param6)
         {
            param5.graphics.beginFill(param7);
            param5.graphics.lineStyle(param9,param8);
            _loc13_ = _loc12_.rootPX / param1;
            _loc14_ = _loc12_.rootPY / param2;
            _loc15_ = param3 * _loc13_;
            _loc16_ = param4 * _loc14_;
            param5.graphics.drawCircle(_loc15_,_loc16_,param10);
            param5.graphics.endFill();
         }
      }
      
      public static function drawMapObjectIcon(param1:int, param2:int, param3:int, param4:int, param5:Sprite, param6:Array, param7:String, param8:Boolean = true) : void
      {
         var _loc10_:MapInteractiveObject = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc9_:BitmapData = ResourceManager.instance.getBitmapData(param7);
         if(!_loc9_)
         {
            return;
         }
         if(param8)
         {
            param5.graphics.clear();
         }
         for each(_loc10_ in param6)
         {
            _loc11_ = _loc10_.rootPX / param1;
            _loc12_ = _loc10_.rootPY / param2;
            _loc13_ = param3 * _loc11_;
            _loc14_ = param4 * _loc12_;
            param5.graphics.beginBitmapFill(_loc9_,new Matrix(1,0,0,1,_loc13_ - 16,_loc14_ - 16),false,true);
            param5.graphics.drawRect(_loc13_ - 16,_loc14_ - 16,32,32);
            param5.graphics.endFill();
         }
      }
      
      public static function showNpcPoint(param1:int, param2:int, param3:int, param4:int, param5:Sprite, param6:Object) : void
      {
         var _loc7_:String = null;
         var _loc8_:AINpc = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         for(_loc7_ in param6)
         {
            _loc8_ = param6[_loc7_] as AINpc;
            if(!(!_loc8_ || JSONUtil.getBoolean(_loc8_.npcConfig,["hideInMiniMap"])))
            {
               _loc9_ = _loc8_.rootPX / param1;
               _loc10_ = _loc8_.rootPY / param2;
               _loc11_ = param3 * _loc9_;
               _loc12_ = param4 * _loc10_;
               _loc8_.npcMapIcon.x = _loc11_;
               _loc8_.npcMapIcon.y = _loc12_;
               if(!param5.contains(_loc8_.npcMapIcon))
               {
                  param5.addChild(_loc8_.npcMapIcon);
               }
            }
         }
      }
      
      public static function showMapObject(param1:int, param2:int, param3:int, param4:int, param5:Sprite, param6:Array, param7:Class, param8:String = "id") : void
      {
         var _loc9_:MapObject = null;
         var _loc10_:DisplayObject = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         for each(_loc9_ in param6)
         {
            if(_loc9_)
            {
               _loc10_ = param5.getChildByName(_loc9_[param8]);
               if(!_loc10_)
               {
                  _loc10_ = new param7();
                  _loc10_.name = _loc9_[param8];
                  param5.addChild(_loc10_);
               }
               _loc11_ = (_loc9_ is obf_0_1_N_478 ? (_loc9_ as obf_0_1_N_478).getCenterX() : _loc9_.rootPX) / param1;
               _loc12_ = (_loc9_ is obf_0_1_N_478 ? (_loc9_ as obf_0_1_N_478).getCenterY() : _loc9_.rootPY) / param2;
               _loc10_.x = param3 * _loc11_;
               _loc10_.y = param4 * _loc12_;
            }
         }
      }
      
      public static function showLocalPlayerPoint(param1:int, param2:int, param3:int, param4:int, param5:Sprite) : void
      {
         var _loc11_:int = 0;
         var _loc12_:Point = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:Point = null;
         var _loc16_:MovieClip = null;
         if(!GameContext.localPlayer)
         {
            return;
         }
         var _loc6_:Number = GameContext.localPlayer.rootPX / param1;
         var _loc7_:Number = GameContext.localPlayer.rootPY / param2;
         var _loc8_:int = param3 * _loc6_;
         var _loc9_:int = param4 * _loc7_;
         var _loc10_:MovieClip = param5.getChildByName(GameContext.localPlayer.id) as MovieClip;
         if(!_loc10_)
         {
            _loc10_ = new MapSelfIcon();
            _loc10_.name = GameContext.localPlayer.id;
            param5.addChild(_loc10_);
         }
         _loc10_.x = _loc8_;
         _loc10_.y = _loc9_;
         param5.graphics.clear();
         if(GameContext.localPlayer.isWalking())
         {
            param5.graphics.lineStyle(1,16777215,1,true);
            _loc11_ = 0;
            while(_loc11_ < GameContext.localPlayer.pathArray.length)
            {
               _loc12_ = GameContext.localPlayer.pathArray[_loc11_];
               _loc13_ = _loc12_.x / param1 * param3;
               _loc14_ = _loc12_.y / param2 * param4;
               if(_loc11_ == 0)
               {
                  param5.graphics.moveTo(_loc13_,_loc14_);
               }
               param5.graphics.lineTo(_loc13_,_loc14_);
               _loc11_++;
            }
            param5.graphics.endFill();
            if(GameContext.localPlayer.pathArray.length > 0)
            {
               _loc15_ = GameContext.localPlayer.pathArray[GameContext.localPlayer.pathArray.length - 1];
               _loc16_ = param5.getChildByName("DestinationMC") as MovieClip;
               if(!_loc16_)
               {
                  _loc16_ = new MapDestination();
                  _loc16_.name = "DestinationMC";
                  param5.addChild(_loc16_);
               }
               _loc16_.x = _loc15_.x / param1 * param3;
               _loc16_.y = _loc15_.y / param2 * param4;
            }
         }
         else if(param5.getChildByName("DestinationMC"))
         {
            param5.removeChild(param5.getChildByName("DestinationMC"));
         }
      }
   }
}

