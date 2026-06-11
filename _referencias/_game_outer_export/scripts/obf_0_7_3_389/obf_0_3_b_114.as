package obf_0_7_3_389
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.map.MapDamageRankInfo;
   import com.sunweb.game.utils.JSONUtil;
   import fl.events.ScrollEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import playerUI.DPSRecorderUIMC;
   
   public class obf_0_3_b_114 extends DPSRecorderUIMC implements IPlayerUI
   {
      
      private var obf_4_5_2615:Array;
      
      private var maxValue:int;
      
      private var obf_c_2_4033:int;
      
      public function obf_0_3_b_114()
      {
         super();
         this.initDiversity();
         titleBox.mouseEnabled = false;
         this.visible = false;
         obf_1_y_4406.pageSize = obf_1_y_4406.height;
         this.x = GameContext.gameStage.stageWidth - 325;
         this.y = 320;
         this.addListener();
      }
      
      private function addListener() : void
      {
         bgBox.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         obf_1_y_4406.addEventListener(ScrollEvent.SCROLL,this.obf_3_S_1490);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function removeListener() : void
      {
         bgBox.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         obf_1_y_4406.removeEventListener(ScrollEvent.SCROLL,this.obf_3_S_1490);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onStartDrag(param1:Event) : void
      {
         this.startDrag();
      }
      
      private function onStopDrag(param1:Event) : void
      {
         this.stopDrag();
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         this.closeUI();
         obf_K_e_3075.showUI(obf_K_e_3075.obf_7_u_1223);
      }
      
      private function obf_3_S_1490(param1:Event) : void
      {
         pointDPS.scrollRect = new Rectangle(0,obf_1_y_4406.scrollPosition,obf_1_y_4406.x - pointDPS.x,obf_1_y_4406.height);
      }
      
      public function setDPSRank(param1:Array) : void
      {
         var _loc4_:Array = null;
         var _loc5_:DPSRecorderBoxUI = null;
         var _loc6_:MapDamageRankInfo = null;
         var _loc7_:DPSRecorderBoxUI = null;
         if(!param1 || param1.length <= 0)
         {
            return;
         }
         this.maxValue = (param1[0] as MapDamageRankInfo).damageValue;
         this.obf_c_2_4033 = (param1[param1.length - 1] as MapDamageRankInfo).damageValue;
         if(!this.obf_4_5_2615)
         {
            this.obf_4_5_2615 = new Array();
         }
         if(this.obf_4_5_2615.length > param1.length)
         {
            _loc4_ = this.obf_4_5_2615.splice(param1.length);
            for each(_loc5_ in _loc4_)
            {
               _loc5_.destroy();
            }
         }
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc6_ = param1[_loc3_] as MapDamageRankInfo;
            if(_loc6_)
            {
               _loc7_ = JSONUtil.getObject(this.obf_4_5_2615,[_loc3_]) as DPSRecorderBoxUI;
               if(!_loc7_)
               {
                  _loc7_ = new DPSRecorderBoxUI();
                  pointDPS.addChild(_loc7_);
                  this.obf_4_5_2615.push(_loc7_);
               }
               _loc7_.showDPSInfo(_loc6_,this.maxValue,this.obf_c_2_4033);
               _loc7_.y = _loc2_;
               _loc2_ += _loc7_.height;
            }
            _loc3_++;
         }
         if(_loc2_ > obf_1_y_4406.height)
         {
            pointDPS.scrollRect = new Rectangle(0,0,obf_1_y_4406.x - pointDPS.x,obf_1_y_4406.height);
            obf_1_y_4406.maxScrollPosition = _loc2_ - obf_1_y_4406.height;
         }
      }
      
      public function setMyDPS(param1:int) : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         barMyDPS.txtPlayer.text = GameContext.localPlayer.id;
         barMyDPS.txtDPS.text = param1 + "K";
         var _loc2_:int = this.maxValue - this.obf_c_2_4033;
         var _loc3_:int = (param1 - this.obf_c_2_4033) / _loc2_ * 100;
         barMyDPS.barDPS.gotoAndStop(_loc3_);
      }
      
      public function obf_1_4_888() : void
      {
         var _loc1_:DPSRecorderBoxUI = null;
         this.maxValue = 0;
         this.obf_c_2_4033 = 0;
         for each(_loc1_ in this.obf_4_5_2615)
         {
            _loc1_.destroy();
         }
         this.obf_4_5_2615 = null;
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
         DiversityManager.setTextField(txtDeyTitle,"MapDPSUI","txtTitle");
      }
      
      public function showUI() : void
      {
         this.visible = true;
      }
      
      public function closeUI() : void
      {
         this.visible = false;
      }
      
      public function destroy() : void
      {
         this.removeListener();
         this.obf_1_4_888();
      }
   }
}

