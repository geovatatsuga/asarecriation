package com.sunweb.game.rpg.playerBook
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.skill.PlayerSkillManager;
   import com.sunweb.game.rpg.worldZone.command.playerBook.CommandCodePlayerBook;
   import com.sunweb.game.rpg.worldZone.command.playerBook.PlayerBookInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.playerBook.PlayerBookTimePointNotify;
   import com.sunweb.game.rpg.worldZone.command.playerBook.PlayerBookUpAnswer;
   import com.sunweb.game.rpg.worldZone.command.playerBook.PlayerBookUpRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_E_1429
   {
      
      public static var _bookConfig:Object;
      
      private static var obf_d_d_4263:Object;
      
      public function obf_E_1429()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         _bookConfig = new Object();
         _bookConfig = param1;
      }
      
      public static function get obf_3_j_4189() : Object
      {
         return JSONUtil.getObject(_bookConfig,["openConditon"]);
      }
      
      public static function get bookConfig() : Array
      {
         return JSONUtil.getValue(_bookConfig,["bookConfig"]) as Array;
      }
      
      public static function get obf_I_s_4561() : int
      {
         return JSONUtil.getInt(_bookConfig,["timePoints"]);
      }
      
      public static function get obf_0_6_0_516() : Array
      {
         return JSONUtil.getValue(_bookConfig,["addExps"]) as Array;
      }
      
      public static function get bookSkillCodes() : Object
      {
         return JSONUtil.getObject(_bookConfig,["skillCodes"]);
      }
      
      public static function get obf_0_9_E_277() : String
      {
         return JSONUtil.getStr(_bookConfig,["timeTips"]);
      }
      
      public static function getBookSkillLevel(param1:String) : int
      {
         return JSONUtil.getInt(obf_d_d_4263,[param1]);
      }
      
      public static function sendPlayerBookUpReq() : void
      {
         var _loc1_:PlayerBookUpRequest = new PlayerBookUpRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerBook.PLAYER_BOOK_INFO_NOTIFY)
         {
            obf_6_f_1477(param1 as PlayerBookInfoNotify);
         }
         else if(param1.code == CommandCodePlayerBook.PLAYER_BOOK_UP_ANSWER)
         {
            obf_R_G_4316(param1 as PlayerBookUpAnswer);
         }
         else if(param1.code == CommandCodePlayerBook.PLAYER_BOOK_TIME_POINT_NOTIFY)
         {
            obf_0_8_u_627(param1 as PlayerBookTimePointNotify);
         }
      }
      
      private static function obf_6_f_1477(param1:PlayerBookInfoNotify) : void
      {
         var _loc2_:String = null;
         obf_K_e_3075.playerBookUI.getBookLevel(param1.bookLevel);
         obf_K_e_3075.playerBookUI.getBookExp(param1.bookExp);
         obf_K_e_3075.playerBookUI.getBookTimePoint(param1.bookTimePoint);
         obf_K_e_3075.playerBookUI.getBookSkillMap(param1.bookSkillMap);
         obf_d_d_4263 = param1.bookSkillMap;
         for(_loc2_ in param1.bookSkillMap)
         {
            PlayerSkillManager.setHaveSkill(_loc2_,param1.bookSkillMap[_loc2_]);
         }
         obf_K_e_3075.playerBookUI.obf_0___f_619();
         obf_K_e_3075.playerBookUI.showPlayerBookInfo();
      }
      
      private static function obf_R_G_4316(param1:PlayerBookUpAnswer) : void
      {
         obf_K_e_3075.playerBookUI.getBookExp(param1.bookExp);
         obf_K_e_3075.playerBookUI.getBookTimePoint(param1.bookTimePoint);
         obf_K_e_3075.playerBookUI.showPlayerBookInfo();
      }
      
      private static function obf_0_8_u_627(param1:PlayerBookTimePointNotify) : void
      {
         obf_K_e_3075.playerBookUI.getBookTimePoint(param1.bookTimePoint);
         obf_K_e_3075.playerBookUI.showPlayerBookInfo();
      }
   }
}

