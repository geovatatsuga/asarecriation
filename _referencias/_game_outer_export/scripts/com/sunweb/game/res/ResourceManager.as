package com.sunweb.game.res
{
   import com.adobe.serialization.json.JSON;
   import com.sunweb.game.util.obf_m_V_1111;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.media.Sound;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   
   public class ResourceManager
   {
      
      protected static var _instance:ResourceManager = null;
      
      protected var _resourceConfig:Object = null;
      
      protected var _resourceArray:Array = null;
      
      protected var _resourceMap:Object = null;
      
      protected var _isReleaseVersion:Boolean = false;
      
      protected var _context:ResourceLoaderContext;
      
      public var obf_Z_w_3367:Boolean = true;
      
      private var obf_7_Y_4506:Object;
      
      protected var _bags:Object;
      
      public function ResourceManager(param1:String, param2:ResourceLoaderContext)
      {
         var _loc4_:* = undefined;
         this.obf_7_Y_4506 = new Object();
         this._bags = new Object();
         super();
         if(param2 == null)
         {
            throw new Error("==== Can\'t new ResourceManager(), null context!");
         }
         this._context = param2;
         this._resourceConfig = com.adobe.serialization.json.JSON.decode(param1);
         this._isReleaseVersion = this._resourceConfig.isReleaseVersion;
         if(this._resourceConfig.baseURL == null || this._resourceConfig.baseURL == "")
         {
            this._resourceConfig.baseURL = "/";
         }
         else if(this._resourceConfig.baseURL.substr(this._resourceConfig.baseURL.length - 1) != "/")
         {
            this._resourceConfig.baseURL += "/";
         }
         this._resourceArray = this._resourceConfig.resources as Array;
         this._resourceMap = new Object();
         obf_x_0_1295.obf_r_w_3556("-------resource list begin--------" + this._resourceArray.length);
         var _loc3_:int = 0;
         while(_loc3_ < this._resourceArray.length)
         {
            _loc4_ = this._resourceArray[_loc3_];
            this._resourceMap[_loc4_.id] = _loc4_;
            obf_x_0_1295.obf_r_w_3556(_loc4_.id + "(" + _loc4_.remark + "):" + _loc4_.url);
            _loc3_++;
         }
         obf_x_0_1295.obf_r_w_3556("-------resource list end--------");
      }
      
      public static function parseResourceText(param1:ByteArray) : String
      {
         if(param1 == null || param1.length == 0)
         {
            return null;
         }
         if(isEncodedConfigData(param1))
         {
            obf_m_V_1111.decryptDES(param1);
            param1.uncompress();
         }
         param1.position = 0;
         return param1.readUTFBytes(param1.bytesAvailable);
      }
      
      private static function isEncodedConfigData(param1:ByteArray) : Boolean
      {
         if(param1.length < 5)
         {
            return false;
         }
         if(param1[0] != "{".charCodeAt() && param1[0] != "[".charCodeAt())
         {
            return true;
         }
         if(!isAsciiChar(param1[1]) || !isAsciiChar(param1[2]) || !isAsciiChar(param1[3]))
         {
            return true;
         }
         var _loc2_:int = int(param1[param1.length - 1]);
         if(_loc2_ != "}".charCodeAt() && _loc2_ != "]".charCodeAt() && _loc2_ != " ".charCodeAt() && _loc2_ != "\r".charCodeAt() && _loc2_ != "\n".charCodeAt())
         {
            return true;
         }
         return false;
      }
      
      private static function isAsciiChar(param1:int) : Boolean
      {
         return param1 >= 0 && param1 <= 127;
      }
      
      public static function initializeInstance(param1:String, param2:ResourceLoaderContext) : void
      {
         _instance = new ResourceManager(param1,param2);
      }
      
      public static function get instance() : ResourceManager
      {
         return _instance;
      }
      
      public function get resourceConfig() : Object
      {
         return this._resourceConfig;
      }
      
      public function get context() : ResourceLoaderContext
      {
         return this._context;
      }
      
      public function get isReleaseVersion() : Boolean
      {
         return this._isReleaseVersion;
      }
      
      public function get resourceArray() : Array
      {
         return this._resourceArray;
      }
      
      public function get resourceMap() : Object
      {
         return this._resourceMap;
      }
      
      public function obf_H_e_2180(param1:Object) : void
      {
         if(param1.id == null || param1.id == "")
         {
            throw new Error("obf________96!");
         }
         if(this.existsResource(param1.id))
         {
            throw new Error("obf__________34: " + param1.id);
         }
         this._resourceArray.push(param1);
         this._resourceMap[param1.id] = param1;
      }
      
      public function obf_h_p_1259(param1:String) : Object
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc5_:obf_b_8_4256 = null;
         if(param1 == null || param1 == "")
         {
            return null;
         }
         var _loc2_:obf_b_8_4256 = obf_b_8_4256.getUrdReadonly(param1);
         if(this.existsResource(_loc2_.resIdToImport))
         {
            return this.getResource(_loc2_.resIdToImport);
         }
         if(_loc2_.type == obf_g_I_3092.obf_z_u_4101)
         {
            _loc3_ = this.getResource(_loc2_.dir);
            if(_loc3_ != null)
            {
               _loc4_ = {};
               _loc4_.id = _loc2_.resIdToImport;
               _loc4_.type = _loc3_.fileType;
               _loc4_.url = _loc3_.url + "/" + _loc2_.name;
               if(_loc3_.hasOwnProperty("charset"))
               {
                  _loc4_.charset = _loc3_.charset;
               }
               if(_loc3_.hasOwnProperty("isEncoded"))
               {
                  _loc4_.isEncoded = _loc3_.isEncoded;
               }
               if(_loc3_.hasOwnProperty("noNeedEncode"))
               {
                  _loc4_.noNeedEncode = _loc3_.noNeedEncode;
               }
               _loc4_.isDynamic = true;
               this.obf_H_e_2180(_loc4_);
               return _loc4_;
            }
            return null;
         }
         if(_loc2_.type == obf_g_I_3092.obf_0_8_v_318)
         {
            return this.obf_0_2_5_246(_loc2_.url);
         }
         if(_loc2_.type == obf_g_I_3092.obf_0_8_K_597)
         {
            _loc5_ = obf_b_8_4256.getUrdReadonly(_loc2_.lib);
            if(_loc5_.type == obf_g_I_3092.obf_z_u_4101 || _loc5_.type == obf_g_I_3092.obf_0_8_v_318)
            {
               return this.obf_h_p_1259(_loc2_.lib);
            }
            return null;
         }
         return null;
      }
      
      public function obf_0_2_5_246(param1:String, param2:String = null, param3:String = null, param4:Boolean = false) : Object
      {
         if(param1 == null || param1 == "")
         {
            return false;
         }
         var _loc5_:String = obf_b_8_4256.getResIdToImport(obf_b_8_4256.obf_P_O_2085 + param1);
         if(this.existsResource(_loc5_))
         {
            return this.getResource(_loc5_);
         }
         var _loc6_:Object = {};
         _loc6_.id = _loc5_;
         _loc6_.type = param2 == null || param2 == "" ? obf_k_e_2851.getTypeAuto(param1) : param2;
         _loc6_.url = param1;
         if(param3 != null)
         {
            _loc6_.charset = param3;
         }
         _loc6_.isEncoded = param4;
         _loc6_.isDynamic = true;
         this.obf_H_e_2180(_loc6_);
         return _loc6_;
      }
      
      public function existsResource(param1:String) : Boolean
      {
         return this._resourceMap[param1] != null;
      }
      
      public function getResource(param1:String) : Object
      {
         return this._resourceMap[param1];
      }
      
      public function removeResource(param1:Object) : void
      {
         var _loc2_:Object = this._resourceMap[param1];
         if(_loc2_ == null)
         {
            return;
         }
         delete this._resourceMap[param1];
         var _loc3_:int = this._resourceArray.indexOf(_loc2_);
         if(_loc3_ > -1)
         {
            this._resourceArray.splice(_loc3_,1);
         }
      }
      
      public function isResourceLoaded(param1:String) : Boolean
      {
         return this.getResourceContent(param1) != null;
      }
      
      public function obf_d_q_1462(param1:String) : ResourceBag
      {
         if(param1 == null || param1 == "")
         {
            throw new Error("obf_________44!");
         }
         if(this._bags[param1] != null)
         {
            throw new Error("obf____________19: " + param1);
         }
         var _loc2_:ResourceBag = new ResourceBag(param1,this);
         this._bags[param1] = _loc2_;
         return _loc2_;
      }
      
      public function getBag(param1:String, param2:Boolean = false) : ResourceBag
      {
         var _loc3_:ResourceBag = this._bags[param1];
         if(_loc3_ == null && param2)
         {
            _loc3_ = this.obf_d_q_1462(param1);
         }
         return _loc3_;
      }
      
      public function destroyBag(param1:String) : void
      {
         var _loc2_:ResourceBag = this._bags[param1];
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_._dispose();
         delete this._bags[param1];
         this.obf_h_v_3888();
      }
      
      public function get bagMap() : Object
      {
         return this._bags;
      }
      
      private function obf_h_v_3888() : void
      {
         var _loc3_:Object = null;
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         while(_loc2_ < this._resourceArray.length)
         {
            _loc3_ = this._resourceArray[_loc2_];
            if(_loc3_.referCount != null && _loc3_.referCount <= 0)
            {
               this.obf_O_f_2428(_loc3_);
               _loc1_ = true;
            }
            _loc2_++;
         }
         if(_loc1_)
         {
         }
      }
      
      private function obf_O_f_2428(param1:Object) : void
      {
         var urdString:String = null;
         var urd:obf_b_8_4256 = null;
         var bmd:BitmapData = null;
         var resObj:Object = param1;
         for(urdString in this.obf_7_Y_4506)
         {
            urd = obf_b_8_4256.getUrdReadonly(urdString);
            if(urd.resIdToImport == resObj.id)
            {
               try
               {
                  bmd = this.obf_7_Y_4506[urdString];
                  delete this.obf_7_Y_4506[urdString];
                  bmd.dispose();
               }
               catch(err:Error)
               {
                  trace("ResourceManager.disposeRes() " + err.toString());
               }
            }
         }
         delete resObj.content;
         try
         {
            if(resObj.loader != null)
            {
               (resObj.loader as Loader).unload();
            }
         }
         catch(e:Error)
         {
            obf_x_0_1295.obf_r_w_3556("ResourceManager.disposeRes() error: " + e.toString());
         }
         delete resObj.loader;
         delete resObj.referCount;
         delete resObj.bytesLength;
      }
      
      public function getResourceContent(param1:String) : *
      {
         var _loc2_:Object = this._resourceMap[param1];
         return _loc2_ == null ? null : _loc2_.content;
      }
      
      public function getBitmapData(param1:String) : BitmapData
      {
         var urd:obf_b_8_4256 = null;
         var appDomain:ApplicationDomain = null;
         var cr:Class = null;
         var res:String = param1;
         var bmd:BitmapData = null;
         if(this.obf_Z_w_3367)
         {
            bmd = this.obf_7_Y_4506[res];
            if(bmd != null)
            {
               return bmd;
            }
         }
         try
         {
            urd = obf_b_8_4256.getUrdReadonly(res);
            if(urd.lib == null || urd.lib == "")
            {
               bmd = (this.getResourceContent(urd.resIdToImport) as Bitmap).bitmapData.clone();
            }
            else
            {
               appDomain = this.getResourceContent(urd.lib) as ApplicationDomain;
               cr = appDomain.getDefinition(urd.name) as Class;
               bmd = new cr(1,1) as BitmapData;
            }
         }
         catch(e:Error)
         {
         }
         if(this.obf_Z_w_3367 && bmd != null)
         {
            this.obf_7_Y_4506[res] = bmd;
         }
         return bmd;
      }
      
      public function getBitmap(param1:String) : Bitmap
      {
         var _loc2_:BitmapData = this.getBitmapData(param1);
         return _loc2_ == null ? null : new Bitmap(_loc2_);
      }
      
      public function getMovieClip(param1:String) : MovieClip
      {
         return this._getDisplayObject(param1) as MovieClip;
      }
      
      private function _getDisplayObject(param1:String) : DisplayObject
      {
         var urd:obf_b_8_4256 = null;
         var appDomain:ApplicationDomain = null;
         var cr:Class = null;
         var obj:DisplayObject = null;
         var res:String = param1;
         try
         {
            urd = obf_b_8_4256.getUrdReadonly(res);
            if(urd.lib == null || urd.lib == "")
            {
               return this.getResourceContent(urd.resIdToImport) as DisplayObject;
            }
            appDomain = this.getResourceContent(urd.lib) as ApplicationDomain;
            cr = appDomain.getDefinition(urd.name) as Class;
            obj = new cr() as DisplayObject;
            return obj;
         }
         catch(e:Error)
         {
         }
         return null;
      }
      
      public function getDisplayObject(param1:String) : DisplayObject
      {
         var _loc2_:DisplayObject = this.getBitmap(param1);
         if(_loc2_ == null)
         {
            _loc2_ = this._getDisplayObject(param1);
         }
         return _loc2_;
      }
      
      public function getSound(param1:String) : Sound
      {
         var urd:obf_b_8_4256 = null;
         var appDomain:ApplicationDomain = null;
         var cr:Class = null;
         var snd:Sound = null;
         var res:String = param1;
         try
         {
            urd = obf_b_8_4256.getUrdReadonly(res);
            if(urd.lib == null || urd.lib == "")
            {
               return this.getResourceContent(urd.resIdToImport) as Sound;
            }
            appDomain = this.getResourceContent(urd.lib) as ApplicationDomain;
            cr = appDomain.getDefinition(urd.name) as Class;
            snd = new cr() as Sound;
            return snd;
         }
         catch(e:Error)
         {
         }
         return null;
      }
      
      public function getText(param1:String) : String
      {
         return this.getResourceContent(param1) as String;
      }
      
      public function getBytes(param1:String) : ByteArray
      {
         return this.getResourceContent(param1) as ByteArray;
      }
      
      public function obf_s_i_1796(param1:Boolean = true) : void
      {
         var urdString:String = null;
         var bmd:BitmapData = null;
         var disposeIt:Boolean = param1;
         for(urdString in this.obf_7_Y_4506)
         {
            try
            {
               bmd = this.obf_7_Y_4506[urdString] as BitmapData;
               delete this.obf_7_Y_4506[urdString];
               if(disposeIt)
               {
                  bmd.dispose();
               }
            }
            catch(err:Error)
            {
               trace("ResourceManager.clearBitmapCache() " + err.toString());
            }
         }
      }
   }
}

