package com.sunweb.game.res
{
   public class ResourceBag
   {
      
      protected var _rm:ResourceManager = null;
      
      protected var _name:String = null;
      
      protected var _resourceMap:Object = null;
      
      protected var _resourceArray:Array = null;
      
      protected var _loader:obf_A_P_806;
      
      public function ResourceBag(param1:String, param2:ResourceManager)
      {
         super();
         this._rm = param2;
         this._name = param1;
         this._resourceMap = new Object();
         this._resourceArray = new Array();
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get resourceArray() : Array
      {
         return this._resourceArray;
      }
      
      public function get resourceMap() : Object
      {
         return this._resourceMap;
      }
      
      public function dispose() : void
      {
         if(this.manager == null)
         {
            return;
         }
         this.manager.destroyBag(this.name);
      }
      
      public function _dispose() : void
      {
         var _loc2_:Object = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._resourceArray.length)
         {
            _loc2_ = this._resourceArray[_loc1_];
            --_loc2_.referCount;
            _loc1_++;
         }
         if(this._loader != null)
         {
            this._loader.unload();
            this._loader = null;
         }
         this._resourceArray = null;
         this._resourceMap = null;
         this._rm = null;
      }
      
      public function obf_z_U_2156(param1:String) : Boolean
      {
         var _loc2_:Object = this._rm.getResource(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         if(this._resourceMap[param1] != null)
         {
            return true;
         }
         if(_loc2_.referCount == null)
         {
            _loc2_.referCount = 1;
         }
         else
         {
            ++_loc2_.referCount;
         }
         this._resourceArray.push(_loc2_);
         this._resourceMap[param1] = _loc2_;
         this.loader.obf_t_l_3172(_loc2_);
         return true;
      }
      
      public function obf_0_4_P_124(param1:String) : Boolean
      {
         if(param1 == null || param1 == "")
         {
            return false;
         }
         this._rm.obf_h_p_1259(param1);
         return this.obf_z_U_2156(obf_b_8_4256.getResIdToImport(param1));
      }
      
      public function obf_O_2_3845(param1:String, param2:String = null, param3:String = null, param4:Boolean = false) : Boolean
      {
         if(param1 == null || param1 == "")
         {
            return false;
         }
         var _loc5_:String = obf_b_8_4256.getResIdToImport(obf_b_8_4256.obf_P_O_2085 + param1);
         this._rm.obf_0_2_5_246(param1,param2,param3,param4);
         return this.obf_z_U_2156(_loc5_);
      }
      
      public function existsResource(param1:String) : Boolean
      {
         return this._resourceMap[param1] != null;
      }
      
      public function getResource(param1:String) : Object
      {
         return this._resourceMap[param1];
      }
      
      public function get manager() : ResourceManager
      {
         return this._rm;
      }
      
      public function get loader() : obf_A_P_806
      {
         if(this._loader == null)
         {
            this._loader = new obf_A_P_806(this);
         }
         return this._loader;
      }
      
      public function load(param1:int = 6) : void
      {
         this.loader.load(param1);
      }
   }
}

