package obf_V_n_3191
{
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.equ.EquipmentKind;
   import com.sunweb.game.rpg.iconItem.IconItemBag;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.equ.PlayerEquipDurCheckNotify;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import playerUI.EquipLowDurUIMC;
   
   public class obf_D_v_4539 extends EquipLowDurUIMC implements IPlayerUI
   {
      
      private var obf_Z_z_1731:Object;
      
      public function obf_D_v_4539()
      {
         super();
         this.cacheAsBitmap = true;
         this.visible = false;
         this.onResize(null);
         this.obf_Z_z_1731 = {
            (EquipmentKind.HAT + ""):hat,
            (EquipmentKind.CLOTHES + ""):clothes,
            (EquipmentKind.WEAPON + ""):weapon,
            (EquipmentKind.GLOVE + ""):glove,
            (EquipmentKind.SHOES + ""):shoes,
            (EquipmentKind.SHIELD + ""):shield,
            (EquipmentKind.AMULET + ""):amulet,
            (EquipmentKind.RING + ""):ring
         };
         hat.gotoAndStop(1);
         clothes.gotoAndStop(1);
         weapon.gotoAndStop(1);
         glove.gotoAndStop(1);
         shoes.gotoAndStop(1);
         shield.gotoAndStop(1);
         amulet.gotoAndStop(1);
         ring.gotoAndStop(1);
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
         this.addEventListener(MouseEvent.CLICK,this.onClick);
         GameContext.gameStage.addEventListener(Event.RESIZE,this.onResize);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(MouseEvent.CLICK,this.onClick);
         GameContext.gameStage.removeEventListener(Event.RESIZE,this.onResize);
      }
      
      private function onResize(param1:Event) : void
      {
         this.x = GameContext.gameStage.stageWidth - 270;
         this.y = 100;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(!GameContext.currentMap)
         {
            return;
         }
         var _loc2_:Point = GameContext.currentMap.globalToLocal(new Point(param1.stageX,param1.stageY));
         var _loc3_:MouseEvent = param1.clone() as MouseEvent;
         _loc3_.localX = _loc2_.x;
         _loc3_.localY = _loc2_.y;
         GameContext.currentMap.dispatchEvent(_loc3_);
      }
      
      public function checkEquDur(param1:PlayerEquipDurCheckNotify) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         var _loc4_:IconItemBag = null;
         var _loc5_:int = 0;
         for(_loc3_ in this.obf_Z_z_1731)
         {
            (this.obf_Z_z_1731[_loc3_] as MovieClip).gotoAndStop(1);
            _loc4_ = obf_K_e_3075.playerFullInfoUI.getEquipBagByKind(int(_loc3_));
            if(!(!_loc4_ || !_loc4_.haveIconItem))
            {
               _loc5_ = JSONUtil.getInt(param1.equipmentDurMap,[_loc4_.haveIconItem.itemId]);
               if(_loc5_ > 0)
               {
                  _loc2_ = true;
                  (this.obf_Z_z_1731[_loc3_] as MovieClip).gotoAndStop(_loc5_ + 1);
               }
            }
         }
         if(_loc2_)
         {
            if(!this.visible)
            {
               obf_K_e_3075.showUI(this);
            }
         }
         else if(this.visible)
         {
            obf_K_e_3075.closeUI(this);
         }
      }
      
      public function get mouseOn() : Boolean
      {
         return false;
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
      }
   }
}

