package obf_0_3_h_199
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_7_6_4416;
   import com.sunweb.game.rpg.worldZone.command.map.clear.MapClearInfoCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.map.clear.MapClearResultInfo;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_l_y_733;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.getTimer;
   import playerUI.PassBoxUIMC;
   
   public class PassBoxUI extends PassBoxUIMC implements IPlayerUI
   {
      
      private var _mapId:String;
      
      private var _clearRule:Object;
      
      private var timeInv:TimeLimiter = new TimeLimiter(500);
      
      private var playerTimeInv:TimeLimiter = new TimeLimiter(200);
      
      public function PassBoxUI()
      {
         super();
         this.initDiversity();
         this.onResize(null);
         this.visible = false;
         this.addListener();
      }
      
      private function addListener() : void
      {
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         obf_m_a_1577.txtName.addEventListener(TextEvent.LINK,this.onClickLink);
         titleBox.addEventListener(MouseEvent.CLICK,this.obf_l_L_1003);
      }
      
      private function removeListener() : void
      {
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         obf_m_a_1577.txtName.removeEventListener(TextEvent.LINK,this.onClickLink);
         titleBox.removeEventListener(MouseEvent.CLICK,this.obf_l_L_1003);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth - 350;
         this.y = 150;
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         this.obf_l_L_1003(null);
      }
      
      private function obf_l_L_1003(param1:MouseEvent) : void
      {
         obf_m_a_1577.visible = !obf_m_a_1577.visible;
         bg.visible = !bg.visible;
         cmdClose.visible = !cmdClose.visible;
      }
      
      private function onClickLink(param1:TextEvent) : void
      {
         obf_7_6_4416.obf_2_F_3313(param1.text);
      }
      
      private function obf_0_7_H_192(param1:Event) : void
      {
         if(this.playerTimeInv.checkTimeout())
         {
            obf_m_a_1577.txtTime.text = obf_l_y_733.getTimeStringHHMMSS(this.playerTimeInv.totalTimeInMS);
            txtTimer.text = obf_m_a_1577.txtTime.text;
         }
         if(this.timeInv.checkTimeout())
         {
            this.refreshTask();
         }
      }
      
      public function refreshTask() : void
      {
         if(GameContext.currentMap)
         {
            obf_m_a_1577.txtMon.htmlText = DiversityManager.getString("passBoxUI","txtConMonster",[GameContext.currentMap.monsterSet.size]);
         }
      }
      
      public function obf_s_D_1287(param1:MapClearInfoCheckNotify) : void
      {
         var _loc3_:MapClearResultInfo = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         this._mapId = param1.mapId;
         obf_m_a_1577.txtTime.text = obf_l_y_733.getTimeStringHHMMSS(param1.usedTimeInSec * 1000);
         obf_m_a_1577.txtOne.text = "";
         var _loc2_:Array = param1.bestResultList;
         if(Boolean(_loc2_) && _loc2_.length > 0)
         {
            _loc3_ = _loc2_[0] as MapClearResultInfo;
            _loc4_ = "";
            if(_loc3_.players)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc3_.players.split(",").length)
               {
                  _loc4_ += obf_7_6_4416.getRoleLinkA(_loc3_.players.split(",")[_loc5_]);
                  _loc5_++;
               }
            }
            obf_m_a_1577.txtName.htmlText = _loc4_;
            obf_m_a_1577.txtOne.text = obf_l_y_733.getTimeStringHHMMSS(_loc3_.clearTimeInSec * 1000);
         }
         this.playerTimeInv.startTime = getTimer() - param1.usedTimeInSec * 1000;
      }
      
      public function setClearRule(param1:Object, param2:String) : void
      {
         this.obf_c_s_3065();
         if(!param1)
         {
            return;
         }
         this._mapId = param2;
         this._clearRule = param1;
         var _loc3_:Object = JSONUtil.getObject(this._clearRule,["clearMapCond"]);
         if(!_loc3_)
         {
            return;
         }
         if(Boolean(_loc3_["harvestNumber>="]) || Boolean(_loc3_["harvestNumber<="]))
         {
            DiversityManager.setTextField(obf_m_a_1577.txtDeyMon,"passBoxUI","txtHarvest");
         }
         else
         {
            DiversityManager.setTextField(obf_m_a_1577.txtDeyMon,"passBoxUI","txtDeyMon");
         }
         obf_m_a_1577.txtCondition.text = JSONUtil.getStr(this._clearRule,["clearDetail"],"");
         this.refreshTask();
      }
      
      public function obf_c_s_3065() : void
      {
         this._clearRule = null;
         this._mapId = "";
         obf_m_a_1577.txtCondition.text = "";
         obf_m_a_1577.txtMon.text = "";
         txtTimer.text = "";
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"passBoxUI","txtDeyTitle");
         DiversityManager.setTextField(obf_m_a_1577.txtDeyCondition,"passBoxUI","txtDeyCondition");
         DiversityManager.setTextField(obf_m_a_1577.txtDeyTime,"passBoxUI","txtDeyTime");
         DiversityManager.setTextField(obf_m_a_1577.txtDeyOne,"passBoxUI","txtDeyOne");
         DiversityManager.setTextField(obf_m_a_1577.txtDeyName,"passBoxUI","txtDeyName");
         DiversityManager.setTextField(txtCondition,"passBoxUI","txtDeyTime");
      }
      
      public function showUI() : void
      {
         this.visible = true;
         obf_m_a_1577.visible = true;
         bg.visible = true;
         cmdClose.visible = true;
         this.addEventListener(Event.ENTER_FRAME,this.obf_0_7_H_192);
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.removeEventListener(Event.ENTER_FRAME,this.obf_0_7_H_192);
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

