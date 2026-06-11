package com.sunweb.game.rpg.role
{
   import com.sunweb.game.res.obf_b_8_4256;
   
   public class RoleModel
   {
      
      private static var _monsterModelList:Array;
      
      private static var obf_E_X_1409:Object;
      
      private static var _playerModelList:Array;
      
      private static var obf_d_u_3234:Object;
      
      public function RoleModel()
      {
         super();
      }
      
      public static function set monsterModelList(param1:Array) : void
      {
         var _loc2_:Object = null;
         _monsterModelList = param1;
         obf_E_X_1409 = new Object();
         for each(_loc2_ in param1)
         {
            obf_E_X_1409[_loc2_.code] = _loc2_;
         }
      }
      
      public static function get monsterModelList() : Array
      {
         return _monsterModelList;
      }
      
      public static function getMonsterModel(param1:String) : Object
      {
         return obf_E_X_1409[param1];
      }
      
      public static function getMonsterModelResId(param1:String) : String
      {
         var modelCode:String = param1;
         var info:Object = getMonsterModel(modelCode);
         if(info == null)
         {
            return null;
         }
         try
         {
            return obf_b_8_4256.getResIdToImport(info.actions[0].res);
         }
         catch(e:Error)
         {
         }
         return null;
      }
      
      public static function set playerModelList(param1:Array) : void
      {
         var _loc2_:Object = null;
         _playerModelList = param1;
         obf_d_u_3234 = new Object();
         for each(_loc2_ in param1)
         {
            obf_d_u_3234[_loc2_.code + _loc2_.sex] = _loc2_;
         }
      }
      
      public static function get playerModelList() : Array
      {
         return _playerModelList;
      }
      
      public static function getPlayerModel(param1:String) : Object
      {
         return obf_d_u_3234[param1];
      }
   }
}

