package com.sunweb.game.rpg.farm
{
   import com.sunweb.game.rpg.map.Map;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.map.obf_1_q_4613;
   import com.sunweb.game.rpg.map.obf_2_1_1369;
   import com.sunweb.game.rpg.map.obf_p_X_4170;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public dynamic class obf_0_1_N_478 extends obf_p_X_4170
   {
      
      public static var emptyFarmSign:String = "";
      
      public static var playerFarmSign:String = "";
      
      public static var commonFarmSign:String = "";
      
      public var id:String;
      
      public var templetCode:String;
      
      public var farmType:int;
      
      public var ownerId:String;
      
      public var currentLevel:int = 1;
      
      public var farmName:String;
      
      public var farmExp:int;
      
      protected var obf_5_a_4161:Sprite;
      
      protected var obf_4_J_1587:Boolean = false;
      
      public function obf_0_1_N_478(param1:Object)
      {
         super(param1);
         this.id = param1.id;
         this.templetCode = param1.templetCode;
         var _loc2_:obf_n_v_1693 = FarmTempletManager.getFarmTemplet(this.templetCode);
         this.farmType = _loc2_.farmType;
         this.farmName = _loc2_.name;
         _res = _loc2_.res;
      }
      
      public function getFullId() : String
      {
         if(_map == null)
         {
            return null;
         }
         return this.id + "@" + _map.mapId;
      }
      
      public function getCenterX() : int
      {
         return rootX * Map.obf_7_7_3297;
      }
      
      public function getCenterY() : int
      {
         return rootY * Map.TILE_HEIGHT_IN_PIXEL + 300;
      }
      
      public function obf_Q_z_861() : void
      {
         var mc:MovieClip = null;
         try
         {
            mc = _displayObject as MovieClip;
            if(mc == null)
            {
               return;
            }
            if(mc.txtFarmLevel != null)
            {
               mc.txtFarmLevel.text = "Lv" + this.currentLevel;
            }
            if(mc.txtFarmName != null)
            {
               if(this.farmType == FarmType.obf_0_7_w_551)
               {
                  if(this.ownerId == null || this.ownerId == "")
                  {
                     mc.txtFarmName.text = emptyFarmSign + this.farmName;
                  }
                  else
                  {
                     mc.txtFarmName.text = this.ownerId + playerFarmSign + this.farmName;
                  }
               }
               if(this.farmType == FarmType.obf_5_b_4269)
               {
                  mc.txtFarmName.text = commonFarmSign + this.farmName;
               }
               if(this.farmType == FarmType.FAMILY_FARM)
               {
                  if(this.ownerId == null || this.ownerId == "")
                  {
                     mc.txtFarmName.text = emptyFarmSign + this.farmName;
                  }
                  else
                  {
                     mc.txtFarmName.text = this.ownerId + playerFarmSign + this.farmName;
                  }
               }
               if(this.farmType == FarmType.obf_U_z_3456)
               {
                  if(this.ownerId == null || this.ownerId == "")
                  {
                     mc.txtFarmName.text = emptyFarmSign + this.farmName;
                  }
                  else
                  {
                     mc.txtFarmName.text = this.ownerId + playerFarmSign + this.farmName;
                  }
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      override public function obf_T_Y_4478(param1:obf_2_1_1369) : void
      {
         super.obf_T_Y_4478(param1);
         this.obf_Q_z_861();
      }
      
      public function obf_v_t_1412(param1:String) : void
      {
         if(_res == param1)
         {
            return;
         }
         _res = param1;
         this.removeMe();
         this.release();
      }
      
      public function getTemplet() : obf_n_v_1693
      {
         return FarmTempletManager.getFarmTemplet(this.templetCode);
      }
      
      public function getFarmObjectsInFarm() : Array
      {
         return this.getObjectsInFarm(FarmObject);
      }
      
      public function getObjectsInFarm(param1:Class) : Array
      {
         var _loc3_:Object = null;
         if(_map == null)
         {
            return null;
         }
         var _loc2_:Array = new Array();
         for each(_loc3_ in _map.allMapObjects)
         {
            if(_loc3_ is param1 && (_loc3_ as MapInteractiveObject).getFarm() == this)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getAvailableFarmArea() : Array
      {
         try
         {
            return this.getTemplet().getLevelArea(this.currentLevel);
         }
         catch(e:Error)
         {
            obf_x_0_1295.obf_r_w_3556("Farm(id=" + id + ", templetCode=" + templetCode + ").getAvailableFarmArea() error: " + e);
         }
         return null;
      }
      
      public function getUsedFarmArea() : Array
      {
         var _loc3_:FarmObject = null;
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc1_:Array = this.getFarmObjectsInFarm();
         if(_loc1_ == null || _loc1_.length == 0)
         {
            return null;
         }
         var _loc2_:Array = new Array();
         for each(_loc3_ in _loc1_)
         {
            if(!(_loc3_.farmArea == null || _loc3_.farmArea.length == 0))
            {
               for each(_loc4_ in _loc3_.farmArea)
               {
                  _loc5_ = new Point(_loc4_.x + _loc3_.rootX - this.rootX,_loc4_.y + _loc3_.rootY - this.rootY);
                  _loc2_.push(_loc5_);
               }
            }
         }
         return _loc2_;
      }
      
      public function getUnmovableArea() : Array
      {
         var _loc3_:FarmObject = null;
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         var _loc1_:Array = this.getFarmObjectsInFarm();
         if(_loc1_ == null || _loc1_.length == 0)
         {
            return null;
         }
         var _loc2_:Array = new Array();
         for each(_loc3_ in _loc1_)
         {
            if(!(_loc3_.unmovableArea == null || _loc3_.unmovableArea.length == 0))
            {
               for each(_loc4_ in _loc3_.unmovableArea)
               {
                  _loc5_ = new Point(_loc4_.x + _loc3_.rootX - this.rootX,_loc4_.y + _loc3_.rootY - this.rootY);
                  _loc2_.push(_loc5_);
               }
            }
         }
         return _loc2_;
      }
      
      public function getUsableArea() : Object
      {
         var _loc2_:Point = null;
         var _loc4_:Array = null;
         var _loc1_:Object = new Object();
         var _loc3_:Array = this.getAvailableFarmArea();
         if(_loc3_ == null)
         {
            return _loc1_;
         }
         for each(_loc2_ in _loc3_)
         {
            _loc1_[obf_1_q_4613.makePointKey(_loc2_.x,_loc2_.y)] = _loc2_.clone();
         }
         _loc4_ = this.getUsedFarmArea();
         if(_loc4_ == null)
         {
            return _loc1_;
         }
         for each(_loc2_ in _loc4_)
         {
            delete _loc1_[obf_1_q_4613.makePointKey(_loc2_.x,_loc2_.y)];
         }
         return _loc1_;
      }
      
      public function canPutFarmObject(param1:FarmObject, param2:int, param3:int) : Boolean
      {
         var _loc5_:Point = null;
         var _loc6_:String = null;
         if(param1.farmArea == null || param1.farmArea.length == 0)
         {
            return false;
         }
         var _loc4_:Object = this.getUsableArea();
         for each(_loc5_ in param1.farmArea)
         {
            _loc6_ = obf_1_q_4613.makePointKey(param2 + _loc5_.x,param3 + _loc5_.y);
            if(_loc4_[_loc6_] == null)
            {
               return false;
            }
         }
         return true;
      }
      
      public function isInAvailableFarmArea(param1:int, param2:int) : Boolean
      {
         var _loc4_:Point = null;
         var _loc3_:Array = this.getAvailableFarmArea();
         if(_loc3_ == null)
         {
            return false;
         }
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.x == param1 && _loc4_.y == param2)
            {
               return true;
            }
         }
         return false;
      }
      
      public function set showAvailableFarmArea(param1:Boolean) : void
      {
         if(param1 == this.showAvailableFarmArea)
         {
            return;
         }
         if(param1)
         {
            if(_map == null)
            {
               return;
            }
            this.obf_5_a_4161 = new Sprite();
            obf_1_q_4613.drawTiles(this.obf_5_a_4161,this.getAvailableFarmArea(),65280,0.8,1);
            this.obf_5_a_4161.x = this.rootX * Map.obf_7_7_3297;
            this.obf_5_a_4161.y = this.rootY * Map.TILE_HEIGHT_IN_PIXEL;
            _map.bgObjectLayer.addChild(this.obf_5_a_4161);
         }
         else
         {
            this.obf_5_a_4161.parent.removeChild(this.obf_5_a_4161);
            this.obf_5_a_4161.graphics.clear();
            this.obf_5_a_4161 = null;
         }
      }
      
      public function get showAvailableFarmArea() : Boolean
      {
         return this.obf_5_a_4161 != null && this.obf_5_a_4161.parent != null;
      }
      
      public function set showTileState(param1:Boolean) : void
      {
         var _loc3_:FarmObject = null;
         if(this.obf_4_J_1587 == param1)
         {
            return;
         }
         this.obf_4_J_1587 = param1;
         this.showAvailableFarmArea = param1;
         var _loc2_:Array = this.getFarmObjectsInFarm();
         if(_loc2_ != null)
         {
            for each(_loc3_ in _loc2_)
            {
               _loc3_.showTileState = param1;
            }
         }
      }
      
      public function get showTileState() : Boolean
      {
         return this.obf_4_J_1587;
      }
   }
}

