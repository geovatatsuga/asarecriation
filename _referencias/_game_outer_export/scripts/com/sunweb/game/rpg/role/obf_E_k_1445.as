package com.sunweb.game.rpg.role
{
   public class obf_E_k_1445
   {
      
      private static var obf_d_K_1799:Object;
      
      public static const WEAPON:String = "weapon";
      
      public static const SHIELD:String = "shield";
      
      public static const CLOTHES:String = "clothes";
      
      public static const HAT:String = "hat";
      
      public static const WING:String = "wing";
      
      public static const HAIR:String = "hair";
      
      public static const FACE:String = "face";
      
      public static const obf_F_d_3398:int = 0;
      
      public static const ID_SHIELD:int = 1;
      
      public static const ID_CLOTHES:int = 2;
      
      public static const obf_p_v_1281:int = 3;
      
      public static const ID_WING:int = 4;
      
      public static const obf_4_t_4563:int = 5;
      
      public static const obf_0_8_t_215:int = 6;
      
      private static var _toName:Array = ["weapon","shield","clothes","hat","wing","hair","face"];
      
      private static var obf_x_F_2319:Object = {
         "weapon":0,
         "shield":1,
         "clothes":2,
         "hat":3,
         "wing":4,
         "hair":5,
         "face":6
      };
      
      public function obf_E_k_1445()
      {
         super();
      }
      
      public static function getEquipmentIdByName(param1:String) : int
      {
         return obf_x_F_2319[param1];
      }
      
      public static function getEquipmentNameById(param1:int) : String
      {
         return _toName[param1];
      }
      
      public static function set equipmentModelMap(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         obf_d_K_1799 = new Object();
         for(_loc2_ in param1)
         {
            _loc3_ = param1[_loc2_];
            _loc4_ = new Object();
            for each(_loc5_ in _loc3_)
            {
               _loc4_[_loc5_.code] = _loc5_;
            }
            obf_d_K_1799[_loc2_] = _loc4_;
         }
      }
      
      public static function get equipmentModelMap() : Object
      {
         return obf_d_K_1799;
      }
      
      public static function getEquipmentModel(param1:String, param2:String) : Object
      {
         var model:Object = null;
         var equipmentKind:String = param1;
         var equipmentCode:String = param2;
         try
         {
            model = obf_d_K_1799[equipmentKind][equipmentCode];
         }
         catch(e:Error)
         {
         }
         return model;
      }
      
      public static function getEquipmentImagesForPlayerModel(param1:String, param2:String, param3:String) : Object
      {
         var images:Object = null;
         var equipmentKind:String = param1;
         var equipmentCode:String = param2;
         var playerModelCode:String = param3;
         try
         {
            images = obf_d_K_1799[equipmentKind][equipmentCode].images[playerModelCode];
         }
         catch(e:Error)
         {
         }
         return images;
      }
      
      public static function getEquipmentModelKind(param1:String) : String
      {
         var _loc2_:String = null;
         for(_loc2_ in obf_d_K_1799)
         {
            if(getEquipmentModel(_loc2_,param1) != null)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

