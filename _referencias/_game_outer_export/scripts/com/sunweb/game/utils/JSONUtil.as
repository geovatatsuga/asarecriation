package com.sunweb.game.utils
{
   public class JSONUtil
   {
      
      public function JSONUtil()
      {
         super();
      }
      
      public static function getValue(param1:Object, ... rest) : *
      {
         var pObj:*;
         var p:* = undefined;
         var obj:Object = param1;
         var args:Array = rest;
         if(!obj)
         {
            return null;
         }
         pObj = obj;
         try
         {
            for each(p in args)
            {
               pObj = pObj[p];
            }
         }
         catch(e:Error)
         {
            return null;
         }
         return pObj;
      }
      
      public static function getInt(param1:Object, param2:Array, param3:int = 0) : int
      {
         var pObj:*;
         var p:* = undefined;
         var obj:Object = param1;
         var props:Array = param2;
         var defValue:int = param3;
         if(!obj)
         {
            return defValue;
         }
         pObj = obj;
         try
         {
            for each(p in props)
            {
               pObj = pObj[p];
            }
         }
         catch(e:Error)
         {
            return defValue;
         }
         if(pObj == null)
         {
            return defValue;
         }
         return int(pObj);
      }
      
      public static function getNumber(param1:Object, param2:Array, param3:Number = 0) : Number
      {
         var pObj:*;
         var p:* = undefined;
         var obj:Object = param1;
         var props:Array = param2;
         var defValue:Number = param3;
         if(!obj)
         {
            return defValue;
         }
         pObj = obj;
         try
         {
            for each(p in props)
            {
               pObj = pObj[p];
            }
         }
         catch(e:Error)
         {
            return defValue;
         }
         if(pObj == null)
         {
            return defValue;
         }
         return Number(pObj);
      }
      
      public static function getBoolean(param1:Object, param2:Array, param3:Boolean = false) : Boolean
      {
         var pObj:*;
         var p:* = undefined;
         var obj:Object = param1;
         var props:Array = param2;
         var defValue:Boolean = param3;
         if(!obj)
         {
            return defValue;
         }
         pObj = obj;
         try
         {
            for each(p in props)
            {
               pObj = pObj[p];
            }
         }
         catch(e:Error)
         {
            return defValue;
         }
         if(pObj == null)
         {
            return defValue;
         }
         return Boolean(pObj);
      }
      
      public static function getStr(param1:Object, param2:Array, param3:String = "") : String
      {
         var pObj:*;
         var p:* = undefined;
         var obj:Object = param1;
         var props:Array = param2;
         var defValue:String = param3;
         if(!obj)
         {
            return defValue;
         }
         pObj = obj;
         try
         {
            for each(p in props)
            {
               pObj = pObj[p];
            }
         }
         catch(e:Error)
         {
            return defValue;
         }
         if(pObj == null)
         {
            return defValue;
         }
         return String(pObj || defValue);
      }
      
      public static function getObject(param1:Object, param2:Array, param3:Object = null) : Object
      {
         var pObj:*;
         var p:* = undefined;
         var obj:Object = param1;
         var props:Array = param2;
         var defValue:Object = param3;
         if(!obj)
         {
            return defValue;
         }
         pObj = obj;
         try
         {
            for each(p in props)
            {
               pObj = pObj[p];
            }
         }
         catch(e:Error)
         {
            return defValue;
         }
         if(pObj == null)
         {
            return defValue;
         }
         return pObj || defValue;
      }
      
      public static function obf_P_M_2133(param1:Object) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:* = param1;
         for(_loc2_ in _loc4_)
         {
            return false;
         }
         return true;
      }
   }
}

