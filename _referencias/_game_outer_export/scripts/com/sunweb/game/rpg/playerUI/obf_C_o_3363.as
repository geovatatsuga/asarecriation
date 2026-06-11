package com.sunweb.game.rpg.playerUI
{
   import com.adobe.serialization.json.JSON;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.module.ProgressBoxModule;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class obf_C_o_3363
   {
      
      private static var loader:URLLoader;
      
      private static var configObj:Object;
      
      public function obf_C_o_3363()
      {
         super();
      }
      
      public static function loadUrlConfig(param1:String) : void
      {
         var configUrl:String = param1;
         if(loader)
         {
            try
            {
               loader.removeEventListener(IOErrorEvent.IO_ERROR,obf_W_b_1982);
               loader.removeEventListener(Event.COMPLETE,obf_t_M_1248);
            }
            catch(e:Error)
            {
            }
            loader.close();
         }
         loader = new URLLoader();
         loader.addEventListener(IOErrorEvent.IO_ERROR,obf_W_b_1982);
         loader.addEventListener(Event.COMPLETE,obf_t_M_1248);
         loader.load(new URLRequest(configUrl));
      }
      
      private static function obf_W_b_1982(param1:Event) : void
      {
         configObj = null;
      }
      
      private static function obf_t_M_1248(param1:Event) : void
      {
         var e:Event = param1;
         try
         {
            configObj = com.adobe.serialization.json.JSON.decode(loader.data);
         }
         catch(e:Error)
         {
            configObj = null;
         }
         ProgressBoxModule.initBG();
      }
      
      public static function getAttr(param1:String) : Object
      {
         if(!configObj)
         {
            return null;
         }
         return configObj[param1];
      }
      
      public static function getUrl(param1:String) : String
      {
         return replaceUrlVarString(JSONUtil.getStr(configObj,[param1]));
      }
      
      public static function openActionURL(param1:String, param2:Boolean = false) : Boolean
      {
         var thisJS:String = null;
         var urlName:String = param1;
         var isNoRemoteUrl:Boolean = param2;
         var thisURL:String = isNoRemoteUrl ? replaceUrlVarString(urlName) : getUrl(urlName);
         if(!obf_L_l_4100.isEmpty(thisURL))
         {
            if(thisURL.toLowerCase().indexOf("javascript:") == 0)
            {
               thisJS = thisURL.substring(11);
               try
               {
                  obf_H_l_800.call("eval",thisJS);
               }
               catch(e:Error)
               {
               }
            }
            else
            {
               navigateToURL(new URLRequest(thisURL));
            }
            return true;
         }
         return false;
      }
      
      public static function openResultUrl() : void
      {
         openActionURL("Result");
         try
         {
            obf_H_l_800.call("onResultUrl",GameContext.localPlayer.fullInfo.money);
         }
         catch(e:Error)
         {
         }
      }
      
      public static function replaceUrlVarString(param1:String) : String
      {
         var _loc4_:String = null;
         while(param1.indexOf("_%0_") > -1)
         {
            param1 = param1.replace("_%0_",GameContext.obf_N_G_4080);
         }
         while(param1.indexOf("_%1_") > -1)
         {
            param1 = param1.replace("_%1_",encodeURIComponent(GameContext.localPlayer.id));
         }
         while(param1.indexOf("_%2_") > -1)
         {
            param1 = param1.replace("_%2_",GameContext.obf_0_7_r_135);
         }
         while(param1.indexOf("_%3_") > -1)
         {
            param1 = param1.replace("_%3_",GameContext.localPlayer.fullInfo.level);
         }
         var _loc2_:RegExp = /_%([^%&]+)_/ig;
         var _loc3_:Object = _loc2_.exec(param1);
         while(_loc3_)
         {
            if(isNaN(parseInt(_loc3_[1])))
            {
               _loc4_ = obf_r_8_1121.getParameter([_loc3_[1]]);
               if(!obf_L_l_4100.isEmpty(_loc4_))
               {
                  param1 = param1.replace(_loc3_[0],_loc4_);
               }
            }
            _loc3_ = _loc2_.exec(param1);
         }
         return param1;
      }
   }
}

