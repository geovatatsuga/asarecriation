package com.sunweb.game.rpg.playerUI.systems
{
   import ControlClass.MJCheckBox;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.map.Map;
   import com.sunweb.game.rpg.netRole.RemotePlayer;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.StatusButton;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.sound.obf_q_6_3634;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.utils.JSONUtil;
   import fl.events.ScrollEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import playerUI.SystemSettingBoxUIMC;
   
   public class obf_i_w_3105 extends SystemSettingBoxUIMC implements IPlayerUI
   {
      
      private var inited:Boolean;
      
      private var flagMap:Object;
      
      public var openEffMap:Object;
      
      public function obf_i_w_3105()
      {
         super();
         this.initDiversity();
         this.x = GameContext.gameStage.stageWidth / 2 + 250;
         this.y = GameContext.gameStage.stageHeight / 2;
         this.visible = false;
         titleBox.mouseEnabled = false;
         obf_t_n_1765.pageSize = obf_t_n_1765.height;
         scrollMaxPlayers.minScrollPosition = 5;
         scrollMaxPlayers.maxScrollPosition = 50;
         scrollMaxPlayers.pageSize = 5;
         scrollMaxPlayers.drawNow();
         obf_n_C_3824.maxScrollPosition = 100;
         static.maxScrollPosition = 100;
         obf_n_C_3824.pageSize = 10;
         static.pageSize = 10;
         obf_n_C_3824.drawNow();
         static.drawNow();
         this.initCheckBook();
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
         DiversityManager.setTextField(txtDeyTitle,"SystemOption","txtTitle");
         DiversityManager.setTextField(txtDeyEffect,"SystemOption","txtGameEffect");
         DiversityManager.setTextField(txtDeyControl,"SystemOption","txtGameControl");
         DiversityManager.setTextField(txtDeyShowPlayersCount,"SystemOption","txtMaxPlayersCount");
         DiversityManager.setTextField(txtDeySound,"SystemOption","txtSound");
         DiversityManager.setTextField(txtDeyGameMuisc,"SystemOption","txtMusicVolume");
         DiversityManager.setTextField(txtDeyGameEffectSound,"SystemOption","txtEffectSoundVolume");
         chkAutoPressRide.label = DiversityManager.getString("SystemOption","txtAutoPressRide");
         chkClickAttack.label = DiversityManager.getString("SystemOption","chkClickAttack");
         chkDisConfirmBox.label = DiversityManager.getString("SystemOption","chkDisConfirmBox");
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
         scrollMaxPlayers.addEventListener(ScrollEvent.SCROLL,this.obf_0_6_M_179);
         obf_n_C_3824.addEventListener(ScrollEvent.SCROLL,this.obf_0_0_684);
         static.addEventListener(ScrollEvent.SCROLL,this.obf_a_P_4287);
         chkAutoPressRide.addEventListener(MouseEvent.CLICK,this.obf_0_3_5_470);
         chkClickAttack.addEventListener(MouseEvent.CLICK,this.obf_0___p_698);
         chkDisConfirmBox.addEventListener(MouseEvent.CLICK,this.obf_y_F_744);
         obf_t_n_1765.addEventListener(ScrollEvent.SCROLL,this.onScrollList);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
         scrollMaxPlayers.removeEventListener(ScrollEvent.SCROLL,this.obf_0_6_M_179);
         obf_n_C_3824.removeEventListener(ScrollEvent.SCROLL,this.obf_0_0_684);
         static.removeEventListener(ScrollEvent.SCROLL,this.obf_a_P_4287);
         chkAutoPressRide.removeEventListener(MouseEvent.CLICK,this.obf_0_3_5_470);
         chkClickAttack.removeEventListener(MouseEvent.CLICK,this.obf_0___p_698);
         chkDisConfirmBox.removeEventListener(MouseEvent.CLICK,this.obf_y_F_744);
         obf_t_n_1765.removeEventListener(ScrollEvent.SCROLL,this.onScrollList);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onScrollList(param1:Event) : void
      {
         effectMC.scrollRect = new Rectangle(0,obf_t_n_1765.scrollPosition,obf_t_n_1765.x - effectMC.x,obf_t_n_1765.height - 5);
      }
      
      private function initCheckBook() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:MJCheckBox = null;
         this.flagMap = new Object();
         this.openEffMap = new Object();
         var _loc1_:Array = WorldConfig.getObjectSetting("effectCommand") as Array;
         effectMC.scrollRect = new Rectangle(0,0,obf_t_n_1765.x - effectMC.x,obf_t_n_1765.height - 5);
         for each(_loc3_ in _loc1_)
         {
            if(_loc3_)
            {
               _loc4_ = new MJCheckBox();
               _loc4_.width = 200;
               _loc4_.label = _loc3_.effect;
               _loc4_.name = JSONUtil.getStr(_loc3_,["coverFlag"]);
               this.flagMap[_loc3_.coverFlag] = _loc4_;
               this.openEffMap[_loc3_.coverFlag] = false;
               _loc4_.addEventListener(MouseEvent.CLICK,this.obf_0_7_l_231);
               effectMC.addChild(_loc4_);
               _loc4_.y += _loc2_;
               _loc2_ += 22;
            }
         }
         if(_loc2_ > obf_t_n_1765.height)
         {
            obf_t_n_1765.maxScrollPosition = _loc2_ - obf_t_n_1765.height;
            obf_t_n_1765.visible = true;
         }
         else
         {
            obf_t_n_1765.visible = false;
         }
      }
      
      private function obf_Y_V_4544(param1:MouseEvent) : void
      {
      }
      
      public function updataHpMp(param1:Boolean, param2:Boolean) : void
      {
      }
      
      public function init() : void
      {
         if(!GameContext.userConfig || !GameContext.localPlayer)
         {
            return;
         }
         if(!GameContext.userConfig.sst)
         {
            GameContext.userConfig.sst = new Object();
            GameContext.userConfig.sst.mpn = 20;
            GameContext.saveConfig();
         }
         if(!GameContext.userConfig.sst.hasOwnProperty("cat"))
         {
            GameContext.userConfig.sst.cat = true;
            GameContext.saveConfig();
         }
         chkClickAttack.selected = JSONUtil.getBoolean(GameContext.userConfig,["sst","cat"]);
         txtMaxPlayers.text = GameContext.userConfig.sst.mpn + "";
         scrollMaxPlayers.scrollPosition = GameContext.userConfig.sst.mpn;
         if(obf_K_e_3075.smallMapUI.getStatus == StatusButton.STATUS_1)
         {
            Map.obf_0_2_l_577 = 0;
         }
         else
         {
            Map.obf_0_2_l_577 = GameContext.userConfig.sst.mpn;
         }
         obf_q_6_3634.obf_T_T_4349.volume = JSONUtil.getNumber(GameContext.userConfig,["sst","smv"],0.5);
         obf_q_6_3634.obf_G_y_2255.volume = JSONUtil.getNumber(GameContext.userConfig,["sst","ssv"],0.7);
         obf_q_6_3634.updateMusicVolume();
         this.inited = true;
      }
      
      public function showEffectCommand() : void
      {
         var _loc1_:String = null;
         var _loc2_:MJCheckBox = null;
         var _loc3_:RemotePlayer = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:DisplayObject = null;
         var _loc7_:DisplayObject = null;
         for(_loc1_ in this.flagMap)
         {
            _loc2_ = this.flagMap[_loc1_] as MJCheckBox;
            _loc2_.selected = GameContext.userConfig.sst[_loc1_];
            this.openEffMap[_loc1_] = _loc2_.selected;
            if(GameContext.localPlayer)
            {
               _loc4_ = GameContext.localPlayer.flagMap[_loc1_] as DisplayObject;
               if(_loc4_)
               {
                  _loc4_.visible = !_loc2_.selected;
               }
               if(Boolean(GameContext.localPlayer.petFullInfo) && Boolean(GameContext.localPlayer.obf_y_G_2458))
               {
                  _loc5_ = GameContext.localPlayer.obf_y_G_2458.flagMap[_loc1_] as DisplayObject;
                  if(_loc5_)
                  {
                     _loc5_.visible = !_loc2_.selected;
                  }
               }
            }
            if(!GameContext.currentMap)
            {
               return;
            }
            for each(_loc3_ in GameContext.currentMap.remotePlayerSet.obf_3_C_4291)
            {
               if(_loc3_)
               {
                  _loc6_ = _loc3_.flagMap[_loc2_.name] as DisplayObject;
                  if(_loc6_)
                  {
                     if(obf_K_e_3075.smallMapUI.getStatus == StatusButton.STATUS_1)
                     {
                        _loc6_.visible = false;
                     }
                     else
                     {
                        _loc6_.visible = !_loc2_.selected;
                     }
                     if(Boolean(_loc3_.obf_I_0_1698.pet) && Boolean(_loc3_.obf_y_G_2458))
                     {
                        _loc7_ = _loc3_.obf_y_G_2458.flagMap[_loc2_.name] as DisplayObject;
                        if(_loc7_)
                        {
                           _loc7_.visible = !_loc2_.selected;
                        }
                     }
                  }
               }
            }
         }
      }
      
      private function obf_0_7_l_231(param1:MouseEvent) : void
      {
         var _loc4_:RemotePlayer = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:DisplayObject = null;
         var _loc7_:DisplayObject = null;
         var _loc2_:MJCheckBox = param1.currentTarget as MJCheckBox;
         if(!_loc2_ || !GameContext.localPlayer || !GameContext.currentMap)
         {
            return;
         }
         this.openEffMap[_loc2_.name] = _loc2_.selected;
         var _loc3_:DisplayObject = GameContext.localPlayer.flagMap[_loc2_.name] as DisplayObject;
         if(_loc3_)
         {
            _loc3_.visible = !_loc2_.selected;
         }
         if(Boolean(GameContext.localPlayer.petFullInfo) && Boolean(GameContext.localPlayer.obf_y_G_2458))
         {
            _loc5_ = GameContext.localPlayer.obf_y_G_2458.flagMap[_loc2_.name] as DisplayObject;
            if(_loc5_)
            {
               _loc5_.visible = !_loc2_.selected;
            }
         }
         for each(_loc4_ in GameContext.currentMap.remotePlayerSet.obf_3_C_4291)
         {
            if(_loc4_)
            {
               _loc6_ = _loc4_.flagMap[_loc2_.name] as DisplayObject;
               if(_loc6_)
               {
                  _loc6_.visible = !_loc2_.selected;
                  if(Boolean(_loc4_.obf_I_0_1698.pet) && Boolean(_loc4_.obf_y_G_2458))
                  {
                     _loc7_ = _loc4_.obf_y_G_2458.flagMap[_loc2_.name] as DisplayObject;
                     if(_loc7_)
                     {
                        _loc7_.visible = !_loc2_.selected;
                     }
                  }
               }
            }
         }
         GameContext.userConfig.sst[_loc2_.name] = _loc2_.selected;
         GameContext.saveConfig();
      }
      
      private function obf_0_6_M_179(param1:ScrollEvent) : void
      {
         var _loc2_:int = param1.position;
         GameContext.userConfig.sst.mpn = _loc2_;
         txtMaxPlayers.text = _loc2_ + "";
         GameContext.saveConfig();
         if(Map.obf_0_2_l_577 > 0 && Boolean(GameContext.currentMap))
         {
            Map.obf_0_2_l_577 = _loc2_;
            GameContext.currentMap.limitRemotePlayerNumber(Map.obf_0_2_l_577);
         }
      }
      
      private function obf_0_0_684(param1:Event) : void
      {
         obf_q_6_3634.obf_T_T_4349.volume = obf_n_C_3824.scrollPosition / 100;
         obf_q_6_3634.updateMusicVolume();
         txtMusic.text = int(obf_q_6_3634.obf_T_T_4349.volume * 100) + "%";
         GameContext.userConfig.sst.smv = obf_q_6_3634.obf_T_T_4349.volume;
         GameContext.saveConfig();
      }
      
      private function obf_a_P_4287(param1:Event) : void
      {
         obf_q_6_3634.obf_G_y_2255.volume = static.scrollPosition / 100;
         txtSound.text = int(obf_q_6_3634.obf_G_y_2255.volume * 100) + "%";
         GameContext.userConfig.sst.ssv = obf_q_6_3634.obf_G_y_2255.volume;
         GameContext.saveConfig();
      }
      
      private function obf_0_3_5_470(param1:Event) : void
      {
         GameContext.userConfig.sst.apr = chkAutoPressRide.selected;
         GameContext.saveConfig();
      }
      
      private function obf_0___p_698(param1:Event) : void
      {
         GameContext.userConfig.sst.cat = chkClickAttack.selected;
         GameContext.saveConfig();
      }
      
      private function obf_y_F_744(param1:Event) : void
      {
         GameContext.userConfig.sst.cdcb = chkDisConfirmBox.selected;
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      public function get mouseOn() : Boolean
      {
         if(this.visible)
         {
            return this.getBounds(this).contains(this.mouseX,this.mouseY);
         }
         return false;
      }
      
      public function showUI() : void
      {
         this.visible = true;
         chkAutoPressRide.selected = JSONUtil.getBoolean(GameContext.userConfig,["sst","apr"]);
         scrollMaxPlayers.scrollPosition = GameContext.userConfig.sst.mpn;
         obf_n_C_3824.scrollPosition = obf_q_6_3634.obf_T_T_4349.volume * 100;
         static.scrollPosition = obf_q_6_3634.obf_G_y_2255.volume * 100;
         txtMusic.text = int(obf_q_6_3634.obf_T_T_4349.volume * 100) + "%";
         txtSound.text = int(obf_q_6_3634.obf_G_y_2255.volume * 100) + "%";
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
      }
   }
}

