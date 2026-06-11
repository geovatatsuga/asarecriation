package com.sunweb.game.res
{
   import obf_0_1_A_296.obf_I_t_863;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.setInterval;
   import org.superkaka.kakalib.struct.BitmapFrameInfo;
   import org.superkaka.kakalib.utils.obf_0_9_X_707;
   
   public class obf_0_P_4381
   {
      
      private static var _resBag:ResourceBag = ResourceManager.instance.getBag("#resUtilBag#",true);
      
      private static var _resPlaceholderMap:Dictionary = new Dictionary();
      
      private static var obf_a_D_3908:Boolean = false;
      
      public function obf_0_P_4381()
      {
         super();
      }
      
      public static function obf_m_X_1194(param1:String, param2:DisplayObjectContainer, param3:String = null, param4:int = -1, param5:ResourceBag = null) : void
      {
         var _loc7_:DisplayObject = null;
         var _loc8_:DisplayObject = null;
         if(param2 == null)
         {
            return;
         }
         ResourceManager.instance.obf_h_p_1259(param1);
         var _loc6_:String = obf_b_8_4256.getResIdToImport(param1);
         if(_loc6_ == null || !ResourceManager.instance.existsResource(_loc6_))
         {
            trace(">>>> loadAndShowRes() invalid res: " + param1);
            return;
         }
         if(ResourceManager.instance.isResourceLoaded(_loc6_))
         {
            _loc7_ = ResourceManager.instance.getDisplayObject(param1);
            if(_loc7_ != null)
            {
               if(param4 < 0)
               {
                  param2.addChild(_loc7_);
               }
               else
               {
                  param2.addChildAt(_loc7_,param4);
               }
            }
         }
         else
         {
            if(param5 == null)
            {
               param5 = _resBag;
            }
            param5.obf_z_U_2156(_loc6_);
            param5.load();
            _loc8_ = null;
            if(param3 != null && param3 != "")
            {
               _loc8_ = ResourceManager.instance.getDisplayObject(param3);
            }
            if(_loc8_ == null)
            {
               _loc8_ = new Shape();
            }
            if(param4 < 0)
            {
               param2.addChild(_loc8_);
            }
            else
            {
               param2.addChildAt(_loc8_,param4);
            }
            _resPlaceholderMap[_loc8_] = param1;
            if(!obf_a_D_3908)
            {
               obf_a_D_3908 = true;
               setInterval(obf_8_Y_830,800);
            }
         }
      }
      
      private static function obf_8_Y_830() : void
      {
         var rm:ResourceManager = null;
         var key:* = undefined;
         var placeholder:DisplayObject = null;
         var res:String = null;
         var obj:DisplayObject = null;
         var container:DisplayObjectContainer = null;
         var idx:int = 0;
         try
         {
            rm = ResourceManager.instance;
            for(key in _resPlaceholderMap)
            {
               try
               {
                  placeholder = key as DisplayObject;
                  if(placeholder == null)
                  {
                     delete _resPlaceholderMap[key];
                     continue;
                  }
                  res = _resPlaceholderMap[placeholder];
                  if(!rm.isResourceLoaded(obf_b_8_4256.getResIdToImport(res)))
                  {
                     continue;
                  }
                  obj = rm.getDisplayObject(res);
                  if(obj != null)
                  {
                     container = placeholder.parent;
                     if(container != null)
                     {
                        idx = container.getChildIndex(placeholder);
                        container.removeChildAt(idx);
                        container.addChildAt(obj,idx);
                     }
                     delete _resPlaceholderMap[key];
                  }
               }
               catch(e:Error)
               {
               }
            }
         }
         catch(err:Error)
         {
         }
      }
      
      public static function obf_q_h_1296(param1:String, param2:DisplayObjectContainer = null, param3:String = null, param4:Boolean = false, param5:int = 0, param6:int = 0, param7:Function = null) : DisplayObject
      {
         var resId:String;
         var obj:DisplayObject = null;
         var mc:obf_I_t_863 = null;
         var bag:ResourceBag = null;
         var res:String = param1;
         var container:DisplayObjectContainer = param2;
         var resBag:String = param3;
         var isRemover:Boolean = param4;
         var x:int = param5;
         var y:int = param6;
         var fun:Function = param7;
         ResourceManager.instance.obf_h_p_1259(res);
         resId = obf_b_8_4256.getResIdToImport(res);
         if(resId == null || !ResourceManager.instance.existsResource(resId))
         {
            trace(">>>> loadAndShowBitmapMovie() invalid res: " + res);
            return null;
         }
         if(ResourceManager.instance.isResourceLoaded(resId))
         {
            obj = ResourceManager.instance.getDisplayObject(res);
            if(obj != null)
            {
               if(!BitmapFrameInfo.isBeingBitmapFrameInfo(res))
               {
                  BitmapFrameInfo.storeBitmapFrameInfo(res,obf_0_9_X_707.obf_t_X_3506(obj,true,13421772));
               }
               mc = new obf_I_t_863(BitmapFrameInfo.getBitmapFrameInfo(res));
               mc.autoRemove = isRemover;
               mc.addEventListener(Event.COMPLETE,function():void
               {
                  if(fun != null)
                  {
                     fun.apply();
                  }
               });
               if(!container)
               {
                  return mc;
               }
               try
               {
                  container.addChild(mc);
                  mc.x = x;
                  mc.y = y;
               }
               catch(e:Error)
               {
               }
            }
         }
         else
         {
            if(container == null)
            {
               container = new Sprite();
            }
            if(obf_L_l_4100.isEmpty(resBag))
            {
               resBag = resId;
            }
            if(ResourceManager.instance.bagMap[resBag] != null)
            {
               bag = ResourceManager.instance.getBag(resBag);
            }
            else
            {
               bag = ResourceManager.instance.obf_d_q_1462(resBag);
            }
            bag.loader.addEventListener(obf_J_Y_3494.COMPLETE,function():void
            {
               var mcv:obf_I_t_863;
               var thisMC:DisplayObject = ResourceManager.instance.getDisplayObject(res);
               if(!BitmapFrameInfo.isBeingBitmapFrameInfo(res))
               {
                  BitmapFrameInfo.storeBitmapFrameInfo(res,obf_0_9_X_707.obf_t_X_3506(thisMC,true,13421772));
               }
               mcv = new obf_I_t_863(BitmapFrameInfo.getBitmapFrameInfo(res));
               mcv.autoRemove = isRemover;
               mcv.addEventListener(Event.COMPLETE,function():void
               {
                  if(fun != null)
                  {
                     fun.apply();
                  }
               });
               try
               {
                  container.addChild(mcv);
                  mcv.x = x;
                  mcv.y = y;
               }
               catch(e:Error)
               {
               }
            });
            bag.obf_z_U_2156(resId);
            bag.load();
         }
         return container;
      }
      
      public static function loadAndShowBitmap(param1:String, param2:DisplayObjectContainer, param3:String = null, param4:int = 0, param5:int = 0) : void
      {
         var resId:String;
         var obj:DisplayObject = null;
         var mc:obf_I_t_863 = null;
         var bag:ResourceBag = null;
         var res:String = param1;
         var container:DisplayObjectContainer = param2;
         var resBag:String = param3;
         var x:int = param4;
         var y:int = param5;
         ResourceManager.instance.obf_h_p_1259(res);
         resId = obf_b_8_4256.getResIdToImport(res);
         if(resId == null || !ResourceManager.instance.existsResource(resId))
         {
            trace(">>>> loadAndShowBitmap() invalid res: " + res);
            return;
         }
         if(ResourceManager.instance.isResourceLoaded(resId))
         {
            obj = ResourceManager.instance.getDisplayObject(res);
            if(obj != null)
            {
               if(!BitmapFrameInfo.isBeingBitmapFrameInfo(res))
               {
                  BitmapFrameInfo.storeBitmapInfo(res,obf_0_9_X_707.cacheBitmap(obj,true,13421772));
               }
               mc = new obf_I_t_863(BitmapFrameInfo.getBitmapFrameInfo(res));
               try
               {
                  container.addChild(mc);
                  mc.x = x;
                  mc.y = y;
               }
               catch(e:Error)
               {
               }
            }
         }
         else
         {
            if(obf_L_l_4100.isEmpty(resBag))
            {
               resBag = resId;
            }
            if(ResourceManager.instance.bagMap[resBag] != null)
            {
               bag = ResourceManager.instance.getBag(resBag);
            }
            else
            {
               bag = ResourceManager.instance.obf_d_q_1462(resBag);
            }
            bag.loader.addEventListener(obf_J_Y_3494.COMPLETE,function():void
            {
               var mc:obf_I_t_863;
               var thisMC:DisplayObject = ResourceManager.instance.getDisplayObject(res);
               if(!BitmapFrameInfo.isBeingBitmapFrameInfo(res))
               {
                  BitmapFrameInfo.storeBitmapInfo(res,obf_0_9_X_707.cacheBitmap(thisMC,true,13421772));
               }
               mc = new obf_I_t_863(BitmapFrameInfo.getBitmapFrameInfo(res));
               try
               {
                  container.addChild(mc);
                  mc.x = x;
                  mc.y = y;
               }
               catch(e:Error)
               {
               }
            });
            bag.obf_z_U_2156(resId);
            bag.load();
         }
      }
   }
}

