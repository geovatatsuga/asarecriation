package com.sunweb.game.rpg.glyph
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.worldZone.command.glyph.CommandCodePlayerGlyph;
   import com.sunweb.game.rpg.worldZone.command.glyph.GlyphInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.glyph.GlyphMasterAnswer;
   import com.sunweb.game.rpg.worldZone.command.glyph.GlyphMasterRequest;
   import com.sunweb.game.rpg.worldZone.command.glyph.GlyphUpAnswer;
   import com.sunweb.game.rpg.worldZone.command.glyph.GlyphUpMasterNotify;
   import com.sunweb.game.rpg.worldZone.command.glyph.GlyphUpRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_Q_J_3925
   {
      
      private static var glyphObject:Object;
      
      public static var obf_i_L_1797:Boolean = true;
      
      public static var masterOneTimes:Boolean = true;
      
      public static var masterTwoTimes:Boolean = true;
      
      public static var masterThreeTimes:Boolean = true;
      
      public function obf_Q_J_3925()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         glyphObject = param1;
      }
      
      public static function get glyphList() : Array
      {
         return JSONUtil.getObject(glyphObject,["glyphList"]) as Array;
      }
      
      public static function get glyphMasterList() : Array
      {
         return JSONUtil.getObject(glyphObject,["glyphMasterList"]) as Array;
      }
      
      public static function get oneMoney() : int
      {
         return JSONUtil.getInt(glyphObject,["oneMoney"]);
      }
      
      public static function get oneValue() : int
      {
         return JSONUtil.getInt(glyphObject,["oneValue"]);
      }
      
      public static function get oneByExp() : int
      {
         return JSONUtil.getInt(glyphObject,["oneByExp"]);
      }
      
      public static function getMasterLevel(param1:int) : Array
      {
         var _loc2_:Object = null;
         for each(_loc2_ in glyphMasterList)
         {
            if(JSONUtil.getInt(_loc2_,["kind"]) == param1)
            {
               return JSONUtil.getObject(_loc2_,["levelList"]) as Array;
            }
         }
         return null;
      }
      
      public static function getGlyphList(param1:int) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in glyphList)
         {
            if(JSONUtil.getInt(_loc2_,["kind"]) == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function sendGlyphUp(param1:int, param2:Array) : void
      {
         var _loc3_:GlyphUpRequest = new GlyphUpRequest();
         _loc3_.kind = param1;
         _loc3_.useKindList = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendInviteMaster(param1:int) : void
      {
         var _loc2_:GlyphMasterRequest = new GlyphMasterRequest();
         _loc2_.kind = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function obf_l_x_2668(param1:Boolean = false) : Boolean
      {
         var _loc2_:Object = JSONUtil.getObject(glyphObject,["openSystemCond"]);
         if(!ConditionScript.checkCondition(_loc2_,null,param1))
         {
            return false;
         }
         return true;
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerGlyph.GLYPH_INFO_NOTIFY)
         {
            obf_0_7_P_61(param1 as GlyphInfoNotify);
         }
         else if(param1.code == CommandCodePlayerGlyph.GLYPH_MASTER_ANSWER)
         {
            obf_V_Y_1263(param1 as GlyphMasterAnswer);
         }
         else if(param1.code == CommandCodePlayerGlyph.GLYPH_UP_ANSWER)
         {
            obf_M_u_1053(param1 as GlyphUpAnswer);
         }
         else if(param1.code == CommandCodePlayerGlyph.GLYPH_UP_MASTER_NOTIFY)
         {
            obf_O_w_1272(param1 as GlyphUpMasterNotify);
         }
      }
      
      private static function obf_0_7_P_61(param1:GlyphInfoNotify) : void
      {
         var _loc2_:GlyphMasterInfo = null;
         var _loc3_:GlyphInfo = null;
         for each(_loc2_ in param1.glyphMasterInfoList)
         {
            obf_K_e_3075.depictBoxUI.obf_F_w_4031(_loc2_.kind,_loc2_.level,_loc2_.untappedNum,_loc2_.alreadyNum);
         }
         for each(_loc3_ in param1.glyphInfoList)
         {
            obf_K_e_3075.roomBoxUI.obf_0_4_I_321(_loc3_.kind,_loc3_.level,_loc3_.value);
         }
      }
      
      private static function obf_V_Y_1263(param1:GlyphMasterAnswer) : void
      {
         obf_K_e_3075.depictBoxUI.obf_w_G_1173(param1.kind,param1.untappedNum);
      }
      
      private static function obf_M_u_1053(param1:GlyphUpAnswer) : void
      {
         obf_K_e_3075.depictBoxUI.setCurrDepictGlyph(param1.glyphInfo.kind,param1.glyphInfo.level,param1.glyphInfo.value);
         obf_K_e_3075.roomBoxUI.obf_0_4_I_321(param1.glyphInfo.kind,param1.glyphInfo.level,param1.glyphInfo.value);
      }
      
      private static function obf_O_w_1272(param1:GlyphUpMasterNotify) : void
      {
         var _loc2_:GlyphMasterInfo = null;
         for each(_loc2_ in param1.masterInfoList)
         {
            obf_K_e_3075.depictBoxUI.obf_F_w_4031(_loc2_.kind,_loc2_.level,_loc2_.untappedNum,_loc2_.alreadyNum);
         }
      }
   }
}

