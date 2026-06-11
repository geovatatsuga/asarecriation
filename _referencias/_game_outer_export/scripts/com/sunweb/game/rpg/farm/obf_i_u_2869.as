package com.sunweb.game.rpg.farm
{
   import com.sunweb.game.rpg.map.Map;
   
   public class obf_i_u_2869
   {
      
      private var _map:Map;
      
      private var _farms:Object = new Object();
      
      public function obf_i_u_2869(param1:Map)
      {
         super();
         this._map = param1;
      }
      
      public function obf_h_F_3919(param1:obf_0_1_N_478) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(this.getFarm(param1.id) != null)
         {
            return false;
         }
         this._farms[param1.id] = param1;
         param1.setMap(this._map);
         return true;
      }
      
      public function getFarm(param1:String) : obf_0_1_N_478
      {
         return this._farms[param1];
      }
      
      public function removeFarm(param1:obf_0_1_N_478, param2:Boolean = false) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1 = this.getFarm(param1.id);
         if(param1 == null)
         {
            return;
         }
         param1.setMap(null);
         delete this._farms[param1.id];
         if(param2)
         {
            param1.destroy();
         }
      }
      
      public function removeAllFarms(param1:Boolean = false) : void
      {
         var _loc2_:obf_0_1_N_478 = null;
         for each(_loc2_ in this._farms)
         {
            this.removeFarm(_loc2_,param1);
         }
      }
      
      public function get farms() : Object
      {
         return this._farms;
      }
      
      public function destroy(param1:Boolean = false) : void
      {
         this.removeAllFarms(param1);
         this._map = null;
      }
   }
}

