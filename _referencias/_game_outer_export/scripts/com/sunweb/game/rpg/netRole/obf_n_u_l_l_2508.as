package com.sunweb.game.rpg.netRole
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class obf_n_u_l_l_2508
   {
      
      private static var titleMap:Object;
      
      private static var titleType:Array;
      
      public function obf_n_u_l_l_2508()
      {
         super();
      }
      
      public static function init() : void
      {
         var _loc2_:Object = null;
         titleMap = new Object();
         titleType = new Array();
         var _loc1_:Array = WorldConfig.getValue("titleConfig","titleList") as Array;
         for each(_loc2_ in _loc1_)
         {
            titleMap[_loc2_.titleIndex] = _loc2_;
            if(!obf_L_l_4100.isEmpty(_loc2_.titleKind) && titleType.indexOf(_loc2_.titleKind) <= -1)
            {
               titleType.push(_loc2_.titleKind);
            }
         }
         titleType.sort();
      }
      
      public static function getTitleType() : Array
      {
         return titleType.concat();
      }
      
      public static function getPlayerTitlesByType(param1:String) : Array
      {
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         var _loc2_:Array = new Array();
         for each(_loc3_ in titleMap)
         {
            if(JSONUtil.getStr(_loc3_,["titleKind"]) == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         if(obf_L_l_4100.isEmpty(param1))
         {
            for each(_loc4_ in obf_x_z_2648.systemTitleList)
            {
               _loc2_.push({
                  "titleIndex":_loc4_,
                  "titleName":DiversityManager.getString("PlayerTitle",_loc4_ + "")
               });
            }
         }
         return _loc2_;
      }
      
      public static function getPlayerTitleName(param1:int) : String
      {
         if(obf_x_z_2648.systemTitleList.indexOf(param1) > -1)
         {
            return DiversityManager.getString("PlayerTitle",param1 + "");
         }
         return JSONUtil.getStr(titleMap,[param1,"titleName"]);
      }
      
      public static function getPlayerTitle(param1:int, param2:obf_Y_E_3667) : String
      {
         if(param1 < 1)
         {
            return "";
         }
         if(param1 < 100)
         {
            if(param2 is obf_U_6_3454)
            {
               if(param1 == obf_x_z_2648.obf_0_1_h_214 && Boolean((param2 as obf_U_6_3454).familyMyInfo))
               {
                  return (param2 as obf_U_6_3454).familyName + " " + (param2 as obf_U_6_3454).familyMyInfo.postName;
               }
            }
            else if(param2 is RemotePlayer)
            {
               if(param1 == obf_x_z_2648.obf_0_1_h_214)
               {
                  return (param2 as RemotePlayer).familyName + " " + (param2 as RemotePlayer).obf_I_0_1698.postName;
               }
            }
         }
         var _loc3_:String = JSONUtil.getStr(titleMap,[param1,"titleHtml"]);
         if(!obf_L_l_4100.isEmpty(_loc3_))
         {
            return _loc3_;
         }
         return JSONUtil.getStr(titleMap,[param1,"titleName"]);
      }
      
      public static function getTitleConfig(param1:int) : Object
      {
         return JSONUtil.getObject(titleMap,[param1]);
      }
      
      public static function getPlayerHasTitlesByType(param1:String) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc2_:Array = new Array();
         if(JSONUtil.getObject(GameContext.localPlayer,["playerTitleList"]))
         {
            for each(_loc3_ in GameContext.localPlayer.playerTitleList)
            {
               _loc4_ = getTitleConfig(_loc3_);
               if((Boolean(_loc4_)) && JSONUtil.getStr(_loc4_,["titleKind"]) == param1)
               {
                  _loc2_.push(_loc4_);
               }
            }
         }
         if(obf_L_l_4100.isEmpty(param1))
         {
            for each(_loc5_ in obf_x_z_2648.systemTitleList)
            {
               _loc2_.push({
                  "titleIndex":_loc5_,
                  "titleName":DiversityManager.getString("PlayerTitle",_loc5_ + "")
               });
            }
         }
         return _loc2_;
      }
   }
}

