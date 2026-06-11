package obf_H_I_939
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.makeChip.BreakChipAnswer;
   import com.sunweb.game.rpg.worldZone.command.makeChip.BreakChipRequest;
   import com.sunweb.game.rpg.worldZone.command.makeChip.CommandCodeMakeChip;
   import com.sunweb.game.rpg.worldZone.command.makeChip.FreeGetBadKeyAnswer;
   import com.sunweb.game.rpg.worldZone.command.makeChip.FreeGetBadKeyRequest;
   import com.sunweb.game.rpg.worldZone.command.makeChip.MakeChipAnswer;
   import com.sunweb.game.rpg.worldZone.command.makeChip.MakeChipInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.makeChip.MakeChipRequest;
   import com.sunweb.game.rpg.worldZone.command.makeChip.MakeKeyAnswer;
   import com.sunweb.game.rpg.worldZone.command.makeChip.MakeKeyRequest;
   import com.sunweb.game.rpg.worldZone.command.makeChip.OpenBoxAnswer;
   import com.sunweb.game.rpg.worldZone.command.makeChip.OpenBoxRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_u_Z_4014
   {
      
      public static var makeChipConf:Object;
      
      private static var openBoxType:int;
      
      private static var openBoxId:String;
      
      public function obf_u_Z_4014()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         makeChipConf = param1;
      }
      
      public static function get makeChipOpenCond() : Object
      {
         return JSONUtil.getObject(makeChipConf,["openCon"]);
      }
      
      public static function get makeChipGetBadKeyToDay() : int
      {
         return JSONUtil.getInt(makeChipConf,["badKeyToDay"]);
      }
      
      public static function get makeChipBox() : Array
      {
         return JSONUtil.getObject(makeChipConf,["box"]) as Array;
      }
      
      public static function get makeChipKeys() : Array
      {
         return JSONUtil.getObject(makeChipConf,["keys"]) as Array;
      }
      
      public static function get makeChipBadKeys() : Array
      {
         return JSONUtil.getObject(makeChipConf,["badKeys"]) as Array;
      }
      
      public static function get makeChipSupers() : Array
      {
         return JSONUtil.getObject(makeChipConf,["supers"]) as Array;
      }
      
      public static function get makeChipChips() : Array
      {
         return JSONUtil.getObject(makeChipConf,["chips"]) as Array;
      }
      
      public static function get makeChipMakeChipConfig() : Array
      {
         return JSONUtil.getObject(makeChipConf,["makeChipConfig"]) as Array;
      }
      
      private static function get openBoxTips() : String
      {
         var _loc1_:Array = makeChipBox;
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            if(openBoxId == _loc1_[_loc3_].id)
            {
               _loc2_ = DiversityManager.getString("MakeChipUI","openBox_" + _loc3_ + openBoxType);
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function sendFreeGetBadKeyReq() : void
      {
         var _loc1_:FreeGetBadKeyRequest = new FreeGetBadKeyRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendMakeKeyReq(param1:int, param2:String) : void
      {
         var _loc3_:MakeKeyRequest = new MakeKeyRequest();
         _loc3_.type = param1;
         _loc3_.keyId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendOpenBoxReq(param1:int, param2:String) : void
      {
         openBoxId = param2;
         openBoxType = param1;
         var _loc3_:OpenBoxRequest = new OpenBoxRequest();
         _loc3_.type = param1;
         _loc3_.boxId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendBreakChipReq(param1:Object) : void
      {
         var _loc2_:BreakChipRequest = new BreakChipRequest();
         _loc2_.chips = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendMakeChipReq(param1:String) : void
      {
         var _loc2_:MakeChipRequest = new MakeChipRequest();
         _loc2_.makeChipId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeMakeChip.MAKE_KEY_ANSWER)
         {
            obf_0_2_A_360(param1 as MakeKeyAnswer);
         }
         else if(param1.code == CommandCodeMakeChip.OPEN_BOX_ANSWER)
         {
            obf_i_M_1616(param1 as OpenBoxAnswer);
         }
         else if(param1.code == CommandCodeMakeChip.BREAK_CHIP_ANSWER)
         {
            obf_1_i_2256(param1 as BreakChipAnswer);
         }
         else if(param1.code == CommandCodeMakeChip.MAKE_CHIP_ANSWER)
         {
            obf_m_W_893(param1 as MakeChipAnswer);
         }
         else if(param1.code == CommandCodeMakeChip.MAKE_CHIP_INFO_NOTIFY)
         {
            obf_L_m_3250(param1 as MakeChipInfoNotify);
         }
         else if(param1.code == CommandCodeMakeChip.FREE_GET_BAD_KEY_ANSWER)
         {
            obf_X_r_1186(param1 as FreeGetBadKeyAnswer);
         }
      }
      
      private static function obf_0_2_A_360(param1:MakeKeyAnswer) : void
      {
         obf_K_e_3075.makeChipUI.obf_2_i_2654(param1.chipBadKeys);
         obf_K_e_3075.makeChipUI.obf_0_E_2196(param1.chipKeys);
      }
      
      private static function obf_i_M_1616(param1:OpenBoxAnswer) : void
      {
         obf_K_e_3075.makeChipUI.obf_M_2_2679(param1.chipBoxs);
         obf_K_e_3075.makeChipUI.obf_0_E_2196(param1.chipKeys);
         obf_K_e_3075.makeChipUI.chipsInfo(param1.chips);
         obf_K_e_3075.makeChipUI.obf_x_8_3005(param1.chipSupers);
         obf_K_e_3075.makeChipUI.showOpenEffect();
         obf_K_e_3075.showCenterInfo(openBoxTips);
         obf_6_D_3816.print(openBoxTips);
      }
      
      private static function obf_1_i_2256(param1:BreakChipAnswer) : void
      {
         obf_K_e_3075.makeChipUI.chipsInfo(param1.chips);
         obf_K_e_3075.makeChipUI.obf_x_8_3005(param1.chipSupers);
         obf_K_e_3075.makeChipUI.showSubIncons(obf_K_e_3075.makeChipUI.clickSunIndex);
      }
      
      private static function obf_m_W_893(param1:MakeChipAnswer) : void
      {
         obf_K_e_3075.makeChipUI.chipsInfo(param1.chips);
         obf_K_e_3075.makeChipUI.obf_x_8_3005(param1.chipSupers);
         obf_K_e_3075.makeChipUI.obf_E_i_2949(param1.chipAttrs);
         obf_K_e_3075.makeChipUI.showSubIncons(obf_K_e_3075.makeChipUI.clickSunIndex);
      }
      
      private static function obf_L_m_3250(param1:MakeChipInfoNotify) : void
      {
         obf_K_e_3075.makeChipUI.obf_M_2_2679(param1.chipBoxs);
         obf_K_e_3075.makeChipUI.obf_2_i_2654(param1.chipBadKeys);
         obf_K_e_3075.makeChipUI.obf_0_E_2196(param1.chipKeys);
         obf_K_e_3075.makeChipUI.chipsInfo(param1.chips);
         obf_K_e_3075.makeChipUI.obf_x_8_3005(param1.chipSupers);
         obf_K_e_3075.makeChipUI.obf_E_i_2949(param1.chipAttrs);
      }
      
      private static function obf_X_r_1186(param1:FreeGetBadKeyAnswer) : void
      {
         obf_K_e_3075.showCenterInfo(DiversityManager.getString("MakeChipBoxUI","warn_MakeChipBoxUI"));
      }
   }
}

