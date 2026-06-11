package com.sunweb.game.res
{
   import com.sunweb.game.util.obf_m_V_1111;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class obf_A_P_806 extends EventDispatcher
   {
      
      private var _bag:ResourceBag;
      
      private var _context:ResourceLoaderContext;
      
      private var _resourceConfig:Object;
      
      private var _loadingState:int = 0;
      
      private var obf_X_w_3096:int;
      
      private var _loadingCount:int;
      
      private var _nextLoadingIndex:int;
      
      private var _urlLoaderInUse:Dictionary = new Dictionary();
      
      private var _loaderInUse:Dictionary = new Dictionary();
      
      private var _itemsLoaded:Array = new Array();
      
      private var obf_o_m_2555:Array = new Array();
      
      private var _minProgressEventInterval:int = 500;
      
      private var _lastProgressEventTime:int = -1;
      
      public var str:String;
      
      private var _bytesLoaded:uint;
      
      private var obf_2_q_809:uint;
      
      public function obf_A_P_806(param1:ResourceBag)
      {
         super();
         this._bag = param1;
         this._context = param1.manager.context;
         this._resourceConfig = param1.manager.resourceConfig;
      }
      
      public function get bag() : ResourceBag
      {
         return this._bag;
      }
      
      public function load(param1:int = 6) : void
      {
         if(this._context.environment != EnvironmentEnum.BROWSER && this._context.environment != EnvironmentEnum.AIR)
         {
            throw new Error("Resource loader environment error!");
         }
         if(this._loadingState != obf_e_4650.WAITING)
         {
            return;
         }
         this.obf_X_w_3096 = param1;
         if(this.obf_X_w_3096 <= 0)
         {
            this.obf_X_w_3096 = 1;
         }
         this._loadingState = obf_e_4650.obf_D_b_3365;
         this._loadingCount = 0;
         this._nextLoadingIndex = 0;
         this.obf_9_n_4293();
      }
      
      public function unload() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         for(_loc1_ in this._urlLoaderInUse)
         {
            (_loc1_ as URLLoader).close();
            delete this._urlLoaderInUse[_loc1_];
         }
         this._urlLoaderInUse = null;
         for(_loc2_ in this._loaderInUse)
         {
            (_loc2_ as Loader).unload();
            delete this._loaderInUse[_loc2_];
         }
         this._loaderInUse = null;
         this._bag = null;
         this._context = null;
         this._resourceConfig = null;
         this._itemsLoaded.length = 0;
         this.obf_o_m_2555.length = 0;
      }
      
      private function obf_9_n_4293() : void
      {
         var loadFromServer:Boolean;
         var resObj:Object = null;
         var bytes:ByteArray = null;
         var req:URLRequest = null;
         var urlLoader:URLLoader = null;
         if(this._loadingCount >= this.obf_X_w_3096)
         {
            return;
         }
         while(this._nextLoadingIndex < this._bag.resourceArray.length)
         {
            resObj = this._bag.resourceArray[this._nextLoadingIndex];
            ++this._nextLoadingIndex;
            if(resObj.content == null)
            {
               ++this._loadingCount;
               loadFromServer = true;
               if(this._context.environment == EnvironmentEnum.AIR)
               {
                  bytes = this._context.loadLocalResource(this.getLocalLocation(resObj));
                  if(bytes != null)
                  {
                     loadFromServer = false;
                     obf_x_0_1295.obf_r_w_3556(resObj.id + " loaded(" + bytes.length + ") from local!");
                     this.parseResource(resObj,bytes);
                  }
               }
               if(loadFromServer)
               {
                  req = new URLRequest(this.getRemoteLocation(resObj));
                  urlLoader = new URLLoader();
                  urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
                  this.obf_G_Y_4131(urlLoader);
                  this._urlLoaderInUse[urlLoader] = resObj;
                  try
                  {
                     urlLoader.load(req);
                  }
                  catch(e:Error)
                  {
                     urlLoader.dispatchEvent(new SecurityErrorEvent(SecurityErrorEvent.SECURITY_ERROR));
                  }
               }
               this.obf_9_n_4293();
               return;
            }
            this.obf_M_l_2453(resObj);
         }
         this.obf_n_H_1054();
      }
      
      public function get loadingState() : int
      {
         return this._loadingState;
      }
      
      public function get maxConn() : int
      {
         return this.obf_X_w_3096;
      }
      
      public function set maxConn(param1:int) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         var _loc2_:Boolean = param1 > this.obf_X_w_3096;
         this.obf_X_w_3096 = param1;
         if(_loc2_ && this._loadingState == obf_e_4650.obf_D_b_3365)
         {
            this.obf_9_n_4293();
         }
      }
      
      public function get itemsLoaded() : Array
      {
         return this._itemsLoaded;
      }
      
      public function get itemsError() : Array
      {
         return this.obf_o_m_2555;
      }
      
      public function obf_t_l_3172(param1:Object) : void
      {
         if(this._loadingState == obf_e_4650.WAITING)
         {
            return;
         }
         if(this._loadingState == obf_e_4650.obf_D_b_3365)
         {
            this.obf_9_n_4293();
         }
         else if(this._loadingState == obf_e_4650.COMPLETE)
         {
            this._loadingState = obf_e_4650.obf_D_b_3365;
            this.obf_9_n_4293();
         }
      }
      
      private function obf_n_H_1054() : void
      {
         var _loc1_:obf_J_Y_3494 = null;
         if(this._loadingState != obf_e_4650.obf_D_b_3365)
         {
            return;
         }
         if(this._loadingCount <= 0 && this._nextLoadingIndex >= this._bag.resourceArray.length)
         {
            this._loadingState = obf_e_4650.COMPLETE;
            _loc1_ = new obf_J_Y_3494(obf_J_Y_3494.COMPLETE);
            _loc1_.bytesLoaded = this.getBytesLoaded();
            _loc1_.bytesTotal = this.getBytesTotal();
            _loc1_.itemsLoaded = this.getItemsLoaded();
            _loc1_.itemsError = this.getItemsError();
            _loc1_.itemsTotal = this.getItemsTotal();
            _loc1_.loadingPercent = this.getLoadingPercent();
            dispatchEvent(_loc1_);
         }
      }
      
      private function obf_M_l_2453(param1:Object) : void
      {
         var _loc2_:obf_J_Y_3494 = new obf_J_Y_3494(obf_J_Y_3494.obf_7_1_3649);
         _loc2_.itemCurrent = param1;
         this.str = "obf_____4763:" + _loc2_.itemCurrent.remark;
         dispatchEvent(_loc2_);
      }
      
      private function obf_r_R_4565(param1:Object) : void
      {
         var _loc2_:obf_J_Y_3494 = new obf_J_Y_3494(obf_J_Y_3494.obf_9_a_1908);
         _loc2_.itemCurrent = param1;
         dispatchEvent(_loc2_);
      }
      
      private function getRemoteLocation(param1:Object) : String
      {
         var _loc2_:String = param1.url;
         if(_loc2_.charAt(0) != "/")
         {
            _loc2_ = this._resourceConfig.baseURL + _loc2_;
         }
         return this._context.httpServerURL + _loc2_;
      }
      
      private function getLocalLocation(param1:Object) : String
      {
         var _loc2_:String = param1.url;
         if(_loc2_.charAt(0) != "/")
         {
            _loc2_ = this._resourceConfig.baseURL + _loc2_;
         }
         return _loc2_;
      }
      
      private function obf_x_a_3526() : int
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._itemsLoaded.length)
         {
            _loc1_ += this._itemsLoaded[_loc2_].bytesLength;
            _loc2_++;
         }
         for(_loc3_ in this._urlLoaderInUse)
         {
            _loc1_ += (_loc3_ as URLLoader).bytesLoaded;
         }
         for(_loc4_ in this._loaderInUse)
         {
            _loc1_ += (_loc4_ as Loader).contentLoaderInfo.bytesTotal;
         }
         return _loc1_;
      }
      
      private function obf_0_2_2_644() : int
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this._itemsLoaded.length)
         {
            _loc1_ += this._itemsLoaded[_loc2_].bytesLength;
            _loc2_++;
         }
         for(_loc3_ in this._urlLoaderInUse)
         {
            _loc1_ += (_loc3_ as URLLoader).bytesTotal;
         }
         for(_loc4_ in this._loaderInUse)
         {
            _loc1_ += (_loc4_ as Loader).contentLoaderInfo.bytesTotal;
         }
         return _loc1_;
      }
      
      public function getBytesLoaded() : uint
      {
         return this.obf_x_a_3526();
      }
      
      public function getBytesTotal() : uint
      {
         return this.obf_0_2_2_644();
      }
      
      public function getItemsLoaded() : int
      {
         return this._itemsLoaded.length;
      }
      
      public function getItemsError() : int
      {
         return this.obf_o_m_2555.length;
      }
      
      public function getItemsTotal() : int
      {
         return this._bag.resourceArray.length;
      }
      
      public function getLoadingCount() : int
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc1_:int = 0;
         for(_loc2_ in this._urlLoaderInUse)
         {
            _loc1_++;
         }
         for(_loc3_ in this._loaderInUse)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function getLoadingLoadedCount() : Number
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc1_:Number = 0;
         for(_loc2_ in this._urlLoaderInUse)
         {
            if(_loc2_.bytesTotal > 0)
            {
               _loc1_ += _loc2_.bytesLoaded / _loc2_.bytesTotal;
            }
         }
         for(_loc3_ in this._loaderInUse)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      public function getLoadingPercent() : Number
      {
         if(this.getItemsTotal() == 0)
         {
            return 0;
         }
         return (this.getItemsLoaded() + this.getLoadingLoadedCount()) / this.getItemsTotal() * 100;
      }
      
      public function getCurFilePercent() : Number
      {
         return this._bytesLoaded / this.obf_2_q_809 * 100;
      }
      
      private function obf_G_Y_4131(param1:URLLoader) : void
      {
         param1.addEventListener(ProgressEvent.PROGRESS,this.obf_5_2932);
         param1.addEventListener(IOErrorEvent.IO_ERROR,this.obf_W_G_4054);
         param1.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.obf_W_G_4054);
         param1.addEventListener(Event.COMPLETE,this.obf_c_N_4619);
      }
      
      private function removeLoadingEventListeners(param1:URLLoader) : void
      {
         param1.removeEventListener(ProgressEvent.PROGRESS,this.obf_5_2932);
         param1.removeEventListener(IOErrorEvent.IO_ERROR,this.obf_W_G_4054);
         param1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.obf_W_G_4054);
         param1.removeEventListener(Event.COMPLETE,this.obf_c_N_4619);
      }
      
      private function obf_5_2932(param1:ProgressEvent) : void
      {
         var _loc2_:obf_J_Y_3494 = null;
         if(this._lastProgressEventTime == -1 || getTimer() - this._lastProgressEventTime >= this._minProgressEventInterval)
         {
            _loc2_ = new obf_J_Y_3494(obf_J_Y_3494.PROGRESS);
            _loc2_.bytesLoaded = this.getBytesLoaded();
            _loc2_.bytesTotal = this.getBytesTotal();
            _loc2_.itemsLoaded = this.getItemsLoaded();
            _loc2_.itemsError = this.getItemsError();
            _loc2_.itemsTotal = this.getItemsTotal();
            _loc2_.loadingPercent = this.getLoadingPercent();
            this._bytesLoaded = param1.bytesLoaded;
            this.obf_2_q_809 = param1.bytesTotal;
            dispatchEvent(_loc2_);
            this._lastProgressEventTime = getTimer();
         }
      }
      
      private function obf_W_G_4054(param1:Event) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         var _loc3_:Object = this._urlLoaderInUse[_loc2_];
         if(_loc3_ == null)
         {
            return;
         }
         obf_x_0_1295.obf_r_w_3556("resource loading error: " + _loc3_.id + "(" + _loc3_.url + ")");
         this.obf_o_m_2555.push(_loc3_);
         delete this._urlLoaderInUse[_loc2_];
         this.removeLoadingEventListeners(_loc2_);
         --this._loadingCount;
         this.obf_r_R_4565(_loc3_);
         this.obf_9_n_4293();
         this.obf_n_H_1054();
      }
      
      private function obf_c_N_4619(param1:Event) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         var _loc3_:Object = this._urlLoaderInUse[_loc2_];
         var _loc4_:ByteArray = _loc2_.data as ByteArray;
         obf_x_0_1295.obf_r_w_3556(_loc3_.id + " loaded(" + _loc4_.length + ") from server!");
         delete this._urlLoaderInUse[_loc2_];
         this.removeLoadingEventListeners(_loc2_);
         if(this._context.environment == EnvironmentEnum.AIR)
         {
            this._context.saveLocalResource(_loc4_,this.getLocalLocation(_loc3_));
         }
         this.parseResource(_loc3_,_loc4_);
      }
      
      private function parseResource(param1:Object, param2:ByteArray) : void
      {
         var isEncoded:Boolean = false;
         var ctx:LoaderContext = null;
         var loader:Loader = null;
         var charsetName:String = null;
         var resObj:Object = param1;
         var bytes:ByteArray = param2;
         resObj.bytesLength = bytes.length;
         if(resObj.hasOwnProperty("isEncoded"))
         {
            isEncoded = Boolean(resObj.isEncoded);
         }
         else if(this._bag.manager.isReleaseVersion)
         {
            isEncoded = true;
         }
         else
         {
            isEncoded = false;
         }
         try
         {
            if(isEncoded)
            {
               obf_m_V_1111.decryptDES(bytes);
               bytes.uncompress();
            }
         }
         catch(e:Error)
         {
            obf_x_0_1295.obf_r_w_3556("==== decode resource error: " + e.toString());
            return;
         }
         switch(resObj.type)
         {
            case obf_k_e_2851.obf_j_8_1883:
            case obf_k_e_2851.obf_3_N_2143:
            case obf_k_e_2851.obf_3_O_4122:
               ctx = null;
               if(resObj.type == obf_k_e_2851.obf_j_8_1883)
               {
                  ctx = new LoaderContext();
                  ctx.applicationDomain = new ApplicationDomain();
                  if(this._context.environment == EnvironmentEnum.AIR)
                  {
                     try
                     {
                        (ctx as Object).allowLoadBytesCodeExecution = true;
                     }
                     catch(err:Error)
                     {
                     }
                  }
               }
               loader = new Loader();
               this.obf_0_2_C_440(loader);
               this._loaderInUse[loader] = resObj;
               try
               {
                  loader.loadBytes(bytes,ctx);
               }
               catch(e:Error)
               {
                  loader.dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
               }
               break;
            case obf_k_e_2851.obf_T_M_4234:
               charsetName = resObj.charset;
               if(charsetName == null || charsetName == "")
               {
                  charsetName = "utf-8";
               }
               bytes.position = 0;
               if(resObj.content == null)
               {
                  resObj.content = bytes.readMultiByte(bytes.length,charsetName);
               }
               this._itemsLoaded.push(resObj);
               --this._loadingCount;
               this.obf_M_l_2453(resObj);
               this.obf_9_n_4293();
               this.obf_n_H_1054();
               break;
            case obf_k_e_2851.obf_9_j_1941:
               if(resObj.content == null)
               {
                  resObj.content = bytes;
               }
               this._itemsLoaded.push(resObj);
               --this._loadingCount;
               this.obf_M_l_2453(resObj);
               this.obf_9_n_4293();
               this.obf_n_H_1054();
               break;
            case obf_k_e_2851.obf_n_u_3241:
               obf_x_0_1295.obf_r_w_3556("ResourceBagLoader can not load dir directly: " + resObj.id);
               break;
            case obf_k_e_2851.obf_q_G_2964:
            case obf_k_e_2851.obf_7_R_4482:
            case obf_k_e_2851.obf_i_0_2353:
               this.obf_o_m_2555.push(resObj);
               --this._loadingCount;
               this.obf_r_R_4565(resObj);
               this.obf_9_n_4293();
               this.obf_n_H_1054();
               obf_x_0_1295.obf_r_w_3556("Unsupported resource type: " + resObj.type);
               break;
            default:
               throw new Error("Unkown resource type: " + resObj.type);
         }
      }
      
      private function obf_0_2_C_440(param1:Loader) : void
      {
         param1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.obf_A_4_3449);
         param1.contentLoaderInfo.addEventListener(Event.COMPLETE,this.obf_7_x_3980);
      }
      
      private function removeParsingEventListeners(param1:Loader) : void
      {
         param1.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.obf_A_4_3449);
         param1.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.obf_7_x_3980);
      }
      
      private function obf_A_4_3449(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         var _loc3_:Loader = _loc2_.loader;
         var _loc4_:Object = this._loaderInUse[_loc3_];
         if(_loc4_ == null)
         {
            return;
         }
         obf_x_0_1295.obf_r_w_3556("resource parsing error: " + _loc4_.id + "(" + _loc4_.url + ")");
         this.obf_o_m_2555.push(_loc4_);
         delete this._loaderInUse[_loc3_];
         this.removeParsingEventListeners(_loc3_);
         --this._loadingCount;
         this.obf_r_R_4565(_loc4_);
         this.obf_9_n_4293();
         this.obf_n_H_1054();
      }
      
      private function obf_7_x_3980(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         var _loc3_:Loader = _loc2_.loader;
         var _loc4_:Object = this._loaderInUse[_loc3_];
         obf_x_0_1295.obf_r_w_3556(_loc4_.id + " parsed!");
         this._itemsLoaded.push(_loc4_);
         delete this._loaderInUse[_loc3_];
         this.removeParsingEventListeners(_loc3_);
         if(_loc4_.content == null)
         {
            _loc4_.loader = _loc3_;
            if(_loc4_.type == obf_k_e_2851.obf_j_8_1883)
            {
               _loc4_.content = _loc2_.applicationDomain;
            }
            else
            {
               _loc4_.content = _loc2_.content;
            }
         }
         else
         {
            _loc3_.unload();
         }
         --this._loadingCount;
         this.obf_M_l_2453(_loc4_);
         this.obf_9_n_4293();
         this.obf_n_H_1054();
      }
   }
}

