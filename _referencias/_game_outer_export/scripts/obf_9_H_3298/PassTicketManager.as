package obf_9_H_3298
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.passTicket.CommandCodePassTicket;
   import com.sunweb.game.rpg.worldZone.command.passTicket.PassTicketAwardInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.passTicket.PassTicketAwardRequest;
   import com.sunweb.game.rpg.worldZone.command.passTicket.PassTicketBuyRequest;
   import com.sunweb.game.rpg.worldZone.command.passTicket.PassTicketFinishTaskRequest;
   import com.sunweb.game.rpg.worldZone.command.passTicket.PassTicketInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.passTicket.PassTicketSysInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.passTicket.PassTicketTaskNotify;
   import com.sunweb.game.utils.JSONUtil;
   
   public class PassTicketManager
   {
      
      private static var config:Object;
      
      public function PassTicketManager()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         config = param1;
      }
      
      public static function get openCon() : Object
      {
         return JSONUtil.getObject(config,["openCondition"]);
      }
      
      public static function get passLevels() : Array
      {
         return JSONUtil.getValue(config,["passLevels"]) as Array;
      }
      
      public static function getExpByLv(param1:int) : int
      {
         if(param1 >= passLevels.length)
         {
            return 0;
         }
         return passLevels[param1];
      }
      
      public static function getCycle(param1:String) : Object
      {
         var _loc4_:Object = null;
         var _loc2_:Array = JSONUtil.getValue(config,["cycle"]) as Array;
         if(!_loc2_)
         {
            return null;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            if(_loc4_.code == param1)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public static function get varShopId() : String
      {
         return JSONUtil.getStr(config,["varShopId"]);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePassTicket.PASS_TICKET_INFO_NOTIFY)
         {
            obf_0_5_F_661(param1 as PassTicketInfoNotify);
         }
         else if(param1.code == CommandCodePassTicket.PASS_TICKET_TASK_NOTIFY)
         {
            obf_A_F_4472(param1 as PassTicketTaskNotify);
         }
         else if(param1.code == CommandCodePassTicket.PASS_TICKET_AWARD_INFO_NOTIFY)
         {
            obf_1_T_2921(param1 as PassTicketAwardInfoNotify);
         }
         else if(param1.code == CommandCodePassTicket.PASS_TICKET_SYS_INFO_NOTIFY)
         {
            obf_7_F_2805(param1 as PassTicketSysInfoNotify);
         }
      }
      
      public static function obf_0_5_F_661(param1:PassTicketInfoNotify) : void
      {
         obf_K_e_3075.passTicketUI.level = param1.level;
         obf_K_e_3075.passTicketUI.exp = param1.exp;
         obf_K_e_3075.passTicketUI.updateLvExp();
      }
      
      public static function obf_A_F_4472(param1:PassTicketTaskNotify) : void
      {
         if(param1.isOk)
         {
            obf_K_e_3075.passTicketUI.taskIds = param1.taskIds;
            obf_K_e_3075.passTicketUI.refreshTaskUI(1);
         }
         else
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("passTicketUI","cannotFinish"));
         }
      }
      
      public static function obf_1_T_2921(param1:PassTicketAwardInfoNotify) : void
      {
         obf_K_e_3075.passTicketUI.isMiddBuy = param1.hasMidd;
         obf_K_e_3075.passTicketUI.isHighBuy = param1.hasHigh;
         obf_K_e_3075.passTicketUI.freeLv = param1.awardFree;
         obf_K_e_3075.passTicketUI.middLv = param1.awardMidd;
         obf_K_e_3075.passTicketUI.highLv = param1.awardHigh;
         var _loc2_:int = obf_K_e_3075.passTicketUI.getAwardPage();
         obf_K_e_3075.passTicketUI.obf_9_Q_961(_loc2_);
      }
      
      public static function obf_7_F_2805(param1:PassTicketSysInfoNotify) : void
      {
         obf_K_e_3075.passTicketUI.cycleCode = param1.passTicketCode;
         obf_K_e_3075.passTicketUI.leaveDay = param1.leaveDay;
         obf_K_e_3075.passTicketUI.updateDay();
      }
      
      public static function sendPassTicketFinishTaskRequest(param1:int) : void
      {
         var _loc2_:PassTicketFinishTaskRequest = new PassTicketFinishTaskRequest();
         _loc2_.taskId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendPassTicketBuyRequest(param1:int) : void
      {
         var _loc2_:PassTicketBuyRequest = new PassTicketBuyRequest();
         _loc2_.type = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendPassTicketAwardRequest() : void
      {
         var _loc1_:PassTicketAwardRequest = new PassTicketAwardRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
   }
}

