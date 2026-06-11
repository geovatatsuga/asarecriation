package com.sunweb.game.net.framework.codec.diy
{
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class obf_z_v_3729
   {
      
      private static var obf_G_c_2426:Object = new Object();
      
      private static var obf_g_E_1086:Object = new Object();
      
      private static var obf_C_Q_1888:Object = new Object();
      
      public function obf_z_v_3729()
      {
         super();
      }
      
      public static function getParsedFieldList(param1:obf_2_M_853) : Array
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc2_:String = getQualifiedClassName(param1);
         var _loc3_:Array = obf_G_c_2426[_loc2_];
         if(_loc3_ == null)
         {
            _loc3_ = new Array();
            obf_G_c_2426[_loc2_] = _loc3_;
            _loc4_ = param1.getFieldList();
            for each(_loc5_ in _loc4_)
            {
               _loc3_.push(new obf_0_7_I_681(_loc5_));
            }
         }
         return _loc3_;
      }
      
      public static function newTransportableObject(param1:String) : obf_U_l_3209
      {
         var cr:Class = null;
         var className:String = param1;
         try
         {
            cr = obf_g_E_1086[className];
            if(cr == null)
            {
               cr = getDefinitionByName(className) as Class;
               obf_g_E_1086[className] = cr;
            }
            return new cr() as obf_U_l_3209;
         }
         catch(e:Error)
         {
            trace("newObject() failed: " + className);
         }
         return null;
      }
      
      public static function isTransportableClass(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         if(obf_C_Q_1888.hasOwnProperty(param1))
         {
            return obf_C_Q_1888[param1];
         }
         _loc2_ = newTransportableObject(param1) != null;
         obf_C_Q_1888[param1] = _loc2_;
         return _loc2_;
      }
   }
}

