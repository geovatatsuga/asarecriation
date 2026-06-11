package com.sunweb.game.rpg.module.CreateRole
{
   import obf_g_A_3629.obf_r_Y_1874;
   import obf_o_M_4577.obf_l_N_3214;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_0_1_2695;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.module.LoginModule;
   import com.sunweb.game.rpg.module.RoleListModule;
   import com.sunweb.game.rpg.netRole.obf_Y_E_3667;
   import com.sunweb.game.rpg.role.RoleBaseInfo;
   import com.sunweb.game.rpg.role.obf_I_5_1944;
   import com.sunweb.game.rpg.roleZone.RoleEventType;
   import com.sunweb.game.rpg.roleZone.command.CreateRoleAnswer;
   import com.sunweb.game.rpg.roleZone.command.CreateRoleRequest;
   import com.sunweb.game.rpg.sound.obf_q_6_3634;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.ui.HeadIconCode;
   import com.sunweb.game.ui.IWindow;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import mmorpg.CreateRoleUI;
   
   public class obf_E_9_2246 extends CreateRoleUI implements IWindow
   {
      
      private var _sex:int = 0;
      
      private var obf_r_T_2852:int;
      
      private var _headIconIndex:int = 1;
      
      private var _roleName:String;
      
      private var obf_V_A_1226:DisplayObject;
      
      private var _hairIndex:int;
      
      private var obf_l_D_4435:int;
      
      private var jobObject:Object;
      
      private var jobIconLightList:Array;
      
      private var jobIconObj:Object;
      
      private var selectedJobIcon:DisplayObject;
      
      private var headIconList:Array;
      
      private var obf_r_c_1537:GlowFilter;
      
      private var showOtherPlayerTimeInv:TimeLimiter;
      
      private var hairStyleList:Array;
      
      public function obf_E_9_2246()
      {
         var headListSex1:Array;
         var s1:int;
         var headListSex0:Array;
         var s0:int;
         var headImg1:DisplayObject = null;
         var newHeadIconSex1:obf_i_j_3962 = null;
         var headImg0:DisplayObject = null;
         var newHeadIconSex0:obf_i_j_3962 = null;
         this.obf_r_c_1537 = new GlowFilter(16777215,1,10,10,3);
         super();
         this.initDiversity();
         this.jobIconLightList = [icon_p,icon_e,icon_k,icon_f,icon_r,icon_t,icon_d];
         this.jobIconObj = {
            (obf_I_5_1944.obf_y_D_2468 + ""):jobIcon_Paladin,
            (obf_I_5_1944.obf_e_w_3507 + ""):jobIcon_Elf,
            (obf_I_5_1944.obf_A_t_4218 + ""):jobIcon_Killer,
            (obf_I_5_1944.obf_k_L_3388 + ""):jobIcon_Fairy,
            (obf_I_5_1944.obf_b_Q_2292 + ""):jobIcon_Priest,
            (obf_I_5_1944.obf_0_1_133 + ""):jobIcon_Trainer,
            (obf_I_5_1944.obf_U_K_1768 + ""):jobIcon_Druid
         };
         if(!GameContext.worldClient.isConnected || !GameContext.worldClient.online)
         {
            this.onBack(null);
         }
         this.headIconList = new Array();
         headListSex1 = HeadIconCode.getHeadIconCodeArray(1);
         s1 = 1;
         while(s1 < headListSex1.length)
         {
            headImg1 = HeadIconCode.getHeadIcon(headListSex1[s1]);
            newHeadIconSex1 = new obf_i_j_3962(headImg1);
            newHeadIconSex1.headCode = int(headListSex1[s1]);
            newHeadIconSex1.sex = 1;
            newHeadIconSex1.x = (s1 - 1) * 66;
            pointHeadSex1.addChild(newHeadIconSex1);
            this.headIconList.push(newHeadIconSex1);
            s1++;
         }
         headListSex0 = HeadIconCode.getHeadIconCodeArray(0);
         s0 = 1;
         while(s0 < headListSex0.length)
         {
            headImg0 = HeadIconCode.getHeadIcon(headListSex0[s0]);
            newHeadIconSex0 = new obf_i_j_3962(headImg0);
            newHeadIconSex0.headCode = int(headListSex0[s0]);
            newHeadIconSex0.sex = 0;
            newHeadIconSex0.x = (s0 - 1) * 66;
            pointHeadSex0.addChild(newHeadIconSex0);
            this.headIconList.push(newHeadIconSex0);
            s0++;
         }
         this.setRoleData(obf_I_5_1944.obf_y_D_2468,0,HeadIconCode.getHeadIconCode(1,this._sex));
         this.updateJobImage();
         cmdMusic.gotoAndStop(obf_q_6_3634.obf_T_T_4349.volume > 0 ? 1 : 2);
         cmdRandomName.visible = !WorldConfig.getValue("functionSwitch","fastAutoName");
         this.obf_H_6_3689(null);
         try
         {
            obf_H_l_800.call("onCreateRole");
         }
         catch(e:Error)
         {
         }
         this.addListener();
      }
      
      public function get uiIndex() : int
      {
         return -1;
      }
      
      public function initDiversity() : void
      {
      }
      
      private function addListener() : void
      {
         var _loc1_:obf_i_j_3962 = null;
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdOK.addEventListener(MouseEvent.CLICK,this.onCreateRole);
         cmdBack.addEventListener(MouseEvent.CLICK,this.onBack);
         cmdMusic.addEventListener(MouseEvent.CLICK,this.obf_l_k_4340);
         cmdRandomName.addEventListener(MouseEvent.CLICK,this.obf_H_6_3689);
         inputName.addEventListener(MouseEvent.CLICK,this.obf_v_a_r_4628);
         jobIcon_Paladin.addEventListener(MouseEvent.CLICK,this.obf_v_i_1958);
         jobIcon_Killer.addEventListener(MouseEvent.CLICK,this.obf_v_i_1958);
         jobIcon_Elf.addEventListener(MouseEvent.CLICK,this.obf_v_i_1958);
         jobIcon_Fairy.addEventListener(MouseEvent.CLICK,this.obf_v_i_1958);
         jobIcon_Priest.addEventListener(MouseEvent.CLICK,this.obf_v_i_1958);
         jobIcon_Trainer.addEventListener(MouseEvent.CLICK,this.obf_v_i_1958);
         jobIcon_Druid.addEventListener(MouseEvent.CLICK,this.obf_v_i_1958);
         for each(_loc1_ in this.headIconList)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.obf_V_h_3290);
         }
         GameContext.worldClient.addEventListener(RoleEventType.CREATE_ROLE_ANSWER,this.obf_w_2819);
         GameContext.worldClient.addEventListener(obf_l_N_3214.obf_N_7_3895,this.onDisconnected);
      }
      
      private function removeListener() : void
      {
         var _loc1_:obf_i_j_3962 = null;
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         cmdOK.removeEventListener(MouseEvent.CLICK,this.onCreateRole);
         cmdBack.removeEventListener(MouseEvent.CLICK,this.onBack);
         cmdMusic.removeEventListener(MouseEvent.CLICK,this.obf_l_k_4340);
         cmdRandomName.removeEventListener(MouseEvent.CLICK,this.obf_H_6_3689);
         inputName.removeEventListener(MouseEvent.CLICK,this.obf_v_a_r_4628);
         jobIcon_Paladin.removeEventListener(MouseEvent.CLICK,this.obf_v_i_1958);
         jobIcon_Killer.removeEventListener(MouseEvent.CLICK,this.obf_v_i_1958);
         jobIcon_Elf.removeEventListener(MouseEvent.CLICK,this.obf_v_i_1958);
         jobIcon_Fairy.removeEventListener(MouseEvent.CLICK,this.obf_v_i_1958);
         jobIcon_Priest.removeEventListener(MouseEvent.CLICK,this.obf_v_i_1958);
         jobIcon_Trainer.removeEventListener(MouseEvent.CLICK,this.obf_v_i_1958);
         jobIcon_Druid.removeEventListener(MouseEvent.CLICK,this.obf_v_i_1958);
         for each(_loc1_ in this.headIconList)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.obf_V_h_3290);
         }
         GameContext.worldClient.removeEventListener(RoleEventType.CREATE_ROLE_ANSWER,this.obf_w_2819);
         GameContext.worldClient.removeEventListener(obf_l_N_3214.obf_N_7_3895,this.onDisconnected);
      }
      
      private function onAddToStage(param1:Event) : void
      {
         this.x = this.stage.stageWidth / 2;
         this.y = this.stage.stageHeight / 2;
      }
      
      private function obf_l_k_4340(param1:Event) : void
      {
         if(obf_q_6_3634.obf_T_T_4349.volume > 0)
         {
            obf_q_6_3634.obf_T_T_4349.volume = 0;
            cmdMusic.gotoAndStop(2);
         }
         else
         {
            obf_q_6_3634.obf_T_T_4349.volume = 0.5;
            cmdMusic.gotoAndStop(1);
         }
         obf_q_6_3634.updateMusicVolume();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(!this.showOtherPlayerTimeInv || this.showOtherPlayerTimeInv.checkTimeout())
         {
            _loc2_ = DiversityManager.getString("CreateRolePage","otherPlayer").split(",");
            if(Boolean(_loc2_) && _loc2_.length > 0)
            {
               _loc3_ = _loc2_[int(Math.random() * _loc2_.length)];
            }
            _loc4_ = DiversityManager.getString("CreateRolePage","cityList").split(",");
            _loc5_ = decodeURI(obf_r_8_1121.getParameter(["country"]));
            if(Boolean(_loc4_) && Boolean(_loc4_.length > 0) && !obf_L_l_4100.isEmpty(_loc5_))
            {
               _loc6_ = Math.random() > 0.5 ? _loc5_ : _loc4_[int(Math.random() * _loc4_.length)];
            }
            _loc7_ = obf_I_5_1944.getJobShowName(int(Math.random() * 5));
            if(!obf_L_l_4100.isEmpty(_loc3_) && !obf_L_l_4100.isEmpty(_loc6_))
            {
               txtOtherPlayer.htmlText += DiversityManager.getString("CreateRolePage","otherPlayerInto",[_loc6_,_loc3_,_loc7_]) + "\n";
               txtOtherPlayer.scrollV = txtOtherPlayer.bottomScrollV;
            }
            this.showOtherPlayerTimeInv = new TimeLimiter(1000 + Math.random() * 2000);
         }
      }
      
      private function obf_V_h_3290(param1:Event) : void
      {
         var _loc2_:obf_i_j_3962 = param1.currentTarget as obf_i_j_3962;
         if(!_loc2_)
         {
            return;
         }
         this.setRoleData(this.obf_l_D_4435,_loc2_.sex,_loc2_.headCode);
         this.obf_H_6_3689(null);
      }
      
      private function obf_H_6_3689(param1:Event) : void
      {
         if(!cmdRandomName.visible)
         {
            return;
         }
         inputName.text = DiversityManager.getRandomName(this._sex);
      }
      
      private function obf_v_a_r_4628(param1:Event) : void
      {
         inputName.text = "";
      }
      
      private function obf_q_2_3827(param1:Event) : void
      {
      }
      
      private function setJobHairStyleList(param1:int, param2:int) : void
      {
         this.hairStyleList = obf_Y_E_3667.getHairModelList(param1,param2);
         this._hairIndex = 0;
      }
      
      private function obf_v_i_1958(param1:Event) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in this.jobIconObj)
         {
            if(param1.currentTarget == this.jobIconObj[_loc2_])
            {
               this.setJob(int(_loc2_));
               return;
            }
         }
      }
      
      private function setJob(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.jobIconLightList.length)
         {
            (this.jobIconLightList[_loc2_] as MovieClip).mouseEnabled = false;
            (this.jobIconLightList[_loc2_] as MovieClip).visible = _loc2_ == param1;
            _loc2_++;
         }
         this.obf_l_D_4435 = param1;
         this.updateJobImage();
      }
      
      private function setRoleData(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:obf_i_j_3962 = null;
         var _loc4_:int = 0;
         while(_loc4_ < this.jobIconLightList.length)
         {
            (this.jobIconLightList[_loc4_] as MovieClip).mouseEnabled = false;
            (this.jobIconLightList[_loc4_] as MovieClip).visible = _loc4_ == param1;
            _loc4_++;
         }
         if(this.obf_l_D_4435 != param1 || this._sex != param2)
         {
            _loc5_ = true;
         }
         for each(_loc6_ in this.headIconList)
         {
            _loc6_.isOn = _loc6_.headCode == param3 && _loc6_.sex == param2;
         }
         this.obf_l_D_4435 = param1;
         this._sex = param2;
         this.obf_r_T_2852 = param3;
         if(_loc5_)
         {
            this.updateJobImage();
         }
      }
      
      private function updateJobImage() : void
      {
         while(pointJobPic.numChildren > 0)
         {
            pointJobPic.removeChildAt(0);
         }
         var _loc1_:DisplayObject = obf_I_5_1944.getJobImage(this.obf_l_D_4435,this._sex);
         if(_loc1_)
         {
            _loc1_.scaleX = 0.8;
            _loc1_.scaleY = 0.8;
            pointJobPic.addChild(_loc1_);
         }
         var _loc2_:Array = [obf_L_q_1345,obf_6_u_2598,obf_0_3_O_98,obf_U_Y_3153,jobPrompt_r,obf_0_9_8_401,jobPrompt_d];
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            (_loc2_[_loc3_] as MovieClip).visible = this.obf_l_D_4435 == _loc3_;
            _loc3_++;
         }
      }
      
      private function onCreateRole(param1:Event) : void
      {
         var _loc5_:CreateRoleRequest = null;
         var _loc2_:String = obf_L_l_4100.obf_I_C_3435(inputName.text);
         if(_loc2_ == "")
         {
            WindowManager.showMessageBox(DiversityManager.getString("CreateRolePage","promptNoName"));
            return;
         }
         if(Boolean(_loc2_) && _loc2_.length > WorldConfig.obf_j_U_2460)
         {
            WindowManager.showMessageBox(DiversityManager.getString("CreateRolePage","promptNameTooLang"));
            return;
         }
         if(!obf_L_l_4100.checkNameString(_loc2_))
         {
            WindowManager.showMessageBox(DiversityManager.getString("CreateRolePage","promptNameHaveSymbol"));
            return;
         }
         var _loc3_:String = DiversityManager.getString("CreateRolePage","nameScope");
         if(!obf_L_l_4100.isEmpty(_loc3_) && !obf_L_l_4100.obf_6_d_4028(_loc2_,_loc3_))
         {
            WindowManager.showMessageBox(DiversityManager.getString("CreateRolePage","promptInvalidName"));
            return;
         }
         if(obf_r_Y_1874.isUnlawful(_loc2_))
         {
            WindowManager.showMessageBox(DiversityManager.getString("CreateRolePage","promptInvalidName"));
            return;
         }
         this._roleName = _loc2_;
         var _loc4_:RoleBaseInfo = new RoleBaseInfo();
         _loc4_.name = this._roleName;
         _loc4_.sex = this._sex;
         _loc4_.jobCode = this.obf_l_D_4435;
         _loc4_.headIconIndex = this.obf_r_T_2852;
         _loc4_.hairStyleIndex = this._hairIndex;
         if(GameContext.worldClient.isConnected && GameContext.worldClient.online)
         {
            _loc5_ = new CreateRoleRequest();
            _loc5_.role = _loc4_;
            _loc5_.landCode = "";
            GameContext.worldClient.sendCommand(_loc5_);
            cmdOK.enabled = false;
         }
      }
      
      private function obf_w_2819(param1:obf_0_1_2695) : void
      {
         var cmd:CreateRoleAnswer;
         var e:obf_0_1_2695 = param1;
         cmdOK.enabled = true;
         cmd = e.cmd as CreateRoleAnswer;
         if(cmd.role)
         {
            try
            {
               obf_H_l_800.call("onCreateRoleComplete",cmd.role.name);
            }
            catch(e:Error)
            {
            }
            GameContext.autoSelectRole = cmd.role.name;
            this.onBack(null);
         }
         else
         {
            WindowManager.showMessageBox(cmd.failureReason);
         }
      }
      
      private function onBack(param1:Event) : void
      {
         WindowManager.closeWindow(this);
         WindowManager.showWindow(new RoleListModule());
      }
      
      private function onDisconnected(param1:obf_l_N_3214) : void
      {
         WindowManager.showMessageBox(DiversityManager.getString("SystemPrompt","disconnected"),GameContext.ssoFailed);
         if(GameContext.isSso())
         {
            return;
         }
         WindowManager.closeWindow(this);
         WindowManager.showWindow(new LoginModule());
      }
      
      public function destroy() : void
      {
         this.removeListener();
         while(pointJobPic.numChildren > 0)
         {
            pointJobPic.removeChildAt(0);
         }
      }
   }
}

