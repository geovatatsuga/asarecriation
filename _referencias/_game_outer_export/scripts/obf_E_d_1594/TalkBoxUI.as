package obf_E_d_1594
{
   import obf_a_F_1055.obf_0_6_b_250;
   import obf_a_F_1055.obf_b_p_3604;
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.netRole.AINpc;
   import com.sunweb.game.rpg.playerUI.IPlayerUI;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.ui.HeadIconCode;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import playerUI.NPCTalkBoxUIMC;
   
   public class TalkBoxUI extends NPCTalkBoxUIMC implements IPlayerUI
   {
      
      private var _talks:Array;
      
      private var obf_m_d_4334:obf_0_6_b_250;
      
      private var obf_j_0_3920:ResourceBag;
      
      public function TalkBoxUI(param1:Array)
      {
         super();
         this._talks = param1;
         this.obf_m_d_4334 = new obf_0_6_b_250();
         DiversityManager.setTextField(this.obf_m_d_4334.txtLabel,"NpcTalkUI","clickToContinue",null,true);
         menuContent.addChild(this.obf_m_d_4334);
         this.x = GameContext.gameStage.stageWidth / 2;
         this.y = GameContext.gameStage.stageHeight / 2 - 50;
         this.addListener();
         this.showTalk();
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
         this.obf_m_d_4334.addEventListener(MouseEvent.CLICK,this.onClickMenu);
         cmdClose.addEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      private function removeListener() : void
      {
         this.obf_m_d_4334.removeEventListener(MouseEvent.CLICK,this.onClickMenu);
         cmdClose.removeEventListener(MouseEvent.CLICK,this.onClose);
      }
      
      private function onClose(param1:Event) : void
      {
         obf_K_e_3075.closeUI(this);
      }
      
      private function onClickMenu(param1:Event) : void
      {
         this.showTalk();
      }
      
      private function showTalk() : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         if(!this._talks || this._talks.length == 0)
         {
            obf_K_e_3075.closeUI(this);
            return;
         }
         var _loc1_:String = this._talks.shift();
         var _loc2_:Boolean = _loc1_.indexOf(":") > -1;
         if(_loc2_)
         {
            _loc4_ = _loc1_.split(":");
            _loc3_ = _loc4_[0];
            _loc1_ = _loc4_[1];
         }
         txtTalkContent.htmlText = _loc1_;
         if(_loc2_)
         {
            this.showNpcHeadIcon(_loc3_);
         }
         else
         {
            this.showPlayerTalkHeadIcon();
         }
      }
      
      public function showNpcHeadIcon(param1:String) : void
      {
         var _loc4_:DisplayObject = null;
         while(npcImage.numChildren > 0)
         {
            npcImage.removeChildAt(0);
         }
         while(playerImage.numChildren > 0)
         {
            playerImage.removeChildAt(0);
         }
         if(obf_L_l_4100.isEmpty(param1))
         {
            return;
         }
         if(param1.indexOf("@") <= -1)
         {
            param1 += "@" + GameContext.currentMap.mapId;
         }
         var _loc2_:Object = obf_b_p_3604.getNpcBrief(param1);
         txtNPCName.text = JSONUtil.getStr(_loc2_,["name"]) + ":";
         var _loc3_:AINpc = GameContext.currentMap.npcSet.getObject(param1.split("@")[0]) as AINpc;
         if(_loc3_)
         {
            _loc4_ = ResourceManager.instance.getDisplayObject(_loc3_.obf_0_5_e_341);
         }
         if(_loc4_)
         {
            npcImage.addChild(_loc4_);
         }
      }
      
      public function showPlayerTalkHeadIcon() : void
      {
         if(!GameContext.localPlayer)
         {
            return;
         }
         txtNPCName.text = GameContext.localPlayer.id + ":";
         var _loc1_:DisplayObject = HeadIconCode.getTalkHeadIconByInt(GameContext.localPlayer.fullInfo.headIconIndex);
         while(npcImage.numChildren > 0)
         {
            npcImage.removeChildAt(0);
         }
         while(playerImage.numChildren > 0)
         {
            playerImage.removeChildAt(0);
         }
         if(_loc1_)
         {
            playerImage.addChild(_loc1_);
         }
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
      }
      
      public function closeUI() : void
      {
         this.visible = false;
         this.destroy();
      }
      
      public function destroy() : void
      {
         this.removeListener();
         while(npcImage.numChildren > 0)
         {
            npcImage.removeChildAt(0);
         }
         while(playerImage.numChildren > 0)
         {
            playerImage.removeChildAt(0);
         }
      }
   }
}

