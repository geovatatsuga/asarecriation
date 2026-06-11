package com.sunweb.game.res
{
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import flash.utils.ByteArray;
   
   public dynamic class ResourceLoaderContext
   {
      
      public static var defaultContext:ResourceLoaderContext;
      
      public var environment:int;
      
      public var httpServerURL:String;
      
      public var loadLocalResourceFun:Function;
      
      public var saveLocalResourceFun:Function;
      
      public function ResourceLoaderContext()
      {
         super();
      }
      
      public function setBrowserEnvironment(param1:String) : ResourceLoaderContext
      {
         this.environment = EnvironmentEnum.BROWSER;
         this.httpServerURL = param1;
         return this;
      }
      
      public function setAirEnvironment(param1:String, param2:Function, param3:Function) : ResourceLoaderContext
      {
         this.environment = EnvironmentEnum.AIR;
         this.httpServerURL = param1;
         this.loadLocalResourceFun = param2;
         this.saveLocalResourceFun = param3;
         return this;
      }
      
      public function loadLocalResource(param1:String) : ByteArray
      {
         var resURL:String = param1;
         if(this.loadLocalResourceFun == null)
         {
            return null;
         }
         try
         {
            return this.loadLocalResourceFun(resURL);
         }
         catch(e:Error)
         {
            obf_x_0_1295.obf_r_w_3556("ResourceLoaderContext.loadLocalResource() error: " + e.toString());
         }
         return null;
      }
      
      public function saveLocalResource(param1:ByteArray, param2:String) : void
      {
         var bytes:ByteArray = param1;
         var resURL:String = param2;
         if(this.saveLocalResourceFun == null)
         {
            return;
         }
         try
         {
            this.saveLocalResourceFun(bytes,resURL);
         }
         catch(e:Error)
         {
            obf_x_0_1295.obf_r_w_3556("ResourceLoaderContext.saveLocalResource() error: " + e.toString());
         }
      }
   }
}

