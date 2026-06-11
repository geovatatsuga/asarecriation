package com.sunweb.game.rpg.playerUI.managers
{
   import obf_a_F_1055.obf_b_p_3604;
   import obf_g_A_3629.ChatDecoder;
   import obf_g_A_3629.obf_g_u_3212;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.clientAction.obf_F_2_2975;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.gameItem.GameItemRank;
   import com.sunweb.game.rpg.gameItem.GameItemType;
   import com.sunweb.game.rpg.netRole.obf_U_6_3454;
   import com.sunweb.game.rpg.playerUI.pet.obf_L_F_3928;
   import com.sunweb.game.rpg.script.obf_c_w_2239;
   import com.sunweb.game.rpg.world.MonsterInfoUtil;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.ui.obf_X_Z_4427;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.geom.Point;
   
   public class obf_7_6_4416
   {
      
      public function obf_7_6_4416()
      {
         super();
      }
      
      public static function getItemLink(param1:String, param2:String) : String
      {
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(_loc3_)
         {
            return obf_g_u_3212.getFinallyLinkCode(obf_g_u_3212.getItemLinkCode(_loc3_.name,param1,param2));
         }
         return "[" + DiversityManager.getString("CommonPrompt","unknow") + "]";
      }
      
      public static function getItemLinkA(param1:String, param2:String) : String
      {
         return ChatDecoder.decode(getItemLink(param1,param2));
      }
      
      public static function getItemAtPlaceLinkA(param1:String) : String
      {
         var _loc2_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc2_)
         {
            return param1;
         }
         if(!obf_L_l_4100.isEmpty(_loc2_.atPlace) && !obf_L_l_4100.isEmpty(_loc2_.atActionMacro))
         {
            return getActionMacroLinkA(_loc2_.name,"MoveToDo " + _loc2_.atPlace + " " + _loc2_.atActionMacro);
         }
         if(!obf_L_l_4100.isEmpty(_loc2_.atPlace))
         {
            return getActionMacroLinkA(_loc2_.name,"MoveTo " + _loc2_.atPlace);
         }
         return getItemLinkA(param1,"");
      }
      
      public static function getMapLinkA(param1:String, param2:String, param3:int, param4:int) : String
      {
         return ChatDecoder.decode(obf_g_u_3212.getMapLinkCode(param1,param2,param3,param4));
      }
      
      public static function getFarmLinkA(param1:String, param2:String, param3:String) : String
      {
         return ChatDecoder.decode(obf_g_u_3212.getFarmLinkCode(param1,param2,param3));
      }
      
      public static function getNpcLinkA(param1:String, param2:String, param3:String) : String
      {
         return ChatDecoder.decode(obf_g_u_3212.getNpcLinkCode(param1,param2,param3));
      }
      
      public static function getNpcLinkAByFullId(param1:String) : String
      {
         var _loc2_:Array = param1.split("@");
         var _loc3_:String = JSONUtil.getStr(_loc2_,[1]);
         var _loc4_:String = JSONUtil.getStr(_loc2_,[0]);
         return ChatDecoder.decode(obf_g_u_3212.getNpcLinkCode(obf_b_p_3604.getNpcFullBriefName(param1),_loc3_,_loc4_));
      }
      
      public static function getRoleLinkA(param1:String) : String
      {
         return ChatDecoder.decode(obf_g_u_3212.getRoleLinkCode(param1));
      }
      
      public static function getMonsterLinkA(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc2_:Object = MonsterInfoUtil.getMonsterInfo(param1);
         if(!_loc2_)
         {
            return param1;
         }
         if(!obf_L_l_4100.isEmpty(_loc2_.atPlace))
         {
            _loc3_ = "attack";
            if(!WorldConfig.getValue("functionSwitch","autoTask"))
            {
               _loc3_ = "startBot";
            }
            return getActionMacroLinkA(_loc2_.name,"MoveToDo " + _loc2_.atPlace + " " + _loc3_ + " " + param1);
         }
         return JSONUtil.getStr(_loc2_,["name"]);
      }
      
      public static function getVarLinkA(param1:String) : String
      {
         var _loc2_:String = obf_c_w_2239.getVarAtPlace(param1);
         if(obf_L_l_4100.isEmpty(_loc2_))
         {
            return DiversityManager.getString("Vars",param1);
         }
         return ChatDecoder.decode(_loc2_,DiversityManager.getString("Vars",param1));
      }
      
      public static function getActionMacroLinkA(param1:String, param2:String) : String
      {
         return ChatDecoder.decode(obf_g_u_3212.getMacroLinkCode(param1,param2));
      }
      
      public static function getItemLinkObject(param1:String, param2:String) : Object
      {
         var _loc4_:Object = null;
         var _loc3_:Object = GameItemManager.getItemConfig(param1);
         if(_loc3_)
         {
            _loc4_ = new Object();
            _loc4_.name = _loc3_.name;
            _loc4_.color = GameItemRank.getRankColor(_loc3_.rank).toString(16);
            _loc4_.atPlace = _loc3_.atPlace;
            return _loc4_;
         }
         return null;
      }
      
      public static function getNpcLinkName(param1:String) : String
      {
         return JSONUtil.getStr(obf_b_p_3604.getNpcBrief(param1),["name"]);
      }
      
      public static function getMonsterLinkName(param1:String) : Object
      {
         var _loc3_:Object = null;
         var _loc2_:Object = MonsterInfoUtil.getMonsterInfo(param1);
         if(_loc2_)
         {
            _loc3_ = new Object();
            _loc3_.name = _loc2_.name;
            _loc3_.color = obf_0_3_0_538.obf_2_x_1573.toString(16);
            _loc3_.atPlace = _loc2_.atPlace;
            return _loc3_;
         }
         return null;
      }
      
      public static function getRoleLinkColor(param1:String) : String
      {
         return obf_0_3_0_538.obf_E_Q_3326.toString(16);
      }
      
      public static function obf_2_F_3313(param1:String) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         if(!GameContext.localPlayer)
         {
            return;
         }
         var _loc2_:Array = param1.split("^");
         if(_loc2_[0] == ChatDecoder.obf_W_v_983)
         {
            obf_X_Z_4427.showRoleMenu(_loc2_[1],new Point(GameContext.gameStage.mouseX,GameContext.gameStage.mouseY));
         }
         else if(_loc2_[0] == ChatDecoder.obf_d_Y_2785)
         {
            GameItemManager.showItemTipInfo(_loc2_[1],_loc2_[2] || "");
            _loc3_ = GameItemManager.getItemConfig(_loc2_[1]);
            if(_loc3_.type == GameItemType.PET && !obf_L_l_4100.isEmpty(_loc2_[2]))
            {
               obf_K_e_3075.showUI(new obf_L_F_3928(_loc2_[1],_loc2_[2]));
            }
         }
         else if(_loc2_[0] == ChatDecoder.MAP)
         {
            obf_F_2_2975.obf_O_p_3236("moveto " + _loc2_[1]);
            GameContext.localPlayer.obf_5_N_2570();
         }
         else if(_loc2_[0] == ChatDecoder.FARM)
         {
            obf_X_Z_4427.showFarmMenu(_loc2_[1]);
         }
         else if(_loc2_[0] == ChatDecoder.NPC)
         {
            _loc4_ = _loc2_[1].split("@");
            if(_loc4_.length < 2)
            {
               return;
            }
            GameContext.localPlayer.obf_0_8_r_450(_loc4_[1],obf_U_6_3454.obf_H_n_3781,_loc4_[0]);
            GameContext.localPlayer.obf_5_N_2570();
         }
         else if(_loc2_[0] == ChatDecoder.obf_E_4_4245)
         {
            obf_F_2_2975.obf_O_p_3236(_loc2_[1]);
         }
      }
   }
}

