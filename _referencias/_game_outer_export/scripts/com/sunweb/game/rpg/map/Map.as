package com.sunweb.game.rpg.map
{
   import obf_0_2_D_106.obf_i_G_2444;
   import com.adobe.serialization.json.JSON;
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.obf_b_8_4256;
   import com.sunweb.game.rpg.farm.obf_0_1_1_203;
   import com.sunweb.game.rpg.farm.obf_0_1_N_478;
   import com.sunweb.game.rpg.farm.obf_i_u_2869;
   import com.sunweb.game.rpg.farm.obf_j_1_3698;
   import com.sunweb.game.rpg.farm.obf_n_v_1693;
   import com.sunweb.game.rpg.role.obf_0_M_3913;
   import com.sunweb.game.rpg.role.obf_e_1465;
   import com.sunweb.game.rpg.role.obf_l_4_4027;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.util.obf_3_9_3148;
   import com.sunweb.game.util.obf_e_P_918;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class Map extends Sprite
   {
      
      public static const obf_7_7_3297:int = 32;
      
      public static const TILE_HEIGHT_IN_PIXEL:int = 16;
      
      public static const obf_Z_7_3230:int = 5;
      
      public static const obf_d_1_1185:int = 4;
      
      private static const obf_0_8_y_511:Boolean = true;
      
      public static const fastBGTileWidth:int = 512;
      
      public static const fastBGTileHeight:int = 512;
      
      public static var obf_0_2_l_577:int = 10;
      
      private var _mapConfig:Object;
      
      private var _id:String;
      
      private var _name:String;
      
      private var _width:int;
      
      private var _height:int;
      
      private var obf_V_J_3232:int;
      
      private var obf_B_0_886:int;
      
      private var _bgcolor:int;
      
      private var obf_U_r_2640:String;
      
      private var obf_V_v_4483:obf_i_G_2444;
      
      private var obf_W_d_2161:obf_i_G_2444;
      
      private var obf_i_Q_885:obf_i_G_2444;
      
      private var _layerArray:Array;
      
      private var obf_s_I_868:obf_2_1_1369;
      
      private var obf_0_3_R_300:obf_2_1_1369;
      
      private var _roleLayer:obf_2_1_1369;
      
      private var obf_D_2_1557:obf_2_1_1369;
      
      private var obf_Q_1_761:obf_o_s_1091;
      
      private var _exitArray:Array;
      
      private var obf_4_c_3622:Array;
      
      private var _enablePK:Boolean = false;
      
      private var obf_I_D_3739:Boolean = false;
      
      private var _resourcesToImport:Array;
      
      public var isLazyLoadBackground:Boolean = false;
      
      public var isLazyLoadBuilding:Boolean = true;
      
      public var isLazyLoadForeground:Boolean = true;
      
      public var fastBGRawLayer:obf_2_1_1369 = null;
      
      protected var _minimap:BitmapData = null;
      
      public var isUsingMaskArray:Boolean = false;
      
      public var maskMatrix:obf_i_G_2444 = null;
      
      public var pathfindingMatrixChanged:Boolean = false;
      
      private var _urdsChecked:Object = null;
      
      private var _resIdsFound:Object = null;
      
      public var resourceBag:ResourceBag = null;
      
      private var obf_S_f_1510:int = 1000;
      
      private var obf_e_R_3788:int = 600;
      
      private var obf_7_U_1961:int;
      
      private var obf_v_F_4527:int;
      
      private var obf_Q_Q_4624:int;
      
      private var obf_r_4_2287:int;
      
      private var obf_d_o_4731:Rectangle;
      
      private var obf_O_u_4187:Number = 60;
      
      private var obf_t_r_y_4663:int = 2;
      
      private var obf_f_B_2898:Number = 0.25;
      
      private var _lastViewPortMoveTime:int = 0;
      
      private var _updateLimiter:TimeLimiter = new TimeLimiter(180);
      
      private var _updateSightLimiter:TimeLimiter = new TimeLimiter(400);
      
      private var isPlayerInExit:Boolean = false;
      
      private var obf_P_9_3599:TimeLimiter = new TimeLimiter(50);
      
      private var _lastTrackingPoint:Point = new Point();
      
      public var allMapObjects:Object = new Object();
      
      private var _player:obf_0_M_3913;
      
      private var _remotePlayerSet:obf_i_l_1569;
      
      private var obf_y_E_2367:TimeLimiter = new TimeLimiter(500);
      
      private var obf_C_k_2960:obf_i_l_1569;
      
      private var final:obf_i_l_1569;
      
      private var obf_F_f_1858:obf_i_l_1569;
      
      private var obf_C_U_1700:obf_i_l_1569;
      
      private var obf_t_L_1285:obf_i_l_1569;
      
      private var obf_q_i_3259:obf_i_l_1569;
      
      private var obf_e_3_1775:obf_i_l_1569;
      
      private var obf_0_3_1_418:obf_i_l_1569;
      
      protected var obf_D_u_2110:Point = new Point(800,600);
      
      protected var obf_X_n_3107:Point = new Point(1000,800);
      
      private var _refreshPlayerArray:Array = new Array();
      
      private var _lastRefreshPlayerMS:int = 0;
      
      private var _refreshPlayerIntervalMS:int = 300;
      
      private var _selectedObject:MapInteractiveObject = null;
      
      public var obf_b_w_4360:Boolean = false;
      
      public var obf_x_5_2795:Class = MapInteractiveObject;
      
      private var _trackingObject:MapInteractiveObject = null;
      
      private var obf_1_l_2808:obf_c_4_964;
      
      private var obf_K_K_2087:obf_i_u_2869;
      
      private var obf_l_Y_1331:Object = new Object();
      
      public function Map(param1:String)
      {
         super();
         this._mapConfig = com.adobe.serialization.json.JSON.decode(param1);
         this.parseConfig();
         this.obf_0_8_A_248();
         this.setViewPortSize(this.obf_S_f_1510,this.obf_e_R_3788);
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.obf_e_v_4153);
         this._mapConfig = null;
         obf_1_q_4613.pathfindReset();
      }
      
      public function destroy() : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.removeEventListener(Event.REMOVED_FROM_STAGE,this.obf_e_v_4153);
         this.removeLocalPlayer();
         this.remotePlayerSet.destroy(true);
         this.monsterSet.destroy(true);
         this.npcSet.destroy(true);
         this.petSet.destroy(true);
         this.animalSet.destroy(true);
         this.itemSet.destroy(true);
         this.obf_c_z_1779.destroy(true);
         this.obf_4_h_2582.destroy(true);
         this.obf_b_h_1770.destroy(true);
         this.destroyLayers();
         this.obf_v_P_2126.destroy(true);
         this.allMapObjects = null;
         this.obf_V_v_4483 = null;
         this._resourcesToImport = null;
         this.resourceBag = null;
         this._roleLayer = null;
         this.obf_D_2_1557 = null;
         this.obf_s_I_868 = null;
         this.obf_0_3_R_300 = null;
         this._exitArray = null;
         this.obf_4_c_3622 = null;
         this._remotePlayerSet = null;
         this.obf_C_k_2960 = null;
         this.final = null;
         this.obf_F_f_1858 = null;
         this.obf_C_U_1700 = null;
         this.obf_t_L_1285 = null;
         this.obf_q_i_3259 = null;
         this.obf_e_3_1775 = null;
         this.obf_K_K_2087 = null;
         obf_1_q_4613.pathfindReset();
         if(this._minimap != null)
         {
            try
            {
               this._minimap.dispose();
            }
            catch(e:Error)
            {
            }
            this._minimap = null;
         }
      }
      
      public function release() : void
      {
         var _loc1_:obf_2_1_1369 = null;
         for each(_loc1_ in this._layerArray)
         {
            _loc1_.release();
         }
         this.obf_Q_1_761.release();
      }
      
      private function parseConfig() : void
      {
         this._id = this._mapConfig.id;
         this._name = this._mapConfig.name;
         this._width = this._mapConfig.width;
         this._height = this._mapConfig.height;
         this.obf_U_r_2640 = this._mapConfig.worldMC;
         this.obf_V_J_3232 = this._width * Map.obf_7_7_3297;
         this.obf_B_0_886 = this._height * Map.TILE_HEIGHT_IN_PIXEL;
         this._bgcolor = this._mapConfig.bgcolor;
         this.isLazyLoadBackground = this._mapConfig.isLazyLoadBackground;
         this.obf_V_v_4483 = new obf_i_G_2444();
         this.obf_V_v_4483.decode(this._mapConfig.PathfindingArray);
         this.isUsingMaskArray = this._mapConfig.isUsingMaskArray;
         if(this.isUsingMaskArray && this._mapConfig.MaskArray != null)
         {
            this.maskMatrix = new obf_i_G_2444();
            this.maskMatrix.decode(this._mapConfig.MaskArray);
         }
         this.obf_R_0_2957();
         this.obf_O_h_3646();
         this.createLayers();
         try
         {
            this._enablePK = this._mapConfig.rules.pkRule.enablePK;
            this.obf_I_D_3739 = this._mapConfig.rules.pkRule.isArenaMode;
         }
         catch(e:Error)
         {
         }
      }
      
      private function obf_R_0_2957() : void
      {
         var _loc1_:Object = null;
         this._exitArray = new Array();
         if(this._mapConfig.exitArray == null)
         {
            return;
         }
         for each(_loc1_ in this._mapConfig.exitArray)
         {
            this._exitArray.push(new obf_6_H_3213(_loc1_));
         }
      }
      
      public function get exitArray() : Array
      {
         return this._exitArray;
      }
      
      private function obf_O_h_3646() : void
      {
         var _loc1_:Object = null;
         this.obf_4_c_3622 = new Array();
         if(this._mapConfig.entryArray == null)
         {
            return;
         }
         for each(_loc1_ in this._mapConfig.entryArray)
         {
            this.obf_4_c_3622.push(new obf_S_R_4599(_loc1_));
         }
      }
      
      public function get entryArray() : Array
      {
         return this.obf_4_c_3622;
      }
      
      private function createLayers() : void
      {
         var _loc3_:obf_2_1_1369 = null;
         this.obf_Q_1_761 = new obf_o_s_1091(this);
         var _loc1_:Array = this._mapConfig.layers;
         this._layerArray = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = new obf_2_1_1369(this,_loc1_[_loc2_]);
            this._layerArray.push(_loc3_);
            _loc2_++;
         }
         this.obf_s_I_868 = this._layerArray[obf_2_1_1369.obf_W_f_2388];
         this.obf_0_3_R_300 = this._layerArray[obf_2_1_1369.obf_u_m_3011];
         this._roleLayer = this._layerArray[obf_2_1_1369.set];
         this.obf_D_2_1557 = this._layerArray[obf_2_1_1369.obf_x_y_1661];
         if(this.isFastBGMode)
         {
            this.fastBGRawLayer = new obf_2_1_1369(this,null,obf_2_1_1369.obf_5_Q_881);
            this.fastBGRawLayer.isLazyLoading = true;
         }
         this.createFarms();
      }
      
      private function destroyLayers() : void
      {
         var _loc1_:obf_2_1_1369 = null;
         for each(_loc1_ in this._layerArray)
         {
            _loc1_.destroy();
         }
         this._layerArray.length = 0;
         if(this.fastBGRawLayer != null)
         {
            this.fastBGRawLayer.destroy();
            this.fastBGRawLayer = null;
         }
         this.obf_Q_1_761.destroy();
         this.obf_Q_1_761 = null;
      }
      
      public function get layers() : Array
      {
         return this._layerArray;
      }
      
      public function get backgroundLayer() : obf_2_1_1369
      {
         return this.obf_s_I_868;
      }
      
      public function get bgObjectLayer() : obf_2_1_1369
      {
         return this.obf_0_3_R_300;
      }
      
      public function get obf_Y_1_2831() : obf_2_1_1369
      {
         return this._roleLayer;
      }
      
      public function get magicLayer() : obf_2_1_1369
      {
         return this.obf_D_2_1557;
      }
      
      public function get obf_N_1848() : obf_o_s_1091
      {
         return this.obf_Q_1_761;
      }
      
      public function get mapId() : String
      {
         return this._id;
      }
      
      public function get mapName() : String
      {
         return this._name;
      }
      
      public function get mapWidth() : int
      {
         return this._width;
      }
      
      public function get mapHeight() : int
      {
         return this._height;
      }
      
      public function get worldMC() : String
      {
         return this.obf_U_r_2640;
      }
      
      public function get mapWidthInPixel() : int
      {
         return this.obf_V_J_3232;
      }
      
      public function get mapHeightInPixel() : int
      {
         return this.obf_B_0_886;
      }
      
      public function get bgcolor() : int
      {
         return this._bgcolor;
      }
      
      public function set enablePK(param1:Boolean) : void
      {
         this._enablePK = param1;
      }
      
      public function get enablePK() : Boolean
      {
         return this._enablePK;
      }
      
      public function get isArenaMode() : Boolean
      {
         return this.obf_I_D_3739;
      }
      
      public function get isFastBGMode() : Boolean
      {
         return !this.isLazyLoadBackground && obf_0_8_y_511;
      }
      
      public function get minimap() : BitmapData
      {
         return this._minimap;
      }
      
      public function set minimap(param1:BitmapData) : void
      {
         var v:BitmapData = param1;
         if(this._minimap != null)
         {
            try
            {
               this._minimap.dispose();
            }
            catch(e:Error)
            {
            }
         }
         this._minimap = v.clone();
         if(this.isLazyLoadBackground)
         {
            this.backgroundLayer._tryToShowLoadingObject();
         }
      }
      
      public function isMaskPoint(param1:int, param2:int) : Boolean
      {
         if(!this.isUsingMaskArray || this.maskMatrix == null)
         {
            return false;
         }
         var _loc3_:Point = obf_1_q_4613.obf_0_7_i_369(new Point(param1,param2));
         return this.maskMatrix.getPassable(_loc3_.x,_loc3_.y);
      }
      
      public function isMaskTile(param1:int, param2:int) : Boolean
      {
         if(!this.isUsingMaskArray || this.maskMatrix == null)
         {
            return false;
         }
         return this.maskMatrix.getPassable(param1,param2);
      }
      
      public function get pathfindingMatrix() : obf_i_G_2444
      {
         return this.obf_V_v_4483;
      }
      
      public function canWalk(param1:int, param2:int) : Boolean
      {
         var _loc3_:Point = obf_1_q_4613.obf_0_7_i_369(new Point(param1,param2));
         return this.obf_0_3_m_391(_loc3_.x,_loc3_.y);
      }
      
      public function obf_0_3_m_391(param1:int, param2:int) : Boolean
      {
         return this.obf_i_Q_885 != null && this.obf_i_Q_885.getPassable(param1,param2) || (this.obf_V_v_4483 == null || this.obf_V_v_4483.getPassable(param1,param2)) && (this.obf_W_d_2161 == null || this.obf_W_d_2161.getPassable(param1,param2));
      }
      
      public function obf_S_H_1476(param1:int, param2:int) : Boolean
      {
         param1 >>= 1;
         return this.obf_0_3_m_391(param1,param2);
      }
      
      public function isBlocked(param1:int, param2:int, param3:int, param4:int) : Boolean
      {
         var _loc5_:int = param1 >> obf_d_1_1185;
         var _loc6_:int = param2 >> obf_d_1_1185;
         var _loc7_:int = param3 >> obf_d_1_1185;
         var _loc8_:int = param4 >> obf_d_1_1185;
         if(_loc5_ < _loc7_)
         {
            return this.isBlockedHalfTile(_loc5_,_loc6_,_loc7_,_loc8_);
         }
         return this.isBlockedHalfTile(_loc7_,_loc8_,_loc5_,_loc6_);
      }
      
      public function isBlocked2Objects(param1:MapInteractiveObject, param2:MapInteractiveObject) : Boolean
      {
         return this.isBlocked(param1.rootPX,param1.rootPY,param2.rootPX,param2.rootPY);
      }
      
      private function isBlockedHalfTile(param1:int, param2:int, param3:int, param4:int) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         if(param3 >= param1)
         {
            _loc7_ = param3 - param1;
            _loc9_ = 1;
         }
         else
         {
            _loc7_ = param1 - param3;
            _loc9_ = -1;
         }
         if(param4 >= param2)
         {
            _loc8_ = param4 - param2;
            _loc10_ = 1;
         }
         else
         {
            _loc8_ = param2 - param4;
            _loc10_ = -1;
         }
         _loc5_ = param1;
         _loc6_ = param2;
         if(_loc7_ >= _loc8_)
         {
            _loc8_ <<= 1;
            _loc11_ = _loc8_ - _loc7_;
            _loc7_ <<= 1;
            while(_loc5_ != param3)
            {
               if(!this.obf_S_H_1476(_loc5_,_loc6_))
               {
                  return true;
               }
               if(_loc11_ >= 0)
               {
                  _loc6_ += _loc10_;
                  _loc11_ -= _loc7_;
               }
               _loc11_ += _loc8_;
               _loc5_ += _loc9_;
               _loc12_++;
            }
            if(!this.obf_S_H_1476(_loc5_,_loc6_))
            {
               return true;
            }
         }
         else
         {
            _loc7_ <<= 1;
            _loc11_ = _loc7_ - _loc8_;
            _loc8_ <<= 1;
            while(_loc6_ != param4)
            {
               if(!this.obf_S_H_1476(_loc5_,_loc6_))
               {
                  return true;
               }
               if(_loc11_ >= 0)
               {
                  _loc5_ += _loc9_;
                  _loc11_ -= _loc8_;
               }
               _loc11_ += _loc7_;
               _loc6_ += _loc10_;
               _loc12_++;
            }
            if(!this.obf_S_H_1476(_loc5_,_loc6_))
            {
               return true;
            }
         }
         return false;
      }
      
      public function getNearestPassableTile(param1:int, param2:int) : Point
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(this.obf_0_3_m_391(param1,param2))
         {
            return new Point(param1,param2);
         }
         var _loc3_:int = 1;
         while(_loc3_ < 50)
         {
            _loc4_ = -1;
            while(_loc4_ <= 1)
            {
               _loc5_ = -1;
               while(_loc5_ <= 1)
               {
                  if(!(_loc4_ == 0 && _loc5_ == 0))
                  {
                     _loc6_ = param1 + _loc4_ * _loc3_;
                     _loc7_ = param2 + _loc5_ * _loc3_;
                     if(this.obf_0_3_m_391(_loc6_,_loc7_))
                     {
                        return new Point(_loc6_,_loc7_);
                     }
                  }
                  _loc5_++;
               }
               _loc4_++;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getNearestPassablePoint(param1:int, param2:int) : Point
      {
         var _loc3_:Point = obf_1_q_4613.obf_0_7_i_369(new Point(param1,param2));
         var _loc4_:Point = this.getNearestPassableTile(_loc3_.x,_loc3_.y);
         return _loc4_ == null ? null : obf_1_q_4613.obf_0_3_l_190(_loc4_);
      }
      
      private function obf_0_8_A_248() : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc1_:Array = this._mapConfig.layers;
         this._resourcesToImport = new Array();
         this._urdsChecked = new Object();
         this._resIdsFound = new Object();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(!(this.isLazyLoadBackground && _loc2_ < obf_2_1_1369.set))
            {
               if(!(this.isLazyLoadBuilding && _loc2_ == obf_2_1_1369.set))
               {
                  if(!(this.isLazyLoadForeground && _loc2_ > obf_2_1_1369.set))
                  {
                     _loc4_ = _loc1_[_loc2_].content;
                     if(_loc4_ != null)
                     {
                        _loc5_ = 0;
                        while(_loc5_ < _loc4_.length)
                        {
                           _loc6_ = _loc4_[_loc5_].res;
                           this.obf_Q_O_4617(_loc6_);
                           _loc5_++;
                        }
                     }
                  }
               }
            }
            _loc2_++;
         }
         var _loc3_:Array = this._mapConfig.farms;
         if(_loc3_ != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_.length)
            {
               this.obf_Q_O_4617(_loc3_[_loc2_].res);
               _loc2_++;
            }
         }
         this._urdsChecked = null;
         this._resIdsFound = null;
      }
      
      private function obf_Q_O_4617(param1:String) : void
      {
         if(this._urdsChecked[param1] == null)
         {
            this._urdsChecked[param1] = param1;
            var _loc2_:String = obf_b_8_4256.getResIdToImport(param1);
            if(this._resIdsFound[_loc2_] == null)
            {
               this._resIdsFound[_loc2_] = _loc2_;
               this._resourcesToImport.push(_loc2_);
            }
            return;
         }
      }
      
      public function get resourcesToImport() : Array
      {
         return this._resourcesToImport;
      }
      
      public function setViewPortSize(param1:int, param2:int) : void
      {
         this.obf_S_f_1510 = param1;
         this.obf_e_R_3788 = param2;
         if(this.obf_d_o_4731 == null)
         {
            this.obf_d_o_4731 = new Rectangle(0,0,param1,param2);
         }
         else
         {
            this.obf_d_o_4731.width = param1;
            this.obf_d_o_4731.height = param2;
         }
         this.obf_7_U_1961 = this.obf_Q_Q_4624 = (this.obf_d_o_4731.x + this.obf_d_o_4731.width) / 2;
         this.obf_v_F_4527 = this.obf_r_4_2287 = (this.obf_d_o_4731.y + this.obf_d_o_4731.height) / 2;
         this.scrollRect = this.obf_d_o_4731;
      }
      
      public function setViewPortCenter(param1:int, param2:int, param3:Boolean = false) : void
      {
         if(param1 < this.obf_S_f_1510 / 2)
         {
            param1 = this.obf_S_f_1510 / 2;
         }
         if(param1 > this.obf_V_J_3232 - this.obf_S_f_1510 / 2)
         {
            param1 = this.obf_V_J_3232 - this.obf_S_f_1510 / 2;
         }
         if(param2 < this.obf_e_R_3788 / 2)
         {
            param2 = this.obf_e_R_3788 / 2;
         }
         if(param2 > this.obf_B_0_886 - this.obf_e_R_3788 / 2)
         {
            param2 = this.obf_B_0_886 - this.obf_e_R_3788 / 2;
         }
         this.obf_Q_Q_4624 = param1;
         this.obf_r_4_2287 = param2;
         if(param3)
         {
            this.moveViewPortTo(param1,param2);
         }
      }
      
      public function setViewPortCenterToObject(param1:MapObject, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1.rootPXYAvailable)
         {
            this.setViewPortCenter(param1.rootPX,param1.rootPY,param2);
         }
         else
         {
            _loc3_ = param1.rootX * obf_7_7_3297 + obf_7_7_3297 / 2;
            _loc4_ = param1.rootY * TILE_HEIGHT_IN_PIXEL + TILE_HEIGHT_IN_PIXEL / 2;
            this.setViewPortCenter(_loc3_,_loc4_,param2);
         }
      }
      
      private function moveViewPortTo(param1:int, param2:int) : void
      {
         this.obf_7_U_1961 = param1;
         this.obf_v_F_4527 = param2;
         this.obf_d_o_4731.x = param1 - this.obf_d_o_4731.width / 2;
         this.obf_d_o_4731.y = param2 - this.obf_d_o_4731.height / 2;
         this.scrollRect = this.obf_d_o_4731;
      }
      
      private function moveViewPortByStep() : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(this.obf_7_U_1961 == this.obf_Q_Q_4624 && this.obf_v_F_4527 == this.obf_r_4_2287)
         {
            this._lastViewPortMoveTime = 0;
            return;
         }
         if(this._lastViewPortMoveTime == 0)
         {
            this._lastViewPortMoveTime = getTimer();
         }
         var _loc1_:int = getTimer() - this._lastViewPortMoveTime;
         this._lastViewPortMoveTime = getTimer();
         if(_loc1_ > 100)
         {
            _loc1_ = 100;
         }
         var _loc2_:int = this.obf_O_u_4187 / 1000 * _loc1_;
         if(_loc2_ < this.obf_t_r_y_4663)
         {
            _loc2_ = this.obf_t_r_y_4663;
         }
         var _loc4_:int = this.obf_Q_Q_4624 - this.obf_7_U_1961;
         if(Math.abs(_loc4_) <= _loc2_)
         {
            _loc3_ = this.obf_Q_Q_4624;
         }
         else
         {
            _loc7_ = _loc4_ * (_loc1_ / 1000 / this.obf_f_B_2898);
            if(Math.abs(_loc7_) < _loc2_)
            {
               _loc7_ = _loc2_ * (_loc4_ > 0 ? 1 : -1);
            }
            else if(Math.abs(_loc7_) > Math.abs(_loc4_))
            {
               _loc7_ = _loc4_;
            }
            _loc3_ = this.obf_7_U_1961 + _loc7_;
         }
         var _loc6_:int = this.obf_r_4_2287 - this.obf_v_F_4527;
         if(Math.abs(_loc6_) <= _loc2_)
         {
            _loc5_ = this.obf_r_4_2287;
         }
         else
         {
            _loc8_ = _loc6_ * (_loc1_ / 1000 / this.obf_f_B_2898);
            if(Math.abs(_loc8_) < _loc2_)
            {
               _loc8_ = _loc2_ * (_loc6_ > 0 ? 1 : -1);
            }
            else if(Math.abs(_loc8_) > Math.abs(_loc6_))
            {
               _loc8_ = _loc6_;
            }
            _loc5_ = this.obf_v_F_4527 + _loc8_;
         }
         this.moveViewPortTo(_loc3_,_loc5_);
         this.obf_Q_1_761.updateView();
      }
      
      public function get obf_0_6_g_261() : Rectangle
      {
         return this.obf_d_o_4731.clone();
      }
      
      public function get obf_0_D_2242() : int
      {
         return this.obf_S_f_1510;
      }
      
      public function get obf_t_h_3758() : int
      {
         return this.obf_e_R_3788;
      }
      
      public function get obf_v_K_2798() : int
      {
         return this.obf_Q_Q_4624;
      }
      
      public function get obf_Q_b_762() : int
      {
         return this.obf_r_4_2287;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         obf_x_0_1295.obf_r_w_3556("Map onAddedToStage");
         this.obf_x_p_1733();
         this.obf_0___W_420();
         this.addEventListeners();
      }
      
      private function obf_e_v_4153(param1:Event) : void
      {
         obf_x_0_1295.obf_r_w_3556("Map onRemovedFromStage");
         this.removeEventListeners();
         this.removeLayersFromMap();
      }
      
      private function addEventListeners() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function removeEventListeners() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         this.updateMapObjects();
         this.moveViewPortByStep();
         this.updateLayersAlpha();
         this.updateTrackingObject();
         this.obf_S_t_4233();
         if(!this._updateLimiter.checkTimeout())
         {
            return;
         }
         this.updateLayersView();
         if(this._player != null)
         {
            this.obf_B_o_2972();
         }
         this.obf_V_9_2240();
         this.autoHideRemotePlayers();
      }
      
      private function obf_V_9_2240() : void
      {
         this.obf_L_Z_4019();
         if(this._updateSightLimiter.checkTimeout())
         {
            this.remotePlayerSet.updateSightState();
            this.monsterSet.updateSightState();
            this.npcSet.updateSightState();
            this.petSet.updateSightState();
            this.animalSet.updateSightState();
            this.itemSet.updateSightState();
            this.obf_c_z_1779.updateSightState();
            this.obf_4_h_2582.updateSightState();
            this.obf_b_h_1770.updateSightState();
         }
      }
      
      private function obf_L_Z_4019() : void
      {
         var _loc2_:obf_6_H_3213 = null;
         if(this._player == null)
         {
            return;
         }
         var _loc1_:obf_6_H_3213 = null;
         for each(_loc2_ in this._exitArray)
         {
            if(_loc2_.contains(this._player.rootPX,this._player.rootPY))
            {
               _loc1_ = _loc2_;
               break;
            }
         }
         if(_loc1_ == null)
         {
            this.isPlayerInExit = false;
            return;
         }
         if(!this.isPlayerInExit)
         {
            this.isPlayerInExit = true;
            if(this.obf_1_l_2808 != null)
            {
               this.obf_1_l_2808.onPlayerReachExit(_loc1_);
            }
         }
      }
      
      private function updateMapObjects() : void
      {
         var _loc1_:MapInteractiveObject = null;
         for each(_loc1_ in this.allMapObjects)
         {
            _loc1_.onUpdate();
         }
      }
      
      private function obf_0___W_420() : void
      {
         var _loc1_:obf_2_1_1369 = null;
         this.obf_Q_1_761.obf_0_9_K_397();
         for each(_loc1_ in this._layerArray)
         {
            _loc1_.obf_0_9_K_397();
         }
         if(this.isFastBGMode)
         {
            this.obf_0_o_2391();
         }
         if(this._player != null && !this._player.isInStage)
         {
            this._player.obf_9_C_1574(this);
         }
      }
      
      private function obf_0_o_2391() : void
      {
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:obf_P_4660 = null;
         var _loc1_:obf_2_1_1369 = this._layerArray[obf_2_1_1369.obf_W_f_2388];
         this._layerArray[obf_2_1_1369.obf_W_f_2388] = this.fastBGRawLayer;
         this.fastBGRawLayer = _loc1_;
         _loc1_ = this._layerArray[obf_2_1_1369.obf_W_f_2388];
         if(this.contains(this.fastBGRawLayer))
         {
            _loc11_ = this.getChildIndex(this.fastBGRawLayer);
            this.removeChildAt(_loc11_);
            this.addChildAt(_loc1_,_loc11_);
         }
         var _loc2_:obf_A_1_2543 = null;
         var _loc3_:* = int(this.fastBGRawLayer.content.length - 1);
         while(_loc3_ >= 0)
         {
            _loc2_ = this.fastBGRawLayer.content[_loc3_];
            if(_loc2_.obf_0_5_S_544 == null)
            {
               obf_x_0_1295.obf_r_w_3556("Map.createFastBGRawLayerView null bg tile: " + (_loc2_ is obf_P_4660 ? (_loc2_ as obf_P_4660).res : "unknown"));
            }
            else if(_loc2_.obf_0_5_S_544 is MovieClip)
            {
               this.fastBGRawLayer.content.splice(_loc3_,1);
               this.obf_0_3_R_300.content.unshift(_loc2_);
               if(this.fastBGRawLayer.contains(_loc2_.obf_0_5_S_544))
               {
                  this.fastBGRawLayer.removeChild(_loc2_.obf_0_5_S_544);
               }
               this.obf_0_3_R_300.addChildAt(_loc2_.obf_0_5_S_544,0);
            }
            _loc3_--;
         }
         var _loc4_:int = this.fastBGRawLayer.numChildren;
         var _loc5_:int = int(this.fastBGRawLayer.content.length);
         _loc3_ = int(this.obf_0_3_R_300.content.length - 1);
         while(_loc3_ >= 0)
         {
            _loc2_ = this.obf_0_3_R_300.content[_loc3_];
            if(_loc2_.obf_0_5_S_544 == null)
            {
               obf_x_0_1295.obf_r_w_3556("Map.createFastBGRawLayerView null obj tile: " + (_loc2_ is obf_P_4660 ? (_loc2_ as obf_P_4660).res : "unknown"));
            }
            else if(!(_loc2_.obf_0_5_S_544 is MovieClip))
            {
               this.obf_0_3_R_300.content.splice(_loc3_,1);
               this.fastBGRawLayer.content.splice(_loc5_,0,_loc2_);
               if(this.obf_0_3_R_300.contains(_loc2_.obf_0_5_S_544))
               {
                  this.obf_0_3_R_300.removeChild(_loc2_.obf_0_5_S_544);
               }
               this.fastBGRawLayer.addChildAt(_loc2_.obf_0_5_S_544,_loc4_);
            }
            _loc3_--;
         }
         obf_x_0_1295.obf_r_w_3556("==== layer fastBGRawLayer object number: " + this.fastBGRawLayer.numChildren);
         var _loc6_:int = this.mapWidthInPixel / fastBGTileWidth - 1;
         var _loc7_:int = this.mapWidthInPixel % fastBGTileWidth;
         if(_loc7_ > 0)
         {
            _loc6_++;
         }
         else
         {
            _loc7_ = fastBGTileWidth;
         }
         var _loc8_:int = this.mapHeightInPixel / fastBGTileHeight - 1;
         var _loc9_:int = this.mapHeightInPixel % fastBGTileHeight;
         if(_loc9_ > 0)
         {
            _loc8_++;
         }
         else
         {
            _loc9_ = fastBGTileHeight;
         }
         var _loc10_:int = 0;
         while(_loc10_ <= _loc8_)
         {
            _loc12_ = 0;
            while(_loc12_ <= _loc6_)
            {
               _loc13_ = new obf_P_4660();
               _loc13_.obf_Q_R_3368(_loc12_ * fastBGTileWidth,_loc10_ * fastBGTileHeight,_loc12_ == _loc6_ ? _loc7_ : fastBGTileWidth,_loc10_ == _loc8_ ? _loc9_ : fastBGTileHeight);
               _loc1_.content.push(_loc13_);
               _loc12_++;
            }
            _loc10_++;
         }
      }
      
      private function updateLayersView() : void
      {
         var _loc1_:obf_2_1_1369 = null;
         this.obf_Q_1_761.updateView();
         for each(_loc1_ in this._layerArray)
         {
            _loc1_.updateView();
         }
      }
      
      private function updateLayersAlpha() : void
      {
         var _loc1_:obf_2_1_1369 = null;
         for each(_loc1_ in this._layerArray)
         {
            _loc1_.updateAlphaByStep();
         }
      }
      
      private function updateTrackingObject() : void
      {
         this.obf_M_0_2911();
         if(!this.obf_b_w_4360)
         {
            return;
         }
         if(!this.obf_P_9_3599.checkTimeout())
         {
            return;
         }
         var _loc1_:Point = new Point(this.mouseX,this.mouseY);
         if(_loc1_.x == this._lastTrackingPoint.x && _loc1_.y == this._lastTrackingPoint.y)
         {
            return;
         }
         var _loc2_:MapInteractiveObject = this.getObjectUnderPoint(_loc1_.x,_loc1_.y,this.obf_x_5_2795);
         this.setTrackingObject(_loc2_);
         this._lastTrackingPoint.x = _loc1_.x;
         this._lastTrackingPoint.y = _loc1_.y;
         if(this.obf_1_l_2808 != null)
         {
            this.obf_1_l_2808.onMouseTracking(_loc2_,_loc1_);
         }
      }
      
      private function obf_M_0_2911() : void
      {
         if(this._selectedObject != null && !this._selectedObject.isInStage)
         {
            this.setSelectedObject(null);
         }
         if(this._trackingObject != null && !this._trackingObject.isInStage)
         {
            this.setTrackingObject(null);
         }
      }
      
      private function obf_x_p_1733() : void
      {
         var _loc1_:obf_2_1_1369 = null;
         for each(_loc1_ in this._layerArray)
         {
            this.addChild(_loc1_);
         }
         (this.layers[0] as obf_2_1_1369).addChildAt(this.obf_Q_1_761,0);
      }
      
      private function removeLayersFromMap() : void
      {
         var _loc1_:obf_2_1_1369 = null;
         for each(_loc1_ in this._layerArray)
         {
            _loc1_.removeChildren();
         }
         this.obf_Q_1_761.removeChildren();
         obf_3_9_3148.removeChildren(this);
      }
      
      public function getObjectById(param1:String) : MapInteractiveObject
      {
         return this.allMapObjects[param1] as MapInteractiveObject;
      }
      
      public function obf_2_T_3874(param1:obf_0_M_3913) : void
      {
         if(this._player != null)
         {
            throw new Error("can not add more than 1 player!");
         }
         this._player = param1;
         this._player.setMap(this);
         this.allMapObjects[param1.id] = param1;
         if(this.stage != null)
         {
            this._player.obf_9_C_1574(this);
         }
      }
      
      public function removeLocalPlayer() : void
      {
         if(this._player != null)
         {
            this._player.removeMe();
            this._player.setMap(null);
            delete this.allMapObjects[this._player.id];
            this._player = null;
         }
      }
      
      public function get player() : obf_0_M_3913
      {
         return this._player;
      }
      
      private function obf_B_o_2972() : void
      {
         var theLayer:obf_2_1_1369 = null;
         for each(theLayer in this._layerArray)
         {
            try
            {
               theLayer.obf_B_o_2972();
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function get remotePlayerSet() : obf_i_l_1569
      {
         if(this._remotePlayerSet == null)
         {
            this._remotePlayerSet = new obf_i_l_1569(this,obf_0_M_3913);
         }
         return this._remotePlayerSet;
      }
      
      public function limitRemotePlayerNumber(param1:int) : void
      {
         var _loc3_:obf_0_M_3913 = null;
         var _loc4_:int = 0;
         if(this._player == null)
         {
            return;
         }
         var _loc2_:Array = new Array();
         for each(_loc3_ in this.remotePlayerSet.obf_3_C_4291)
         {
            _loc2_.push({
               "distance":this._player.getLineDistance(_loc3_),
               "player":_loc3_
            });
         }
         _loc2_.sortOn("distance",Array.NUMERIC);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            (_loc2_[_loc4_].player as obf_0_M_3913).obf_X_f_2691 = _loc4_ < param1 ? true : false;
            _loc4_++;
         }
      }
      
      private function autoHideRemotePlayers() : void
      {
         if(!this.obf_y_E_2367.checkTimeout())
         {
            return;
         }
         this.limitRemotePlayerNumber(obf_0_2_l_577);
      }
      
      public function get monsterSet() : obf_i_l_1569
      {
         if(this.obf_C_k_2960 == null)
         {
            this.obf_C_k_2960 = new obf_i_l_1569(this,obf_e_1465);
         }
         return this.obf_C_k_2960;
      }
      
      public function get npcSet() : obf_i_l_1569
      {
         if(this.final == null)
         {
            this.final = new obf_i_l_1569(this,obf_l_4_4027);
         }
         return this.final;
      }
      
      public function get petSet() : obf_i_l_1569
      {
         if(this.obf_F_f_1858 == null)
         {
            this.obf_F_f_1858 = new obf_i_l_1569(this,obf_e_1465);
         }
         return this.obf_F_f_1858;
      }
      
      public function get itemSet() : obf_i_l_1569
      {
         if(this.obf_C_U_1700 == null)
         {
            this.obf_C_U_1700 = new obf_i_l_1569(this,obf_z_T_3316);
         }
         return this.obf_C_U_1700;
      }
      
      public function get obf_c_z_1779() : obf_i_l_1569
      {
         if(this.obf_t_L_1285 == null)
         {
            this.obf_t_L_1285 = new obf_i_l_1569(this,obf_0_3_x_417);
         }
         return this.obf_t_L_1285;
      }
      
      public function get obf_4_h_2582() : obf_i_l_1569
      {
         if(this.obf_q_i_3259 == null)
         {
            this.obf_q_i_3259 = new obf_i_l_1569(this,obf_j_1_3698);
         }
         return this.obf_q_i_3259;
      }
      
      public function get obf_b_h_1770() : obf_i_l_1569
      {
         if(this.obf_e_3_1775 == null)
         {
            this.obf_e_3_1775 = new obf_i_l_1569(this,obf_0_1_1_203);
         }
         return this.obf_e_3_1775;
      }
      
      public function get animalSet() : obf_i_l_1569
      {
         if(this.obf_0_3_1_418 == null)
         {
            this.obf_0_3_1_418 = new obf_i_l_1569(this,obf_e_1465);
         }
         return this.obf_0_3_1_418;
      }
      
      public function isObjectInSight(param1:MapInteractiveObject) : Boolean
      {
         if(this._player == null)
         {
            return false;
         }
         return Math.abs(this._player.rootPX - param1.rootPX) < this.obf_D_u_2110.x && Math.abs(this._player.rootPY - param1.rootPY) < this.obf_D_u_2110.y;
      }
      
      public function isObjectOutSight(param1:MapInteractiveObject) : Boolean
      {
         if(this._player == null)
         {
            return false;
         }
         return Math.abs(this._player.rootPX - param1.rootPX) > this.obf_X_n_3107.x || Math.abs(this._player.rootPY - param1.rootPY) > this.obf_X_n_3107.y;
      }
      
      public function addAsyncRefreshPlayer(param1:obf_0_M_3913) : void
      {
         if(param1 == this._player)
         {
            this.player.obf_A_j_2560();
         }
         else
         {
            this._refreshPlayerArray.push(param1.id);
         }
      }
      
      public function obf_S_t_4233() : void
      {
         var _loc1_:String = null;
         var _loc2_:obf_0_M_3913 = null;
         if(this._refreshPlayerArray.length == 0)
         {
            return;
         }
         if(getTimer() - this._lastRefreshPlayerMS < this._refreshPlayerIntervalMS)
         {
            return;
         }
         while(this._refreshPlayerArray.length > 0)
         {
            _loc1_ = this._refreshPlayerArray.pop();
            _loc2_ = this.remotePlayerSet.getObject(_loc1_) as obf_0_M_3913;
            if(_loc2_ == null)
            {
               if(this._player != null && this._player.id == _loc1_)
               {
                  _loc2_ = this._player;
               }
            }
            if(_loc2_ != null)
            {
               if(_loc2_.obf_A_j_2560())
               {
                  this._lastRefreshPlayerMS = getTimer();
                  break;
               }
            }
         }
      }
      
      public function getObjectUnderPoint(param1:int, param2:int, param3:Class = null, param4:Function = null) : MapInteractiveObject
      {
         var _loc8_:DisplayObject = null;
         var _loc9_:MapInteractiveObject = null;
         var _loc10_:Point = null;
         if(param3 == null)
         {
            param3 = MapInteractiveObject;
         }
         var _loc5_:MapInteractiveObject = null;
         var _loc6_:Point = this._roleLayer.localToGlobal(new Point(param1,param2));
         var _loc7_:* = int(this._roleLayer.numChildren - 1);
         while(_loc7_ >= 0)
         {
            _loc8_ = this._roleLayer.getChildAt(_loc7_);
            if(_loc8_ is param3)
            {
               if(_loc8_.visible)
               {
                  _loc9_ = _loc8_ as MapInteractiveObject;
                  _loc10_ = _loc8_.globalToLocal(_loc6_);
                  if(_loc9_.area.contains(param1,param2) && obf_1_q_4613.hitTestXYSelf(_loc9_,_loc10_.x,_loc10_.y))
                  {
                     if(param4 == null || Boolean(param4(_loc9_)))
                     {
                        _loc5_ = _loc9_;
                        break;
                     }
                  }
               }
            }
            _loc7_--;
         }
         return _loc5_;
      }
      
      public function setSelectedObject(param1:MapInteractiveObject) : void
      {
         if(this._selectedObject == param1)
         {
            return;
         }
         if(this._selectedObject != null)
         {
            this._selectedObject.isSelected = false;
         }
         this._selectedObject = param1;
         if(this._selectedObject == null)
         {
            return;
         }
         this._selectedObject.isSelected = true;
      }
      
      public function getSelectedObject() : MapInteractiveObject
      {
         return this._selectedObject;
      }
      
      private function setTrackingObject(param1:MapInteractiveObject) : void
      {
         if(this._trackingObject == param1)
         {
            return;
         }
         if(this._trackingObject != null)
         {
            this._trackingObject.isTracked = false;
         }
         this._trackingObject = param1;
         if(this._trackingObject == null)
         {
            return;
         }
         this._trackingObject.isTracked = true;
      }
      
      public function getTrackingObject() : MapInteractiveObject
      {
         return this._trackingObject;
      }
      
      public function containsPoint(param1:Point) : Boolean
      {
         if(this.stage == null)
         {
            return false;
         }
         var _loc2_:Array = this.stage.getObjectsUnderPoint(param1);
         if(_loc2_.length == 0)
         {
            return false;
         }
         var _loc3_:DisplayObject = _loc2_[_loc2_.length - 1] as DisplayObject;
         if(obf_e_P_918.cursor.contains(_loc3_))
         {
            if(_loc2_.length < 2)
            {
               return false;
            }
            _loc3_ = _loc2_[_loc2_.length - 2] as DisplayObject;
         }
         return this.contains(_loc3_);
      }
      
      public function setListener(param1:obf_c_4_964) : void
      {
         this.obf_1_l_2808 = param1;
      }
      
      public function getListener() : obf_c_4_964
      {
         return this.obf_1_l_2808;
      }
      
      public function get obf_v_P_2126() : obf_i_u_2869
      {
         if(this.obf_K_K_2087 == null)
         {
            this.obf_K_K_2087 = new obf_i_u_2869(this);
         }
         return this.obf_K_K_2087;
      }
      
      private function createFarms() : void
      {
         var _loc3_:obf_0_1_N_478 = null;
         var _loc1_:Array = this._mapConfig.farms;
         if(_loc1_ == null || _loc1_.length == 0)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = new obf_0_1_N_478(_loc1_[_loc2_]);
            this._roleLayer.content.push(_loc3_);
            this.obf_v_P_2126.obf_h_F_3919(_loc3_);
            this.markFarmArea(_loc3_);
            _loc2_++;
         }
      }
      
      private function markFarmArea(param1:obf_0_1_N_478) : void
      {
         var _loc5_:Point = null;
         var _loc6_:String = null;
         var _loc2_:obf_n_v_1693 = param1.getTemplet();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = param1.rootX;
         var _loc4_:int = param1.rootY;
         for each(_loc5_ in _loc2_.getTotalArea())
         {
            _loc6_ = obf_1_q_4613.makePointKey(_loc3_ + _loc5_.x,_loc4_ + _loc5_.y);
            this.obf_l_Y_1331[_loc6_] = param1.id;
         }
      }
      
      public function getFarmUnderTile(param1:int, param2:int) : obf_0_1_N_478
      {
         var _loc3_:String = this.obf_l_Y_1331[obf_1_q_4613.makePointKey(param1,param2)];
         return this.obf_v_P_2126.getFarm(_loc3_);
      }
      
      public function getFarmUnderPoint(param1:int, param2:int) : obf_0_1_N_478
      {
         var _loc3_:Point = obf_1_q_4613.obf_0_7_i_369(new Point(param1,param2));
         return this.getFarmUnderTile(_loc3_.x,_loc3_.y);
      }
      
      public function getFarmUnderObject(param1:MapObject) : obf_0_1_N_478
      {
         return this.getFarmUnderTile(param1.rootX,param1.rootY);
      }
      
      public function obf_W_t_3446() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Point = null;
         var _loc3_:obf_j_1_3698 = null;
         var _loc4_:obf_0_1_1_203 = null;
         if(this.obf_W_d_2161 != null)
         {
            this.obf_W_d_2161.setFullPassable(true);
         }
         for each(_loc3_ in this.obf_4_h_2582.obf_0_678)
         {
            _loc1_ = _loc3_.unmovableArea;
            if(_loc1_ != null && _loc1_.length > 0)
            {
               for each(_loc2_ in _loc1_)
               {
                  this.obf_0_2_e_125();
                  this.obf_W_d_2161.setPassable(_loc3_.rootX + _loc2_.x,_loc3_.rootY + _loc2_.y,false);
               }
            }
         }
         for each(_loc4_ in this.obf_b_h_1770.obf_0_678)
         {
            _loc1_ = _loc4_.unmovableArea;
            if(_loc1_ != null && _loc1_.length > 0)
            {
               for each(_loc2_ in _loc1_)
               {
                  this.obf_0_2_e_125();
                  this.obf_W_d_2161.setPassable(_loc4_.rootX + _loc2_.x,_loc4_.rootY + _loc2_.y,false);
               }
            }
         }
         this.pathfindingMatrixChanged = true;
      }
      
      private function obf_0_2_e_125() : void
      {
         if(this.obf_W_d_2161 == null)
         {
            this.obf_W_d_2161 = new obf_i_G_2444();
            this.obf_W_d_2161.setSize(this.mapWidth,this.mapHeight);
            this.obf_W_d_2161.setFullPassable(true);
         }
      }
   }
}

