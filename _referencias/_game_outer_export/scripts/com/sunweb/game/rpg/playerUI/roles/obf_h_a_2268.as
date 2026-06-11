package com.sunweb.game.rpg.playerUI.roles
{
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.role.RoleSystemInfo;
   import com.sunweb.game.rpg.role.obf_I_5_1944;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.RoleListBoxUIMC;
   
   public class obf_h_a_2268 extends RoleListBoxUIMC
   {
      
      private var _selected:Boolean;
      
      private var _info:RoleSystemInfo;
      
      private var maxWidth:int = 400;
      
      private var maxHeight:int = 400;
      
      public function obf_h_a_2268(param1:RoleSystemInfo)
      {
         super();
         this.doubleClickEnabled = true;
         this.mouseChildren = false;
         this._info = param1;
         txtRoleName.text = param1.name;
         txtRoleLevel.text = "Lv " + param1.level;
         txtRoleJob.text = obf_I_5_1944.getJobShowName(param1.jobCode);
         if(param1.deletedFlag)
         {
            DiversityManager.setTextField(txtRoleName,"RoleListPage","roleWillDelete",[param1.name,param1.willDeleteTime],true);
            txtRoleName.textColor = 16711680;
         }
         var _loc2_:DisplayObject = obf_I_5_1944.getJobImage(param1.jobCode,param1.sex);
         if(_loc2_)
         {
            pointJobImage.addChild(_loc2_);
         }
         this.obf_H_g_1470(null);
         this.selected = false;
         this.addListener();
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
         this.gotoAndStop(this._selected ? 2 : 1);
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function get roleInfo() : RoleSystemInfo
      {
         return this._info;
      }
      
      private function addListener() : void
      {
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         pointJobImage.addEventListener(Event.ADDED,this.obf_H_g_1470);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         pointJobImage.removeEventListener(Event.ADDED,this.obf_H_g_1470);
      }
      
      private function obf_H_g_1470(param1:Event) : void
      {
         var _loc2_:Number = 1;
         var _loc3_:Number = 1;
         if(pointJobImage.height > this.maxHeight)
         {
            _loc3_ = this.maxHeight / pointJobImage.height;
         }
         if(pointJobImage.width > this.maxWidth)
         {
            _loc2_ = this.maxWidth / pointJobImage.width;
         }
         pointJobImage.scaleX = Math.min(_loc2_,_loc3_);
         pointJobImage.scaleY = Math.min(_loc2_,_loc3_);
      }
      
      private function onMouseOver(param1:Event) : void
      {
         if(this._selected)
         {
            return;
         }
         this.gotoAndStop(2);
      }
      
      private function onMouseOut(param1:Event) : void
      {
         if(this._selected)
         {
            return;
         }
         this.gotoAndStop(this._selected ? 2 : 1);
      }
      
      public function destroy() : void
      {
         this._info = null;
         this.removeListener();
      }
   }
}

