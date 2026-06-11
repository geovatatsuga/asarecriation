package com.sunweb.game.rpg.map
{
   import com.sunweb.game.rpg.role.obf_0_Y_3475;
   
   public class obf_i_l_1569
   {
      
      private var _map:Map;
      
      private var obf_U_H_3975:Class;
      
      private var obf_Y_U_4023:Object = new Object();
      
      private var obf_I_8_1028:Object = new Object();
      
      private var obf_h_y_1292:Object = new Object();
      
      private var obf_C_z_1755:int = 0;
      
      public function obf_i_l_1569(param1:Map, param2:Class)
      {
         super();
         this._map = param1;
         this.obf_U_H_3975 = param2;
      }
      
      public function get size() : int
      {
         return this.obf_C_z_1755;
      }
      
      public function addObject(param1:MapInteractiveObject) : Boolean
      {
         if(param1 == null || !(param1 is this.obf_U_H_3975))
         {
            return false;
         }
         if(this.getObject(param1.id) != null)
         {
            return false;
         }
         this.obf_Y_U_4023[param1.id] = param1;
         this._map.allMapObjects[param1.id] = param1;
         ++this.obf_C_z_1755;
         param1.setMap(this._map);
         if(this._map.stage == null)
         {
            this.obf_h_y_1292[param1.id] = param1;
         }
         else if(this._map.isObjectInSight(param1))
         {
            this.obf_I_8_1028[param1.id] = param1;
            param1.obf_9_C_1574(this._map);
            if(this._map.getListener() != null)
            {
               this._map.getListener().onObjectInSight(param1);
            }
         }
         else
         {
            this.obf_h_y_1292[param1.id] = param1;
         }
         return true;
      }
      
      public function getObject(param1:String) : MapInteractiveObject
      {
         return this.obf_Y_U_4023[param1];
      }
      
      public function removeObject(param1:MapInteractiveObject, param2:Boolean = false) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1 = this.getObject(param1.id);
         if(param1 == null)
         {
            return;
         }
         if(param1 is obf_0_Y_3475)
         {
            (param1 as obf_0_Y_3475).obf_B_H_3690();
         }
         param1.removeMe();
         param1.setMap(null);
         delete this._map.allMapObjects[param1.id];
         delete this.obf_Y_U_4023[param1.id];
         delete this.obf_I_8_1028[param1.id];
         delete this.obf_h_y_1292[param1.id];
         if(param2)
         {
            param1.destroy();
         }
         --this.obf_C_z_1755;
      }
      
      public function removeAllObjects(param1:Boolean = false) : void
      {
         var _loc2_:MapInteractiveObject = null;
         for each(_loc2_ in this.obf_Y_U_4023)
         {
            this.removeObject(_loc2_,param1);
         }
      }
      
      public function get obf_0_678() : Object
      {
         return this.obf_Y_U_4023;
      }
      
      public function get obf_3_C_4291() : Object
      {
         return this.obf_I_8_1028;
      }
      
      public function get obf_t_5_3859() : Object
      {
         return this.obf_h_y_1292;
      }
      
      public function updateSightState() : void
      {
         var _loc1_:Object = new Object();
         var _loc2_:MapInteractiveObject = null;
         for each(_loc2_ in this.obf_h_y_1292)
         {
            if(this._map.isObjectInSight(_loc2_))
            {
               delete this.obf_h_y_1292[_loc2_.id];
               _loc1_[_loc2_.id] = _loc2_;
               _loc2_.obf_9_C_1574(this._map);
               if(this._map.getListener() != null)
               {
                  this._map.getListener().onObjectInSight(_loc2_);
               }
            }
         }
         for each(_loc2_ in this.obf_I_8_1028)
         {
            if(this._map.isObjectOutSight(_loc2_))
            {
               delete this.obf_I_8_1028[_loc2_.id];
               this.obf_h_y_1292[_loc2_.id] = _loc2_;
               _loc2_.removeMe();
               if(this._map.getListener() != null)
               {
                  this._map.getListener().onObjectOutSight(_loc2_);
               }
            }
         }
         for each(_loc2_ in _loc1_)
         {
            this.obf_I_8_1028[_loc2_.id] = _loc2_;
            delete _loc1_[_loc2_.id];
         }
      }
      
      public function destroy(param1:Boolean = false) : void
      {
         this.removeAllObjects(param1);
         this._map = null;
      }
   }
}

